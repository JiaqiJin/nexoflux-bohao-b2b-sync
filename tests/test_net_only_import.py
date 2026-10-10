import copy
from contextlib import contextmanager
from decimal import Decimal

from bridge.bohao import Bohao
from bridge.config import Settings
from bridge.mapping import external_id


def order():
    return {
        "id": "order",
        "version": 1,
        "number": "PED-2026-1",
        "status": "confirmed",
        "orderDate": "2026-10-06",
        "orderDiscountBps": 500,
        "customer": {"id": "customer", "name": "Shop", "idNumber": "B12345674"},
        "amounts": {"netCents": 1710},
        "lines": [
            {
                "id": "line",
                "lineNumber": 1,
                "variantExternalId": external_id("demo", "v", "A", "", ""),
                "productName": "Product",
                "variantLabel": "",
                "saleUnitName": "Unit",
                "quantity": 2,
                "baseQuantity": 2,
                "factor": 1,
                "shippedQuantity": 0,
                "unitPrice": 100000,
                "lineDiscountBps": 1000,
                "netCents": 1710,
            }
        ],
    }


def test_net_only_import_uses_bohao_tax_and_keeps_terms_without_stock_writes():
    class Cursor:
        def __enter__(self):
            return self

        def __exit__(self, *args):
            pass

        def execute(self, sql, params=()):
            assert "stock" not in sql.lower()
            self.sql = sql

        def fetchone(self):
            if "FROM cliente" in self.sql:
                return {"CountryID": "ES", "IVAClase": 0, "ReglaIVA": 0}
            if "FROM articulo " in self.sql:
                return {"ArticuloID": "A", "ClaseID": "cat", "PropCount": 0}
            if "JOIN ivatipo" in self.sql:
                return {"IVA": Decimal(21)}
            return None

    class Database:
        def cursor(self):
            return Cursor()

    class Local(Bohao):
        def __init__(self):
            super().__init__(Settings(installation_id="demo"))
            self.writes = {}

        @contextmanager
        def connection(self):
            yield Database()

        def ensure_customer(self, *args):
            return 1

        def allocate(self, *args):
            return 99

        def insert(self, cursor, table, values):
            self.writes[table] = values

        def table_exists(self, *args):
            return True

        def document_hash(self, *args):
            return "native"

        def record_order(self, *args):
            pass

    local = Local()
    assert local.import_order(order()) == "99"
    header = local.writes["pedidocliente"]
    line = local.writes["pedidoclientearticulo"]
    assert (header["Total"], header["Descuento"]) == (Decimal("20.69"), Decimal(5))
    assert (line["Precio"], line["Descuento"], line["IVA"], line["REQ"]) == (10, 10, 21, 0)
    assert local.writes["pedidoclienteivatotal"]["BaseImponible"] == Decimal("17.10")
    assert "Descuento global: 5.0 %" in header["Observacion"]


def test_one_euro_net_price_stays_one_euro_and_bohao_order_total_adds_21_percent():
    class Cursor:
        def __enter__(self):
            return self

        def __exit__(self, *args):
            pass

        def execute(self, sql, params=()):
            assert "stock" not in sql.lower()
            self.sql = sql

        def fetchone(self):
            if "FROM cliente" in self.sql:
                return {"CountryID": "ES", "IVAClase": 0, "ReglaIVA": 0}
            if "FROM articulo " in self.sql:
                return {"ArticuloID": "A", "ClaseID": "cat", "PropCount": 0}
            if "JOIN ivatipo" in self.sql:
                return {"IVA": Decimal(21)}
            return None

    class Database:
        def cursor(self):
            return Cursor()

    class Local(Bohao):
        def __init__(self):
            super().__init__(Settings(installation_id="demo"))
            self.writes = {}

        @contextmanager
        def connection(self):
            yield Database()

        def ensure_customer(self, *args):
            return 1

        def allocate(self, *args):
            return 99

        def insert(self, cursor, table, values):
            self.writes[table] = values

        def table_exists(self, *args):
            return True

        def document_hash(self, *args):
            return "native"

        def record_order(self, *args):
            pass

    net_order = order()
    net_order["amounts"] = {"netCents": 100}
    net_order["orderDiscountBps"] = 0
    net_order["lines"][0].update(
        quantity=1, baseQuantity=1, unitPrice=10000, lineDiscountBps=0, netCents=100
    )
    local = Local()
    assert local.import_order(net_order) == "99"
    assert local.writes["pedidoclientearticulo"]["Precio"] == Decimal(1)
    assert local.writes["pedidoclientearticulo"]["IVA"] == Decimal(21)
    assert local.writes["pedidocliente"]["Total"] == Decimal("1.21")


def test_old_tax_payload_and_net_only_payload_have_same_replay_identity():
    current = order()
    old = copy.deepcopy(current)
    old.update(taxTerritory="peninsula_balearics", taxProfile="domestic", appliedTaxProfile="domestic")
    old["amounts"].update(totalCents=2069, taxCents=359, taxGroups=[])
    old["lines"][0].update(taxClass="standard", taxRateBps=2100, recargoRateBps=0)
    assert Bohao.order_hash(current) == Bohao.order_hash(old)
