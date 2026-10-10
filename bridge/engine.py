import json
import threading
import time
from decimal import Decimal
from urllib.parse import quote

import pymysql

from .b2b import B2B, APIError
from .bohao import Bohao
from .mapping import (
    MappingError,
    base_price,
    catalogue_source,
    customer_payload,
    decode_id,
    external_id,
    product_payload,
    scaled,
    whole,
)
from .state import fingerprint


def safe_error(error):
    if isinstance(error, (MappingError, APIError)):
        return str(error)
    if isinstance(error, pymysql.MySQLError):
        return f"Bohao: error MySQL {error.args[0]}. Comprueba conexión, permisos y esquema."
    return "No se pudo completar la operación. Consulta el diagnóstico y reintenta."


class Engine:
    def __init__(self, config, state, bohao_factory=Bohao, b2b_factory=B2B):
        self.config, self.state = config, state
        self.bohao_factory, self.b2b_factory = bohao_factory, b2b_factory
        self.lock = threading.Lock()
        self.running = False
        self.stop = threading.Event()
        self.progress = "En espera"

    def dependencies(self):
        settings = self.config.load()
        if (
            not settings.mysql_user
            or not settings.b2b_url
            or not settings.organization_id
            or not settings.api_key
        ):
            raise MappingError("Completa la conexión Bohao y B2B antes de sincronizar")
        scope = fingerprint(
            [
                settings.installation_id,
                settings.mysql_host,
                settings.mysql_port,
                settings.mysql_database,
                settings.organization_id,
                settings.b2b_url,
            ]
        )
        previous = self.state.get("scope")
        if previous and previous != scope:
            raise MappingError(
                "Esta carpeta de datos ya está vinculada a otra instalación/Organization. Usa una nueva carpeta de datos."
            )
        self.state.set("scope", scope)
        return settings, self.bohao_factory(settings), self.b2b_factory(settings)

    def preflight(self):
        settings = self.config.load()
        bohao = self.bohao_factory(settings)
        report = bohao.inspect()
        if settings.b2b_url and settings.api_key and settings.organization_id:
            b2b = self.b2b_factory(settings)
            try:
                try:
                    b2b.call("GET", "changes", params={"after": 0, "limit": 1})
                except APIError as error:
                    if error.status != 410:
                        raise
                if hasattr(b2b, "require_stock_batch"):
                    b2b.require_stock_batch()
                report["b2b"] = "Conectado"
            finally:
                b2b.close()
        else:
            report["b2b"] = "Pendiente de configurar"
        self.state.set("preflight", report)
        return report

    def upsert(self, b2b, path, payload, current=None):
        for attempt in range(3):
            try:
                return b2b.upsert(path, payload, current.get("version") if current else None)
            except APIError as error:
                if error.code != "CONFLICT" or attempt == 2:
                    raise
                # Re-read the containing resource before the caller merges owned/preserved fields.
                raise MappingError(
                    "Registro cambiado en B2B. Reintenta para releer y conservar los campos online."
                ) from error

    def catalogue(self, bohao, b2b, settings, article):
        installation = settings.installation_id
        article_id = article["ArticuloID"]
        product_external = external_id(installation, "p", article_id)
        remembered = self.state.resource("product:" + product_external)
        category = self.state.resource("category:" + str(article["ClaseID"]))
        if not category:
            raise MappingError(f"Artículo {article_id}: categoría pendiente")
        settings, options, combinations, factor, codes, owned = catalogue_source(
            bohao, settings, article, category["value"]
        )
        if remembered and remembered["fingerprint"] == fingerprint(owned):
            product = remembered["value"]
        else:
            try:
                current = b2b.call("GET", "products/" + quote(product_external, safe=""))
            except APIError as error:
                if error.status != 404:
                    raise
                current = None
            catalogue_payload = product_payload(article, settings, category["value"]["id"], current)
            catalogue_payload["active"] &= category["value"].get("bohaoActive", True)
            product = self.upsert(
                b2b,
                "products/" + product_external,
                catalogue_payload,
                current,
            )
            if options:
                merged = {o["name"]: list(o["values"]) for o in product["options"]}
                for option in options:
                    merged[option["name"]] = list(
                        dict.fromkeys(merged.get(option["name"], []) + option["values"])
                    )
                product = b2b.call(
                    "PUT",
                    f"products/{product_external}/options",
                    {
                        "version": product["version"],
                        "options": [{"name": name, "values": values} for name, values in merged.items()],
                    },
                )
            for prop1, prop2, option_values in combinations:
                variant_external = external_id(installation, "v", article_id, prop1, prop2)
                variant = next((v for v in product["variants"] if v["externalId"] == variant_external), None)
                product = self.upsert(
                    b2b,
                    "variants/" + variant_external,
                    {
                        "productExternalId": product_external,
                        "optionValues": option_values,
                        "active": bool(product["active"]),
                        "imageId": variant.get("imageId") if variant else None,
                    },
                    variant,
                )
                variant = next(v for v in product["variants"] if v["externalId"] == variant_external)
                units = [("base", 1, article.get("UnidadNombre") or "Unidad")]
                if factor > 1:
                    units.append(("pack", factor, f"Pack {factor}"))
                for kind, unit_factor, name in units:
                    unit_external = external_id(installation, "u", article_id, prop1, prop2, kind)
                    unit = next((u for u in variant["saleUnits"] if u["externalId"] == unit_external), None)
                    # The article barcode cannot identify several distinct variants simultaneously.
                    product = self.upsert(
                        b2b,
                        "sale-units/" + unit_external,
                        {
                            "variantExternalId": variant_external,
                            "isBase": kind == "base",
                            "name": name,
                            "factor": unit_factor,
                            "minimumOrderQuantity": unit.get("minimumOrderQuantity", 1) if unit else 1,
                            "barcodes": codes if kind == "base" else [],
                        },
                        unit,
                    )
                    variant = next(v for v in product["variants"] if v["externalId"] == variant_external)
                    unit = next(u for u in variant["saleUnits"] if u["externalId"] == unit_external)
                    price = base_price(article, settings)
                    price_payload = {"unitPrice": scaled(price * unit_factor)}
                    cell = next((p for p in (unit.get("prices") or []) if p["priceTierId"] is None), None)
                    self.upsert(b2b, f"sale-units/{unit_external}/prices/base", price_payload, cell)
            self.state.remember("product:" + product_external, owned, product)
        self.sync_image(bohao, b2b, article, product_external)
        self.capture_stock(bohao, b2b, settings, article_id, combinations)

    def capture_stock(self, bohao, b2b, settings, article_id, combinations):
        installation = settings.installation_id
        captured_at = int(time.time() * 1000)
        stock, dispatches = bohao.inventory(article_id)
        reflected = self.dispatches(b2b, settings, dispatches)
        balances = {(r["PropID1"], r["PropID2"]): whole(r["Stock"]) for r in stock}
        for prop1, prop2, _ in combinations:
            variant_external = external_id(installation, "v", article_id, prop1, prop2)
            # Persist a snapshot payload before transmission; lost responses retry the same sequence.
            sequence = self.state.get("snapshot_sequence", 0) + 1
            self.state.set("snapshot_sequence", sequence)
            self.state.enqueue(
                f"snapshot:{sequence}",
                "stock",
                {
                    "entity": variant_external,
                    "variantExternalId": variant_external,
                    "installationId": installation,
                    "sequence": sequence,
                    "physicalQuantity": balances.get((prop1, prop2), 0),
                    "safetyStock": settings.safety_stock,
                    "reflectedShipmentExternalIds": reflected,
                    "observedAt": captured_at,
                },
            )

    def schedule_stock(self, settings):
        selected = set(settings.article_ids)
        rows = (
            {"ArticuloID": article_id}
            for article_id in self.state.published_articles(settings.installation_id)
            if not selected or article_id in selected
        )
        self.state.enqueue_scan("inventory", rows, "ArticuloID", time.time_ns(), self.stop, self.state.renew)

    def stock_batch(self, jobs, b2b):
        fresh = []
        references = 0
        expired = 0
        for work in jobs:
            payload = work["payload"]
            if payload.get("observedAt", 0) < int(time.time() * 1000) - 240_000:
                self.state.finish(work["id"])
                expired += 1
                continue
            count = len(payload.get("reflectedShipmentExternalIds", []))
            if fresh and references + count > 2000:
                break
            fresh.append(work)
            references += count
        if not fresh:
            return expired
        try:
            response = b2b.call(
                "PUT",
                "stock/external-snapshots",
                {
                    "snapshots": [
                        {k: v for k, v in work["payload"].items() if k != "entity"} for work in fresh
                    ]
                },
            )
            results = response.get("results", [])
            if len(results) != len(fresh) or any(
                result.get("variantExternalId") != work["payload"]["variantExternalId"]
                for work, result in zip(fresh, results)
            ):
                raise APIError(502, "INVALID_BATCH_RESPONSE")
            for work, result in zip(fresh, results):
                if result.get("ok") is True or result.get("code") == "EXTERNAL_SNAPSHOT_EXPIRED":
                    self.state.finish(work["id"])
                else:
                    error = APIError(result.get("status", 500), result.get("code", "REQUEST_FAILED"))
                    self.state.fail(work["id"], safe_error(error), error.status in (400, 404, 409, 422))
            return expired + len(fresh)
        except Exception as error:
            for work in fresh:
                self.state.fail(
                    work["id"],
                    safe_error(error),
                    isinstance(error, APIError) and error.status in (400, 401, 403, 404, 422),
                )
            raise

    def dispatches(self, b2b, settings, dispatches):
        reflected = []
        for dispatch in dispatches:
            number = dispatch["DocumentoNo"]
            external = external_id(settings.installation_id, "s", number)
            recorded = json.loads(dispatch["bridge_order"])
            order = b2b.call("GET", "orders/" + quote(dispatch["order_id"], safe=""))
            shipment = next((s for s in order["shipments"] if s["externalId"] == external), None)
            if dispatch["Anulado"]:
                if shipment and not shipment["void"]:
                    raise MappingError(
                        f"Albarán {number} anulado: anula su expedición en B2B antes de conciliar"
                    )
                continue
            rows = []
            used = set()
            for local in dispatch["lines"]:
                candidates = [
                    line
                    for line in recorded["lines"]
                    if line["lineNumber"] == local["OrdenNo"]
                    and decode_id(line["variantExternalId"], settings.installation_id, "v")
                    == [local["ArticuloID"], local["PropID1"], local["PropID2"]]
                ]
                if len(candidates) != 1 or candidates[0]["id"] in used:
                    raise MappingError(
                        f"Albarán {number}: no se puede vincular exactamente cada línea del pedido"
                    )
                line = candidates[0]
                used.add(line["id"])
                quantity = whole(local["Cantidad"] / Decimal(line["factor"]), "Expedición")
                if quantity < 1:
                    raise MappingError(
                        f"Albarán {number}: devolución o cantidad no positiva requiere revisión"
                    )
                rows.append({"lineId": line["id"], "quantity": quantity})
            if not rows:
                raise MappingError(f"Albarán {number} sin líneas")
            if shipment:
                existing = sorted((line["orderLineId"], line["quantity"]) for line in shipment["lines"])
                if (
                    shipment["void"]
                    or existing != sorted((line["lineId"], line["quantity"]) for line in rows)
                    or shipment["shippedOn"] != str(dispatch["Fecha"])
                ):
                    raise MappingError(
                        f"Albarán {number} modificado después de sincronizar; requiere revisión"
                    )
            else:
                b2b.call(
                    "POST",
                    f"orders/{order['id']}/shipments",
                    {
                        "externalId": external,
                        "version": order["version"],
                        "shippedOn": str(dispatch["Fecha"]),
                        "notes": f"Bohao albarán {number}",
                        "lines": rows,
                    },
                )
                self.state.event(f"Expedición Bohao {number} registrada en B2B")
            reflected.append(external)
        return sorted(reflected)

    def sync_image(self, bohao, b2b, article, product_external):
        data = bohao.image(article)
        key = "image:" + product_external
        old = self.state.resource(key)
        if not data:
            return
        digest = fingerprint(data.hex())
        if old and old["fingerprint"] == fingerprint(digest):
            self.clean_images(b2b, product_external, key, digest, old["value"])
            return
        content_type = (
            "image/png"
            if data.startswith(b"\x89PNG")
            else "image/jpeg"
            if data.startswith(b"\xff\xd8")
            else None
        )
        if not content_type:
            raise MappingError("Imagen Bohao no compatible; usa PNG o JPEG")
        pending_key = "image-pending:" + product_external
        pending = self.state.resource(pending_key)
        if not pending or pending["fingerprint"] != fingerprint(digest):
            current = b2b.call("GET", "products/" + product_external)
            self.state.remember(pending_key, digest, {"before": [image["id"] for image in current["images"]]})
            pending = self.state.resource(pending_key)
        result = b2b.upload_image(
            f"products/{product_external}/images",
            data,
            "bh_image_" + fingerprint([product_external, digest]),
            content_type,
        )
        added = [image["id"] for image in result["images"] if image["id"] not in pending["value"]["before"]]
        if len(added) != 1:
            raise MappingError(
                "Imagen publicada: no se puede identificar exactamente su vínculo; revisa las imágenes"
            )
        value = {
            "imageId": added[0],
            "obsolete": [old["value"]["imageId"]] if old and old["value"].get("imageId") else [],
        }
        self.state.remember(key, digest, value)
        self.clean_images(b2b, product_external, key, digest, value)

    def clean_images(self, b2b, product_external, key, digest, value):
        for image_id in value.get("obsolete", []):
            try:
                b2b.call("DELETE", f"products/{product_external}/images/{image_id}")
            except APIError as error:
                if error.status != 404:
                    raise
        if value.get("obsolete"):
            self.state.remember(key, digest, value | {"obsolete": []})

    def customers(self, b2b, settings, row):
        external = external_id(settings.installation_id, "c", row["EmpresaID"])
        payload = customer_payload(row)
        remembered = self.state.resource("customer:" + external)
        if remembered and remembered["fingerprint"] == fingerprint(payload):
            return
        try:
            current = b2b.call("GET", "customers/" + external)
        except APIError as error:
            if error.status != 404:
                raise
            current = None
        payload["priceTierId"] = current.get("priceTierId") if current else None
        if current:
            payload["tradeName"] = current.get("tradeName")
            # Existing contacts/addresses may include online additions; never drop those.
            for field, fields in (
                (
                    "addresses",
                    ("kind", "label", "line1", "line2", "postalCode", "city", "province", "countryCode"),
                ),
                ("contacts", ("name", "role", "phone", "email")),
            ):
                for item in current[field]:
                    clean = {k: item.get(k) for k in fields}
                    if clean not in payload[field]:
                        payload[field].append(clean)
        result = self.upsert(b2b, "customers/" + external, payload, current)
        self.state.remember("customer:" + external, customer_payload(row), result)

    def pull(self, b2b):
        cursor = self.state.get("cursor", 0)
        try:
            page = b2b.call("GET", "changes", params={"after": cursor, "limit": 100})
        except APIError as error:
            if error.status != 410:
                raise
            cursor = error.detail.get("oldestSequence", 1) - 1
            page = b2b.call("GET", "changes", params={"after": max(cursor, 0), "limit": 100})
            # Capture sequence first and sweep all orders. Durable inbox protects resume.
            for order in b2b.pages("orders"):
                self.state.enqueue(
                    f"recover:{order['id']}:{order['version']}",
                    "order",
                    {"id": order["id"], "entity": order["id"]},
                )
        self.state.ingest(page["items"], page["nextAfter"])
        return page["hasMore"]

    def apply(self, work, settings, bohao, b2b):
        payload = work["payload"]
        if work["kind"] == "catalogue":
            rows = bohao.query("SELECT * FROM articulo WHERE ArticuloID=%s", (payload["row"]["ArticuloID"],))
            if not rows:
                raise MappingError("Artículo eliminado de Bohao; revisa su baja online")
            self.catalogue(bohao, b2b, settings, rows[0])
        elif work["kind"] == "customer":
            rows = bohao.query("SELECT * FROM cliente WHERE EmpresaID=%s", (payload["row"]["EmpresaID"],))
            if not rows:
                raise MappingError("Cliente eliminado de Bohao; revisa su baja online")
            self.customers(b2b, settings, rows[0])
        elif work["kind"] == "inventory":
            article_id = payload["row"]["ArticuloID"]
            remembered = self.state.resource(
                "product:" + external_id(settings.installation_id, "p", article_id)
            )
            if not remembered:
                return
            combinations = []
            for variant in remembered["value"]["variants"]:
                parts = decode_id(variant["externalId"], settings.installation_id, "v")
                if parts[0] != article_id:
                    raise MappingError("Variante vinculada a otro artículo")
                combinations.append((parts[1], parts[2], {}))
            self.capture_stock(bohao, b2b, settings, article_id, combinations)
        elif work["kind"] == "stock":
            if payload.get("observedAt", 0) < int(time.time() * 1000) - 240_000:
                self.state.event("Captura de stock caducada: se tomará una nueva lectura local")
                return
            b2b.call("PUT", "stock/external-snapshot", {k: v for k, v in payload.items() if k != "entity"})
        elif work["kind"] == "order":
            order = b2b.call("GET", "orders/" + quote(payload["id"], safe=""))
            detail = None
            if not order["customer"].get("externalId"):
                detail = next((c for c in b2b.pages("customers") if c["id"] == order["customer"]["id"]), None)
                if detail is None:
                    raise MappingError("Cliente B2B no disponible; conserva el pedido para reintentar")
            number = bohao.import_order(order, detail)
            if number and detail is not None:
                linked = bohao.query(
                    "SELECT empresa_id FROM nexoflux_sync_customer WHERE installation_id=%s AND organization_id=%s AND customer_id=%s",
                    (settings.installation_id, settings.organization_id, detail["id"]),
                )[0]
                b2b.call(
                    "PUT",
                    f"customers/by-id/{detail['id']}/external-id",
                    {
                        "externalId": external_id(settings.installation_id, "c", linked["empresa_id"]),
                        "version": detail["version"],
                    },
                )
            if number and order["status"] != "cancelled":
                b2b.call(
                    "PUT",
                    f"orders/{order['id']}/export",
                    {"externalId": external_id(settings.installation_id, "o", number)},
                )
                self.state.event(f"Pedido {order['number']} importado en Bohao · {number}")

    def categories(self, bohao, b2b, settings):
        online = {c["externalId"]: c for c in b2b.pages("categories")}
        taxes = {r["IVAID"]: r for r in bohao.rows("ivatipo", "IVAID")}
        pending = list(bohao.rows("articuloclase", "ClaseID"))
        names = {}
        for row in pending:
            key = (
                row["PadreID"],
                (row.get("NombreES") or row.get("Nombre") or str(row["ClaseID"])).strip().casefold(),
            )
            names[key] = names.get(key, 0) + 1
        visited = set()
        while pending:
            ready = [row for row in pending if not row["PadreID"] or row["PadreID"] in visited]
            if not ready:
                raise MappingError("Categorías Bohao con ciclo o padre inexistente; revisa su jerarquía")
            for row in ready:
                if self.stop.is_set():
                    return
                self.state.renew()
                external = external_id(settings.installation_id, "cat", row["ClaseID"])
                name = row.get("NombreES") or row.get("Nombre") or str(row["ClaseID"])
                if names[(row["PadreID"], name.strip().casefold())] > 1:
                    name = name[:75] + f" · Bohao {row['ClaseID']}"
                current = online.get(external)
                payload = {
                    "name": name,
                    "parentExternalId": external_id(settings.installation_id, "cat", row["PadreID"])
                    if row["PadreID"]
                    else None,
                }
                remembered = self.state.resource("category:" + str(row["ClaseID"]))
                if (
                    remembered
                    and current
                    and remembered["fingerprint"] == fingerprint(payload)
                    and remembered["value"].get("version") == current.get("version")
                ):
                    result = dict(current)
                else:
                    result = self.upsert(b2b, "categories/" + external, payload, current)
                rate = Decimal(str(taxes.get(row["IVAID"], {}).get("IVA", -1)))
                result["bohaoTaxClass"] = {
                    Decimal(21): "standard",
                    Decimal(10): "reduced",
                    Decimal(4): "super_reduced",
                    Decimal(0): "exempt",
                }.get(rate)
                parent = self.state.resource("category:" + str(row["PadreID"])) if row["PadreID"] else None
                result["bohaoActive"] = not bool(row.get("Bloqueado") or row.get("Privado")) and (
                    parent["value"]["bohaoActive"] if parent else True
                )
                self.state.remember("category:" + str(row["ClaseID"]), payload, result)
                visited.add(row["ClaseID"])
                pending.remove(row)

    def begin_initial(self, action):
        if action not in ("prepare", "adopt") or not self.lock.acquire(blocking=False):
            raise MappingError("Espera a que termine la operación en curso")
        try:
            if not self.state.acquire():
                raise MappingError("Otra instancia está sincronizando esta instalación")
            settings = self.config.load()
            settings.enabled = False
            self.config.save(settings)
            self.running = True
            self.progress = (
                "Preparando carga inicial" if action == "prepare" else "Comprobando importación B2B"
            )
            job = self.state.get("initial_load", {})
            self.state.set(
                "initial_load",
                job | {"status": "preparing" if action == "prepare" else "checking", "error": None},
            )
        except Exception:
            self.state.release()
            self.lock.release()
            raise

    def initial(self, action):
        from .initial_load import InitialLoad

        b2b = None
        try:
            settings, bohao, b2b = self.dependencies()
            load = InitialLoad(
                self.config,
                self.state,
                self.stop,
                self.state.renew,
                lambda text: setattr(self, "progress", text),
            )
            if action == "prepare":
                load.prepare(settings, bohao)
            else:
                load.adopt(settings, b2b)
        except Exception as error:  # noqa: BLE001 - preserve diagnostics and release the worker
            message = safe_error(error)
            job = self.state.get("initial_load", {})
            self.state.set(
                "initial_load",
                job | {"status": "failed" if action == "prepare" else "awaiting_import", "error": message},
            )
            self.state.event(message, "error")
        finally:
            if b2b:
                b2b.close()
            self.state.release()
            self.running = False
            self.progress = "En espera"
            self.lock.release()

    def cycle(self):
        if not self.lock.acquire(blocking=False):
            return
        b2b = None
        acquired = False
        try:
            acquired = self.state.acquire()
            if not acquired:
                return
            self.running = True
            self.progress = "Comprobando conexiones"
            initial = self.state.get("initial_load")
            if initial and initial.get("status") != "ready":
                raise MappingError("Completa y comprueba la carga inicial antes de sincronizar")
            settings, bohao, b2b = self.dependencies()
            if hasattr(b2b, "require_stock_batch"):
                b2b.require_stock_batch()
            bohao.initialize()
            self.schedule_stock(settings)
            self.categories(bohao, b2b, settings)
            # Every cycle refreshes snapshots, even when catalogue content is unchanged.
            run = time.time_ns()
            selected = set(settings.article_ids)
            articles = (
                row
                for row in bohao.rows("articulo", "ArticuloID")
                if not selected or row["ArticuloID"] in selected
            )
            self.progress = "Preparando carga de productos"
            self.state.enqueue_scan("catalogue", articles, "ArticuloID", run, self.stop, self.state.renew)
            self.progress = "Preparando carga de clientes"
            self.state.enqueue_scan(
                "customer", bohao.rows("cliente", "EmpresaID"), "EmpresaID", run, self.stop, self.state.renew
            )
            while self.pull(b2b) and not self.stop.is_set():
                self.state.renew()
            next_refresh = float("inf")
            refresh_started = time.monotonic()
            refresh_sequence = self.state.get("snapshot_sequence", 0)
            refreshing = True
            next_pull = time.monotonic() + 5
            processed = 0
            while not self.stop.is_set():
                # Large catalogue imports may take hours. Keep receiving orders during the run.
                if time.monotonic() >= next_pull:
                    while self.pull(b2b) and not self.stop.is_set():
                        self.state.renew()
                    next_pull = time.monotonic() + 5
                # Re-select after each item so its fresh stock goes out before the next product.
                if time.monotonic() >= next_refresh:
                    self.schedule_stock(settings)
                    next_refresh = float("inf")
                    refresh_started = time.monotonic()
                    refresh_sequence = self.state.get("snapshot_sequence", 0)
                    refreshing = True
                jobs = self.state.pending(limit=25)
                if refreshing and (not jobs or jobs[0]["kind"] not in ("inventory", "stock", "order")):
                    self.state.set(
                        "last_stock_sweep",
                        {
                            "finishedAt": time.time(),
                            "seconds": round(time.monotonic() - refresh_started, 3),
                            "snapshots": self.state.get("snapshot_sequence", 0) - refresh_sequence,
                        },
                    )
                    refreshing = False
                    next_refresh = time.monotonic() + 60
                if not jobs:
                    break
                kind = jobs[0]["kind"]
                jobs = [job for job in jobs if job["kind"] == kind]
                if kind == "stock":
                    self.state.renew()
                    processed += self.stock_batch(jobs, b2b)
                    continue
                if kind != "inventory":
                    jobs = jobs[:1]
                for work in jobs:
                    if self.stop.is_set():
                        break
                    if time.monotonic() >= next_pull:
                        while self.pull(b2b) and not self.stop.is_set():
                            self.state.renew()
                        next_pull = time.monotonic() + 5
                    self.state.renew()
                    self.progress = f"Sincronizando {work['kind']} · {processed + 1}"
                    try:
                        self.apply(work, settings, bohao, b2b)
                        self.state.finish(work["id"])
                    except Exception as error:
                        permanent = isinstance(error, MappingError) or (
                            isinstance(error, APIError) and error.status in (400, 401, 403, 404, 409, 422)
                        )
                        self.state.fail(work["id"], safe_error(error), permanent)
                        if isinstance(error, APIError) and error.status in (0, 401, 403, 429, 500, 502, 503):
                            raise
                    processed += 1
            if self.stop.is_set():
                self.state.event(f"Ciclo interrumpido: {processed} operaciones; pendientes conservados")
                return
            self.state.set("last_sync", time.time())
            self.state.compact()
            self.state.set("summary", {"processed": processed})
            self.state.event(f"Ciclo completado: {processed} operaciones procesadas")
        except Exception as error:  # noqa: BLE001 - keep the unattended worker alive
            self.state.event(safe_error(error), "error")
        finally:
            if b2b:
                b2b.close()
            if acquired:
                self.state.release()
            self.running = False
            self.progress = "En espera"
            self.lock.release()

    def worker(self):
        while not self.stop.is_set():
            settings = self.config.load()
            if settings.enabled:
                self.cycle()
            self.stop.wait(settings.interval_seconds)
