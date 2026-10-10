"""Read-only Bohao exports and verified handoff to the persistent bridge."""

import csv
import hashlib
import io
import json
import shutil
import sqlite3
import time
import uuid
import zipfile
from contextlib import contextmanager
from datetime import UTC, datetime
from decimal import Decimal

from .mapping import (
    MappingError,
    base_price,
    catalogue_source,
    customer_payload,
    external_id,
    product_payload,
    scaled,
)
from .state import canonical

MAX_ROWS = 45_000
MAX_BYTES = 8_000_000


@contextmanager
def _handoff_database(path):
    """Commit/rollback the handoff transaction and always release the SQLite handle."""
    db = sqlite3.connect(path)
    try:
        with db:
            yield db
    finally:
        db.close()


def category_rows(bohao, settings):
    taxes = {r["IVAID"]: r for r in bohao.rows("ivatipo", "IVAID")}
    pending = list(bohao.rows("articuloclase", "ClaseID"))
    names = {}
    for row in pending:
        name = row.get("NombreES") or row.get("Nombre") or str(row["ClaseID"])
        key = (row["PadreID"], name.strip().casefold())
        names[key] = names.get(key, 0) + 1
    result = {}
    while pending:
        ready = [r for r in pending if not r["PadreID"] or r["PadreID"] in result]
        if not ready:
            raise MappingError("Categorías Bohao con ciclo o padre inexistente")
        for row in ready:
            name = row.get("NombreES") or row.get("Nombre") or str(row["ClaseID"])
            if names[(row["PadreID"], name.strip().casefold())] > 1:
                name = name[:75] + f" · Bohao {row['ClaseID']}"
            parent = result.get(row["PadreID"])
            external = external_id(settings.installation_id, "cat", row["ClaseID"])
            payload = {"name": name, "parentExternalId": parent["id"] if parent else None}
            value = {
                "id": external,
                "bohaoActive": not bool(row.get("Privado") or row.get("Bloqueado"))
                and (parent["bohaoActive"] if parent else True),
                "bohaoTaxClass": {
                    Decimal(21): "standard",
                    Decimal(10): "reduced",
                    Decimal(4): "super_reduced",
                    Decimal(0): "exempt",
                }.get(Decimal(str(taxes.get(row["IVAID"], {}).get("IVA", -1)))),
                "payload": payload,
            }
            result[row["ClaseID"]] = value
            pending.remove(row)
    return result


def product_rows(bohao, settings, article, category):
    settings, options, combinations, factor, codes, owned = catalogue_source(
        bohao, settings, article, category
    )
    if len(combinations) > 1000:
        raise MappingError(f"Artículo {article['ArticuloID']}: demasiadas variantes para B2B")
    product = external_id(settings.installation_id, "p", article["ArticuloID"])
    payload = product_payload(article, settings, None)
    payload.pop("categoryId")
    payload["categoryExternalId"] = category["id"]
    payload["active"] &= category["bohaoActive"]
    payload["options"] = options
    rows = [("product", product, payload)]
    for prop1, prop2, values in combinations:
        variant = external_id(settings.installation_id, "v", article["ArticuloID"], prop1, prop2)
        rows.append(
            (
                "variant",
                variant,
                {
                    "productExternalId": product,
                    "optionValues": values,
                    "active": payload["active"],
                    "imageId": None,
                },
            )
        )
        units = [("base", 1, article.get("UnidadNombre") or "Unidad")]
        if factor > 1:
            units.append(("pack", factor, f"Pack {factor}"))
        for kind, unit_factor, name in units:
            unit = external_id(settings.installation_id, "u", article["ArticuloID"], prop1, prop2, kind)
            rows.append(
                (
                    "sale_unit",
                    unit,
                    {
                        "variantExternalId": variant,
                        "isBase": kind == "base",
                        "name": name,
                        "factor": unit_factor,
                        "minimumOrderQuantity": 1,
                        "barcodes": codes if kind == "base" else [],
                    },
                )
            )
            rows.append(
                (
                    "price",
                    unit,
                    {
                        "priceTierExternalId": None,
                        "unitPrice": scaled(base_price(article, settings) * unit_factor),
                    },
                )
            )
    return rows, owned


def encode_rows(rows):
    output = io.StringIO(newline="")
    writer = csv.writer(output)
    for kind, external, payload in rows:
        writer.writerow((kind, external, canonical(payload)))
    return output.getvalue().encode("utf-8")


class InitialLoad:
    def __init__(self, config, state, stop, heartbeat, progress):
        self.config, self.state, self.stop = config, state, stop
        self.heartbeat, self.progress = heartbeat, progress

    def check(self):
        if self.stop.is_set():
            raise MappingError("Carga inicial interrumpida; vuelve a generar o comprobar el paquete")
        self.heartbeat()

    def prepare(self, settings, bohao):
        # No MySQL initialization or mutation: export only reads the configured source.
        bohao.inspect()
        generation = uuid.uuid4().hex
        directory = self.config.directory / "initial-load" / generation
        directory.mkdir(parents=True)
        try:
            return self._prepare_export(settings, bohao, generation, directory)
        except BaseException:
            # Failed exports are not adoptable. Remove the database and any partial ZIPs now,
            # while the SQLite connection has already been closed by _handoff_database.
            shutil.rmtree(directory, ignore_errors=True)
            raise

    def _prepare_export(self, settings, bohao, generation, directory):
        categories = category_rows(bohao, settings)
        base = [("category", c["id"], c["payload"]) for c in categories.values()]
        base_bytes = encode_rows(base)
        if len(base) >= MAX_ROWS or len(base_bytes) >= MAX_BYTES:
            raise MappingError("Las categorías exceden el tamaño de un paquete de importación")
        packages = []
        skipped = []
        skipped_count = 0
        count_products = count_customers = 0
        header = b"kind,externalId,payload\r\n"
        with _handoff_database(directory / "handoff.db") as db:
            db.executescript("""
                CREATE TABLE expected(export_id TEXT,kind TEXT,external_id TEXT,fingerprint TEXT,
                    PRIMARY KEY(export_id,kind,external_id));
                CREATE TABLE resource(key TEXT PRIMARY KEY,content TEXT,rows TEXT);
            """)
            for native, category in categories.items():
                db.execute(
                    "INSERT INTO resource VALUES (?,?,?)",
                    (
                        "category:" + str(native),
                        canonical(category),
                        canonical([("category", category["id"], category["payload"])]),
                    ),
                )

            def new_part():
                export_id = str(uuid.uuid4())
                for kind, external, payload in base:
                    db.execute(
                        "INSERT INTO expected VALUES (?,?,?,?)",
                        (export_id, kind, external, hashlib.sha256(canonical(payload).encode()).hexdigest()),
                    )
                return export_id, bytearray(header + base_bytes), bytearray(header), len(base)

            export_id, products, customers, count = new_part()

            def flush():
                if count == len(base) and packages:
                    return
                manifest = {
                    "format": "nexoflux-pos-b2b",
                    "version": 1,
                    "organizationId": settings.organization_id,
                    "exportId": export_id,
                    "prices": "net",
                    "exportedAt": datetime.now(UTC).isoformat().replace("+00:00", "Z"),
                }
                filename = f"bohao-{len(packages) + 1:03}-{export_id}.zip"
                path = directory / filename
                with zipfile.ZipFile(path, "w", zipfile.ZIP_DEFLATED) as archive:
                    archive.writestr("manifest.json", canonical(manifest))
                    archive.writestr("products.csv", products)
                    archive.writestr("customers.csv", customers)
                    archive.writestr("customer-prices.csv", header)
                if path.stat().st_size > 10_000_000:
                    raise MappingError("Paquete comprimido demasiado grande; reduce los artículos del piloto")
                self.config._restrict(path)
                packages.append({"filename": filename, "exportId": export_id, "records": count})
                db.commit()

            def append(rows, key, content, customer=False):
                nonlocal export_id, products, customers, count
                encoded = encode_rows(rows)
                if len(rows) + len(base) > MAX_ROWS or len(encoded) + len(base_bytes) > MAX_BYTES:
                    raise MappingError(f"{key}: el registro no cabe en un paquete")
                if count + len(rows) > MAX_ROWS or len(products) + len(customers) + len(encoded) > MAX_BYTES:
                    flush()
                    export_id, products, customers, count = new_part()
                (customers if customer else products).extend(encoded)
                count += len(rows)
                for kind, external, payload in rows:
                    db.execute(
                        "INSERT INTO expected VALUES (?,?,?,?)",
                        (export_id, kind, external, hashlib.sha256(canonical(payload).encode()).hexdigest()),
                    )
                db.execute("INSERT INTO resource VALUES (?,?,?)", (key, canonical(content), canonical(rows)))

            def skip(kind, source_id, error):
                nonlocal skipped_count
                skipped_count += 1
                # Keep the handoff report bounded if a source has widespread data issues.
                if len(skipped) < 100:
                    skipped.append({"kind": kind, "sourceId": str(source_id), "reason": str(error)})

            selected = set(settings.article_ids)
            for article in bohao.rows("articulo", "ArticuloID"):
                self.check()
                if selected and article["ArticuloID"] not in selected:
                    continue
                category = categories.get(article["ClaseID"])
                if not category:
                    skip("product", article["ArticuloID"], "categoría inexistente")
                    continue
                try:
                    rows, owned = product_rows(bohao, settings, article, category)
                except MappingError as error:
                    skip("product", article["ArticuloID"], str(error))
                    continue
                append(rows, "product:" + rows[0][1], owned)
                count_products += 1
                self.progress(f"Preparando productos · {count_products}")
                if count_products % 200 == 0:
                    db.commit()
            for row in bohao.rows("cliente", "EmpresaID"):
                self.check()
                try:
                    source = customer_payload(row)
                except MappingError as error:
                    skip("customer", row["EmpresaID"], str(error))
                    continue
                external = external_id(settings.installation_id, "c", row["EmpresaID"])
                append(
                    [("customer", external, source | {"priceTierExternalId": None})],
                    "customer:" + external,
                    source,
                    True,
                )
                count_customers += 1
                self.progress(f"Preparando clientes · {count_customers}")
                if count_customers % 200 == 0:
                    db.commit()
            if count_products + count_customers == 0:
                raise MappingError("No hay productos ni clientes válidos para exportar")
            flush()
        self.config._restrict(directory / "handoff.db")
        result = {
            "status": "awaiting_import",
            "generation": generation,
            "packages": packages,
            "products": count_products,
            "customers": count_customers,
            "skippedCount": skipped_count,
            "skipped": skipped,
            "createdAt": time.time(),
        }
        self.state.set("initial_load", result)
        self.state.event(
            f"Carga inicial preparada: {count_products} productos, {count_customers} clientes, "
            f"{skipped_count} registros omitidos con errores visibles, {len(packages)} paquetes"
        )
        return result

    def adopt(self, settings, b2b):
        job = self.state.get("initial_load")
        if not job or not job.get("generation"):
            raise MappingError("Primero genera los paquetes de carga inicial")
        directory = self.config.directory / "initial-load" / job["generation"]
        with sqlite3.connect(directory / "handoff.db") as db:
            for package in job["packages"]:
                self.check()
                expected = {
                    (kind, external): digest
                    for kind, external, digest in db.execute(
                        "SELECT kind,external_id,fingerprint FROM expected WHERE export_id=?",
                        (package["exportId"],),
                    )
                }
                cursor = None
                while True:
                    self.check()
                    page = b2b.call(
                        "GET",
                        f"imports/{package['exportId']}/results",
                        params={"cursor": cursor} if cursor else None,
                    )
                    if page["status"] != "completed":
                        raise MappingError(
                            f"Paquete {package['filename']}: importación {page['status']}. Completa todos los paquetes en B2B"
                        )
                    for item in page["items"]:
                        key = (item["kind"], item["externalId"])
                        if key not in expected or expected[key] != item["fingerprint"]:
                            raise MappingError("Los resultados B2B no corresponden al paquete generado")
                        del expected[key]
                    cursor = page.get("nextCursor")
                    if not cursor:
                        break
                if expected:
                    raise MappingError(
                        "Faltan registros aceptados del paquete; no se activa la sincronización"
                    )
            # Read in pages, not one request per Product. Content that changed after import
            # is left uncached so the next sync re-reads and merges it normally.
            categories = {c["externalId"]: c for c in b2b.pages("categories")}
            for key, content, _rows in db.execute(
                "SELECT key,content,rows FROM resource WHERE key LIKE 'category:%'"
            ):
                source = json.loads(content)
                current = categories.get(source["id"])
                if not current:
                    raise MappingError("Categoría importada no disponible en B2B")
                value = current | {k: source[k] for k in ("bohaoActive", "bohaoTaxClass")}
                self.state.remember(key, source["payload"], value)
            adopted_products = adopted_customers = 0
            for path, prefix in (("products", "product:"), ("customers", "customer:")):
                for current in b2b.pages(path):
                    self.check()
                    key = prefix + str(current.get("externalId"))
                    row = db.execute("SELECT content,rows FROM resource WHERE key=?", (key,)).fetchone()
                    if not row:
                        continue
                    content, rows = json.loads(row[0]), json.loads(row[1])
                    if path == "products":
                        category = categories.get(content["categoryId"])
                        if not category:
                            raise MappingError("Categoría importada no disponible")
                        content["categoryId"] = category["id"]
                        if product_matches(current, rows, category["id"]):
                            self.state.remember(key, content, current)
                            adopted_products += 1
                    elif customer_matches(current, content):
                        self.state.remember(key, content, current)
                        adopted_customers += 1
            result = job | {
                "status": "ready",
                "checkedAt": time.time(),
                "adoptedProducts": adopted_products,
                "adoptedCustomers": adopted_customers,
                "error": None,
            }
            self.state.set("initial_load", result)
            self.state.event(
                f"Carga inicial comprobada: {adopted_products} productos y {adopted_customers} clientes adoptados. Sincroniza para renovar stock e imágenes"
            )
            return result


def product_matches(current, rows, category_id):
    product = rows[0][2]
    for field in ("name", "description", "active", "lotTracked"):
        if current.get(field) != product.get(field):
            return False
    if current.get("categoryId") != category_id or current.get("options") != product["options"]:
        return False
    for locale, expected in product["translations"].items():
        actual = current.get("translations", {}).get(locale)
        if actual != expected and not (actual is None and all(v is None for v in expected.values())):
            return False
    variants = {v.get("externalId"): v for v in current["variants"]}
    units = {u.get("externalId"): u for v in current["variants"] for u in v["saleUnits"]}
    for kind, external, payload in rows[1:]:
        if kind == "variant":
            value = variants.get(external)
            if not value or any(value.get(k) != payload[k] for k in ("optionValues", "active")):
                return False
        elif kind == "sale_unit":
            value = units.get(external)
            if not value or any(value.get(k) != payload[k] for k in ("name", "isBase", "factor")):
                return False
            if sorted((b["code"], b["kind"]) for b in value["barcodes"]) != sorted(
                (b["code"], b["kind"]) for b in payload["barcodes"]
            ):
                return False
        elif kind == "price":
            value = next(
                (p for p in units.get(external, {}).get("prices") or [] if p["priceTierId"] is None), None
            )
            if not value or value["unitPrice"] != payload["unitPrice"]:
                return False
    return True


def customer_matches(current, source):
    for key, value in source.items():
        if key in ("tradeName", "addresses", "contacts"):
            continue
        actual = current.get(key)
        if key == "idNumber":
            value = "".join(c for c in value.upper() if c.isalnum())
        if actual != value:
            return False
    for field in ("addresses", "contacts"):
        actual = [{k: item.get(k) for k in expected} for expected in source[field] for item in current[field]]
        if any(expected not in actual for expected in source[field]):
            return False
    return True
