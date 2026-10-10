import itertools
import json
import time
from contextlib import contextmanager
from decimal import Decimal

import pymysql

from .mapping import MappingError, decode_id, native_order_amounts, whole
from .state import canonical, fingerprint


class Bohao:
    def __init__(self, settings):
        self.settings = settings

    @contextmanager
    def connection(self):
        db = pymysql.connect(
            host=self.settings.mysql_host,
            port=self.settings.mysql_port,
            user=self.settings.mysql_user,
            password=self.settings.mysql_password,
            database=self.settings.mysql_database,
            charset="utf8mb4",
            cursorclass=pymysql.cursors.DictCursor,
            autocommit=False,
            connect_timeout=5,
            read_timeout=30,
            write_timeout=30,
        )
        try:
            yield db
            db.commit()
        except BaseException:
            db.rollback()
            raise
        finally:
            db.close()

    def query(self, statement, params=()):
        with self.connection() as db, db.cursor() as cursor:
            cursor.execute(statement, params)
            return cursor.fetchall()

    def inspect(self):
        required = {
            "articulo": {"ArticuloID", "NombreES", "PropCount"},
            "cliente": {"EmpresaID", "CIF"},
            "stock": {"AlmacenID", "ArticuloID", "Stock", "PropID1", "PropID2"},
            "pedidocliente": {"DocumentoNo", "EmpresaID", "Anulado", "Bloqueado"},
            "pedidoclientearticulo": {"DocumentoNo", "ArticuloID", "Cantidad", "OrdenNo"},
        }
        tables = self.query(
            "SELECT TABLE_NAME,ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA=DATABASE()"
        )
        engines = {r["TABLE_NAME"]: r["ENGINE"] for r in tables}
        counts = {}
        for table, fields in required.items():
            actual = {r["Field"] for r in self.query(f"SHOW COLUMNS FROM `{table}`")}
            missing = {
                field for field in fields if field.casefold() not in {name.casefold() for name in actual}
            }
            if missing:
                raise MappingError(f"Esquema incompatible: {table}, faltan {', '.join(sorted(missing))}")
            if (table.startswith("pedidocliente") or table == "cliente") and engines.get(table) != "InnoDB":
                raise MappingError(f"{table} necesita InnoDB para importación transaccional")
            counts[table] = self.query(f"SELECT count(*) AS n FROM `{table}`")[0]["n"]
        if "pedidoclienteivatotal" in engines and engines["pedidoclienteivatotal"] != "InnoDB":
            raise MappingError("pedidoclienteivatotal necesita InnoDB para importación transaccional")
        counts["fractional_stock"] = self.query("SELECT count(*) AS n FROM stock WHERE Stock<>floor(Stock)")[
            0
        ]["n"]
        counts["variants"] = self.query("SELECT count(*) AS n FROM articulo WHERE PropCount>0")[0]["n"]
        header_columns = {r["Field"] for r in self.query("SHOW COLUMNS FROM pedidocliente")}
        counts["bohao_schema"] = "Actual" if "PdfIP" in header_columns else "v6.22"
        return counts

    def initialize(self):
        self.inspect()
        with self.connection() as db, db.cursor() as cursor:
            for statement in [
                "CREATE TABLE IF NOT EXISTS nexoflux_sync_order (installation_id varchar(40) NOT NULL, organization_id varchar(128) NOT NULL, order_id varchar(128) NOT NULL, document_no bigint unsigned NOT NULL, version bigint NOT NULL, content_hash char(64) NOT NULL, local_hash char(64) NOT NULL, payload longtext NOT NULL, PRIMARY KEY(installation_id,organization_id,order_id), UNIQUE(document_no)) ENGINE=InnoDB",
                "CREATE TABLE IF NOT EXISTS nexoflux_sync_customer (installation_id varchar(40) NOT NULL, organization_id varchar(128) NOT NULL, customer_id varchar(128) NOT NULL, empresa_id bigint unsigned NOT NULL, PRIMARY KEY(installation_id,organization_id,customer_id)) ENGINE=InnoDB",
                "CREATE TABLE IF NOT EXISTS nexoflux_sync_sequence (name varchar(40) PRIMARY KEY, next_no bigint unsigned NOT NULL) ENGINE=InnoDB",
                "CREATE TABLE IF NOT EXISTS nexoflux_sync_revision (installation_id varchar(40) NOT NULL, organization_id varchar(128) NOT NULL, order_id varchar(128) NOT NULL, version bigint NOT NULL, payload longtext NOT NULL, created_at timestamp DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY(installation_id,organization_id,order_id,version)) ENGINE=InnoDB",
            ]:
                table = statement.split()[5]
                if not self.table_exists(cursor, table):
                    cursor.execute(statement)

    def rows(self, table, key):
        # Internal constant names only, never user SQL identifiers.
        last = None
        while True:
            rows = self.query(
                f"SELECT * FROM `{table}` "
                + (f"WHERE `{key}`>%s " if last is not None else "")
                + f"ORDER BY `{key}` LIMIT 200",
                (last,) if last is not None else (),
            )
            if not rows:
                return
            yield from rows
            last = rows[-1][key]

    def variants(self, article):
        count = article["PropCount"]
        if count not in (0, 1, 2):
            raise MappingError("Bohao admite como máximo dos propiedades en este adaptador")
        if not count:
            return [], [("", "", {})]
        properties = self.query(
            "SELECT * FROM articuloprop WHERE ArticuloID=%s ORDER BY PropIndex,PropID",
            (article["ArticuloID"],),
        )
        indices = sorted({r["PropIndex"] for r in properties})
        if len(indices) != count:
            raise MappingError(f"Artículo {article['ArticuloID']}: propiedades incompletas")
        axes = [[r for r in properties if r["PropIndex"] == index] for index in indices]
        names = [article.get(f"Prop{i + 1}Titulo") or f"Propiedad {i + 1}" for i in range(count)]
        options = [
            {"name": name, "values": [r["Nombre"] or r["PropID"] for r in axis]}
            for name, axis in zip(names, axes)
        ]
        combinations = []
        for combination in itertools.product(*axes):
            combinations.append(
                (
                    combination[0]["PropID"],
                    combination[1]["PropID"] if count == 2 else "",
                    {name: r["Nombre"] or r["PropID"] for name, r in zip(names, combination)},
                )
            )
        return options, combinations

    def stock(self, article_id):
        placeholders = ",".join(["%s"] * len(self.settings.warehouse_ids))
        return self.query(
            f"SELECT PropID1,PropID2,sum(Stock) AS Stock FROM stock WHERE ArticuloID=%s AND AlmacenID IN ({placeholders}) GROUP BY PropID1,PropID2",
            (article_id, *self.settings.warehouse_ids),
        )

    def inventory(self, article_id):
        """Read physical balances and related dispatches from the same InnoDB snapshot."""
        engines = self.query(
            "SELECT TABLE_NAME,ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME IN ('stock','albaran','albaranarticulo')"
        )
        if len(engines) != 3 or any(row["ENGINE"] != "InnoDB" for row in engines):
            raise MappingError("Stock y albaranes necesitan InnoDB para una lectura coherente")
        placeholders = ",".join(["%s"] * len(self.settings.warehouse_ids))
        with self.connection() as db, db.cursor() as cursor:
            cursor.execute("SET TRANSACTION ISOLATION LEVEL REPEATABLE READ")
            cursor.execute("START TRANSACTION WITH CONSISTENT SNAPSHOT")
            cursor.execute(
                f"SELECT PropID1,PropID2,sum(Stock) AS Stock FROM stock WHERE ArticuloID=%s AND AlmacenID IN ({placeholders}) GROUP BY PropID1,PropID2",
                (article_id, *self.settings.warehouse_ids),
            )
            balances = cursor.fetchall()
            cursor.execute(
                f"SELECT a.*,l.order_id,l.payload AS bridge_order FROM albaran a JOIN nexoflux_sync_order l ON l.document_no=a.DocumentoOrigenNo WHERE l.installation_id=%s AND l.organization_id=%s AND a.AlmacenID IN ({placeholders}) AND EXISTS(SELECT 1 FROM albaranarticulo x WHERE x.DocumentoNo=a.DocumentoNo AND x.ArticuloID=%s)",
                (
                    self.settings.installation_id,
                    self.settings.organization_id,
                    *self.settings.warehouse_ids,
                    article_id,
                ),
            )
            dispatches = cursor.fetchall()
            for dispatch in dispatches:
                if dispatch["DocumentoOrigenTipo"] not in self.settings.dispatch_origin_types:
                    raise MappingError(f"Albarán {dispatch['DocumentoNo']}: tipo de origen no verificado")
                if dispatch["Modificando"]:
                    raise MappingError(f"Albarán {dispatch['DocumentoNo']}: edición local en curso")
                cursor.execute(
                    "SELECT * FROM albaranarticulo WHERE DocumentoNo=%s ORDER BY OrdenNo",
                    (dispatch["DocumentoNo"],),
                )
                dispatch["lines"] = cursor.fetchall()
            return balances, dispatches

    def image(self, article):
        if not article.get("DibujoID"):
            return None
        rows = self.query("SELECT Dibujo FROM dibujo WHERE DibujoID=%s", (article["DibujoID"],))
        return rows[0]["Dibujo"] if rows else None

    @staticmethod
    def insert(cursor, table, values):
        cursor.execute(f"SHOW COLUMNS FROM `{table}`")
        columns = {r["Field"] for r in cursor.fetchall()}
        if values.keys() - columns:
            raise MappingError(f"Esquema incompatible al escribir {table}: {values.keys() - columns}")
        cursor.execute(
            f"INSERT INTO `{table}` ({','.join('`' + k + '`' for k in values)}) VALUES ({','.join(['%s'] * len(values))})",
            tuple(values.values()),
        )

    @staticmethod
    def allocate(cursor, name, table, column):
        # High range dedicated to the bridge; native sequences are left untouched.
        cursor.execute("INSERT IGNORE INTO nexoflux_sync_sequence VALUES (%s,900000000000)", (name,))
        cursor.execute("SELECT next_no FROM nexoflux_sync_sequence WHERE name=%s FOR UPDATE", (name,))
        number = cursor.fetchone()["next_no"]
        while True:
            cursor.execute(f"SELECT 1 FROM `{table}` WHERE `{column}`=%s", (number,))
            if not cursor.fetchone():
                break
            number += 1
        cursor.execute("UPDATE nexoflux_sync_sequence SET next_no=%s WHERE name=%s", (number + 1, name))
        return number

    def ensure_customer(self, cursor, customer, detail=None):
        scope = (self.settings.installation_id, self.settings.organization_id, customer["id"])
        cursor.execute(
            "SELECT empresa_id FROM nexoflux_sync_customer WHERE installation_id=%s AND organization_id=%s AND customer_id=%s",
            scope,
        )
        linked = cursor.fetchone()
        if linked:
            return linked["empresa_id"]
        if customer.get("externalId"):
            empresa_id = whole(decode_id(customer["externalId"], self.settings.installation_id, "c")[0])
            cursor.execute("SELECT EmpresaID FROM cliente WHERE EmpresaID=%s", (empresa_id,))
            if not cursor.fetchone():
                raise MappingError("Cliente vinculado eliminado en Bohao")
        else:
            cursor.execute(
                "SELECT EmpresaID FROM cliente WHERE UPPER(REPLACE(REPLACE(CIF,' ',''),'-',''))=%s",
                (customer["idNumber"].upper().replace(" ", "").replace("-", ""),),
            )
            matches = cursor.fetchall()
            if len(matches) > 1:
                raise MappingError("Identificación fiscal duplicada en Bohao: resolver antes de importar")
            if matches:
                empresa_id = matches[0]["EmpresaID"]
            else:
                empresa_id = self.allocate(cursor, "customer", "cliente", "EmpresaID")
                detail = detail or customer
                if (
                    detail.get("countryCode", "ES") != "ES"
                    or detail.get("taxProfile", "domestic") != "domestic"
                ):
                    raise MappingError(
                        "Alta de cliente con perfil fiscal especial: necesita mapeo nativo verificado"
                    )
                address = next(iter(detail.get("addresses", [])), {})
                contact = next(iter(detail.get("contacts", [])), {})
                self.insert(
                    cursor,
                    "cliente",
                    {
                        "EmpresaID": empresa_id,
                        "NombreES": customer["name"],
                        "CIF": customer["idNumber"],
                        "CountryID": detail.get("countryCode", "ES"),
                        "Domicilio": address.get("line1", ""),
                        "CodigoPostal": address.get("postalCode") or "",
                        "Poblacion": address.get("city") or "",
                        "Provincia": address.get("province") or "",
                        "Telefono": contact.get("phone") or "",
                        "Email": contact.get("email") or "",
                        "PersonaContacto": contact.get("name") or "",
                    },
                )
        cursor.execute("INSERT INTO nexoflux_sync_customer VALUES (%s,%s,%s,%s)", (*scope, empresa_id))
        return empresa_id

    @staticmethod
    def table_exists(cursor, name):
        cursor.execute(
            "SELECT 1 FROM information_schema.TABLES WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME=%s", (name,)
        )
        return cursor.fetchone() is not None

    @staticmethod
    def document_hash(cursor, document_no):
        cursor.execute("SELECT * FROM pedidocliente WHERE DocumentoNo=%s", (document_no,))
        header = cursor.fetchone()
        if not header:
            raise MappingError("Pedido importado eliminado de Bohao; requiere recuperación")
        # Timestamp-only changes are harmless; business and progress fields are protected.
        for key in ("UpdateTimeStamp", "TiempoUltimoActualizar", "TiempoUltimoEditar", "FechaEntrada"):
            header.pop(key, None)
        cursor.execute(
            "SELECT * FROM pedidoclientearticulo WHERE DocumentoNo=%s ORDER BY OrdenNo", (document_no,)
        )
        lines = cursor.fetchall()
        taxes = []
        if Bohao.table_exists(cursor, "pedidoclienteivatotal"):
            cursor.execute(
                "SELECT * FROM pedidoclienteivatotal WHERE DocumentoNo=%s ORDER BY IVA,REQ", (document_no,)
            )
            taxes = cursor.fetchall()
        return fingerprint({"header": header, "lines": lines, "taxes": taxes})

    @staticmethod
    def order_content(order):
        """Frozen commercial fields; acknowledgements and live links are not order revisions."""
        fields = (
            "id",
            "number",
            "orderDate",
            "requestedDeliveryDate",
            "customerReference",
            "deliveryAddress",
            "notes",
            "orderDiscountBps",
        )
        result = {key: order.get(key) for key in fields}
        result["customer"] = {
            key: order["customer"].get(key) for key in ("id", "name", "tradeName", "idNumber")
        }
        result["amounts"] = {
            key: value for key, value in order["amounts"].items() if key in ("netCents", "priceTierId")
        }
        result["lines"] = [
            {
                key: value
                for key, value in line.items()
                if key
                not in (
                    "shippedQuantity",
                    "lots",
                    "productExternalId",
                    "saleUnitExternalId",
                    "taxClass",
                    "taxRateBps",
                    "recargoRateBps",
                )
            }
            for line in order["lines"]
        ]
        return result

    @classmethod
    def order_hash(cls, order):
        return fingerprint(
            {"content": cls.order_content(order), "version": order["version"], "status": order["status"]}
        )

    def record_order(self, cursor, scope, number, order, local_hash):
        cursor.execute(
            "INSERT INTO nexoflux_sync_order VALUES (%s,%s,%s,%s,%s,%s,%s,%s) ON DUPLICATE KEY UPDATE version=VALUES(version),content_hash=VALUES(content_hash),local_hash=VALUES(local_hash),payload=VALUES(payload)",
            (*scope, number, order["version"], self.order_hash(order), local_hash, canonical(order)),
        )
        cursor.execute(
            "INSERT IGNORE INTO nexoflux_sync_revision(installation_id,organization_id,order_id,version,payload) VALUES (%s,%s,%s,%s,%s)",
            (*scope, order["version"], canonical(order)),
        )

    def import_order(self, order, customer_detail=None):
        for attempt in range(4):
            try:
                return self._import_order(order, customer_detail)
            except pymysql.MySQLError as error:
                if error.args[0] not in (1205, 1213, 1062) or attempt == 3:
                    raise
                # The connection context rolled the whole attempt back before retry.
                time.sleep(0.05 * (attempt + 1))

    def _import_order(self, order, customer_detail=None):
        if order["status"] == "pending":
            return None
        if order.get("appliedTaxProfile", order.get("taxProfile", "domestic")) != "domestic":
            raise MappingError("Pedido con perfil fiscal especial: necesita mapeo nativo verificado")
        scope = (self.settings.installation_id, self.settings.organization_id, order["id"])
        with self.connection() as db, db.cursor() as cursor:
            cursor.execute(
                "SELECT * FROM nexoflux_sync_order WHERE installation_id=%s AND organization_id=%s AND order_id=%s FOR UPDATE",
                scope,
            )
            existing = cursor.fetchone()
            if existing:
                cursor.execute(
                    "SELECT 1 FROM pedidocliente WHERE DocumentoNo=%s FOR UPDATE", (existing["document_no"],)
                )
                if not cursor.fetchone():
                    raise MappingError("Pedido importado eliminado de Bohao; requiere recuperación")
            if (
                existing
                and existing["version"] == order["version"]
                and self.order_hash(json.loads(existing["payload"])) != self.order_hash(order)
            ):
                raise MappingError("Misma versión de pedido con datos distintos; requiere revisión")
            if existing and existing["version"] >= order["version"]:
                return str(existing["document_no"])
            if order["status"] == "cancelled" and not existing:
                return None
            recorded = json.loads(existing["payload"]) if existing else None
            progress_changed = existing and (
                [line.get("shippedQuantity", 0) for line in recorded["lines"]]
                != [line.get("shippedQuantity", 0) for line in order["lines"]]
                or order["status"] in ("partially_shipped", "shipped", "completed", "closed")
            )
            # Shipment/close metadata is archived without rewriting Bohao's prepared document.
            if (
                existing
                and self.order_content(recorded) == self.order_content(order)
                and order["status"] != "cancelled"
                and (
                    progress_changed
                    or self.document_hash(cursor, existing["document_no"]) == existing["local_hash"]
                )
            ):
                self.record_order(cursor, scope, existing["document_no"], order, existing["local_hash"])
                return str(existing["document_no"])
            if existing and self.document_hash(cursor, existing["document_no"]) != existing["local_hash"]:
                raise MappingError("Pedido modificado en Bohao: revisa el conflicto antes de reemplazarlo")
            if any(line["shippedQuantity"] for line in order["lines"]):
                if existing:
                    raise MappingError(
                        "Pedido con expediciones: conservar documento local y revisar conciliación"
                    )
                raise MappingError("Pedido ya expedido: importa como histórico, no como pedido nuevo")
            empresa_id = self.ensure_customer(cursor, order["customer"], customer_detail)
            net_only = "totalCents" not in order["amounts"]
            if net_only:
                cursor.execute("SELECT * FROM cliente WHERE EmpresaID=%s", (empresa_id,))
                native_customer = cursor.fetchone()
                if (
                    not native_customer
                    or native_customer.get("CountryID", "ES") != "ES"
                    or native_customer.get("IVAClase")
                    or native_customer.get("ReglaIVA")
                    or native_customer.get("Extrajero")
                ):
                    raise MappingError(
                        "Cliente Bohao con tratamiento fiscal especial: necesita mapeo verificado"
                    )
            number = (
                existing["document_no"]
                if existing
                else self.allocate(cursor, "order", "pedidocliente", "DocumentoNo")
            )
            lines = []
            native_rates = []
            for line in order["lines"]:
                parts = decode_id(line["variantExternalId"], self.settings.installation_id, "v")
                article_id, prop1, prop2 = parts
                cursor.execute("SELECT * FROM articulo WHERE ArticuloID=%s", (article_id,))
                article = cursor.fetchone()
                if not article:
                    raise MappingError(f"No existe artículo {article_id} en Bohao")
                if net_only:
                    cursor.execute(
                        "SELECT t.IVA FROM articuloclase c JOIN ivatipo t ON t.IVAID=c.IVAID WHERE c.ClaseID=%s",
                        (article["ClaseID"],),
                    )
                    tax = cursor.fetchone()
                    if not tax or Decimal(str(tax["IVA"])) not in (Decimal(21), Decimal(10), Decimal(4)):
                        raise MappingError("IVA nativo Bohao no compatible: necesita mapeo verificado")
                    native_rates.append(Decimal(str(tax["IVA"])))
                _, variants = self.variants(article)
                if (prop1, prop2) not in {(a, b) for a, b, _ in variants}:
                    raise MappingError(f"No existe la combinación de propiedades de {article_id} en Bohao")
                if line["baseQuantity"] != line["quantity"] * line["factor"]:
                    raise MappingError("Unidades incoherentes en el pedido")
                base_price = Decimal(line["unitPrice"]) / 10000 / line["factor"]
                if base_price != base_price.quantize(Decimal("0.0001")):
                    raise MappingError(
                        "El precio por unidad base no cabe exactamente en los 4 decimales de Bohao"
                    )
                lines.append(
                    {
                        "DocumentoNo": number,
                        "ArticuloID": article_id,
                        "PropCount": article["PropCount"],
                        "PropID1": prop1,
                        "PropID2": prop2,
                        "Propiedad": line["variantLabel"],
                        "NombreES": line["productName"],
                        "NombreCN": article.get("NombreCN", ""),
                        "CodigoBarra": article.get("CodigoBarra", ""),
                        "Precio": Decimal(line["unitPrice"]) / 10000 / line["factor"],
                        "Cantidad": line["baseQuantity"],
                        "IVA": native_rates[-1] if net_only else Decimal(line["taxRateBps"]) / 100,
                        "REQ": Decimal(0) if net_only else Decimal(line["recargoRateBps"]) / 100,
                        "Descuento": Decimal(line["lineDiscountBps"]) / 100,
                        "Comentario": f"B2B {line['id']} · {line['quantity']} {line['saleUnitName']}",
                        "OrdenNo": line["lineNumber"],
                    }
                )
            amounts = native_order_amounts(order, native_rates) if net_only else order["amounts"]
            header = {
                "DocumentoNo": number,
                "EmpresaID": empresa_id,
                "Fecha": order["orderDate"],
                "Total": Decimal(amounts["totalCents"]) / 100,
                "CantidadTotal": sum(line["baseQuantity"] for line in order["lines"]),
                "LineaTotal": len(lines),
                "Descuento": Decimal(order["orderDiscountBps"]) / 100,
                "AlmacenID": self.settings.warehouse_ids[0],
                "Anulado": int(order["status"] == "cancelled"),
                "Observacion": self.order_notes(order),
            }
            if existing:
                cursor.execute("DELETE FROM pedidoclientearticulo WHERE DocumentoNo=%s", (number,))
                cursor.execute(
                    "UPDATE pedidocliente SET "
                    + ",".join(f"`{k}`=%s" for k in header if k != "DocumentoNo")
                    + " WHERE DocumentoNo=%s",
                    tuple(v for k, v in header.items() if k != "DocumentoNo") + (number,),
                )
            else:
                self.insert(cursor, "pedidocliente", header)
            for line in lines:
                self.insert(cursor, "pedidoclientearticulo", line)
            has_tax_summary = self.table_exists(cursor, "pedidoclienteivatotal")
            if has_tax_summary:
                cursor.execute("DELETE FROM pedidoclienteivatotal WHERE DocumentoNo=%s", (number,))
            for group in amounts.get("taxGroups", []):
                if group["impuesto"] not in ("IVA", "01"):
                    raise MappingError("El documento Bohao necesita mapeo explícito para IGIC/IPSI")
                if not has_tax_summary:
                    continue
                self.insert(
                    cursor,
                    "pedidoclienteivatotal",
                    {
                        "DocumentoNo": number,
                        "Fecha": order["orderDate"],
                        "IVA": Decimal(group["rateBps"]) / 100,
                        "REQ": Decimal(group["recargoBps"]) / 100,
                        "BaseImponible": Decimal(group["baseCents"]) / 100,
                        "ImporteIVA": Decimal(group["taxCents"]) / 100,
                        "ImporteREQ": Decimal(group["recargoCents"]) / 100,
                        "SubTotal": Decimal(group["baseCents"] + group["taxCents"] + group["recargoCents"])
                        / 100,
                    },
                )
            # No stock write here: importing an online reservation is not physical dispatch.
            local_hash = self.document_hash(cursor, number)
            self.record_order(cursor, scope, number, order, local_hash)
            return str(number)

    def imported_orders(self):
        return self.query(
            "SELECT order_id,document_no,version FROM nexoflux_sync_order WHERE installation_id=%s AND organization_id=%s ORDER BY document_no DESC",
            (self.settings.installation_id, self.settings.organization_id),
        )

    @staticmethod
    def order_notes(order):
        fields = [
            f"B2B {order['number']}",
            f"Descuento global: {order['orderDiscountBps'] / 100} % (adicional al descuento por producto)"
            if order.get("orderDiscountBps")
            else None,
            order.get("notes"),
            f"Referencia: {order['customerReference']}" if order.get("customerReference") else None,
            f"Entrega solicitada: {order['requestedDeliveryDate']}"
            if order.get("requestedDeliveryDate")
            else None,
            "Dirección de entrega: " + canonical(order["deliveryAddress"])
            if order.get("deliveryAddress")
            else None,
        ]
        value = "\n".join(field for field in fields if field)
        if len(value) > 2048:
            raise MappingError(
                "Las notas y dirección exceden 2048 caracteres de Bohao; revisa antes de importar"
            )
        return value
