import copy
import os
import uuid
from concurrent.futures import ThreadPoolExecutor

import pytest

from bridge.bohao import Bohao
from bridge.config import Settings
from bridge.mapping import MappingError, external_id


@pytest.fixture
def demo():
    if os.environ.get("BOHAO_DEMO_TESTS") != "1":
        pytest.skip("Activa BOHAO_DEMO_TESTS=1 únicamente en una base demo")
    database = os.environ.get("BOHAO_TEST_DATABASE", "bohao_sync_demo")
    if database not in ("bohao_sync_demo", "bohao_v622_demo"):
        pytest.fail("Las pruebas de escritura solo admiten las dos bases demo del bridge")
    settings = Settings(
        installation_id="integration",
        organization_id="test_" + uuid.uuid4().hex,
        mysql_port=int(os.environ.get("BOHAO_TEST_PORT", "3337")),
        mysql_database=database,
        mysql_user=os.environ.get("BOHAO_TEST_USER", "root"),
        mysql_password=os.environ.get("BOHAO_TEST_PASSWORD", ""),
    )
    bohao = Bohao(settings)
    bohao.initialize()
    article = bohao.query("SELECT * FROM articulo WHERE PropCount=0 ORDER BY ArticuloID LIMIT 1")[0]
    customer = bohao.query("SELECT * FROM cliente ORDER BY EmpresaID LIMIT 1")[0]
    order = {
        "id": uuid.uuid4().hex,
        "number": "PED-DEMO-001",
        "version": 1,
        "status": "confirmed",
        "orderDate": "2026-10-05",
        "orderDiscountBps": 0,
        "customer": {
            "id": uuid.uuid4().hex,
            "externalId": external_id(settings.installation_id, "c", customer["EmpresaID"]),
            "name": customer["NombreES"] or "Cliente demo",
            "idNumber": customer["CIF"],
        },
        "amounts": {
            "netCents": 2500,
            "taxCents": 525,
            "recargoCents": 0,
            "totalCents": 3025,
            "taxGroups": [
                {
                    "impuesto": "01",
                    "rateBps": 2100,
                    "recargoBps": 0,
                    "baseCents": 2500,
                    "taxCents": 525,
                    "recargoCents": 0,
                }
            ],
        },
        "lines": [
            {
                "id": uuid.uuid4().hex,
                "lineNumber": 1,
                "variantExternalId": external_id(
                    settings.installation_id, "v", article["ArticuloID"], "", ""
                ),
                "productName": "Demo bridge",
                "variantLabel": "",
                "quantity": 2,
                "factor": 1,
                "baseQuantity": 2,
                "shippedQuantity": 0,
                "unitPrice": 125000,
                "lineDiscountBps": 0,
                "taxRateBps": 2100,
                "recargoRateBps": 0,
                "saleUnitName": "Unidad",
            }
        ],
    }
    yield bohao, order
    with bohao.connection() as db, db.cursor() as cursor:
        cursor.execute(
            "SELECT document_no FROM nexoflux_sync_order WHERE organization_id=%s",
            (settings.organization_id,),
        )
        for row in cursor.fetchall():
            for table in ("pedidoclientearticulo", "pedidoclienteivatotal", "pedidocliente"):
                if not bohao.table_exists(cursor, table):
                    continue
                cursor.execute(f"DELETE FROM {table} WHERE DocumentoNo=%s", (row["document_no"],))
        for table in ("nexoflux_sync_order", "nexoflux_sync_customer", "nexoflux_sync_revision"):
            cursor.execute(f"DELETE FROM {table} WHERE organization_id=%s", (settings.organization_id,))


def test_import_replay_and_revision_without_physical_stock_change(demo):
    bohao, order = demo
    before = bohao.query("SELECT sum(Stock) AS n FROM stock")[0]["n"]
    document = bohao.import_order(order)
    assert bohao.import_order(order) == document
    header = bohao.query("SELECT * FROM pedidocliente WHERE DocumentoNo=%s", (document,))[0]
    assert header["LineaTotal"] == 1
    assert str(header["Total"]) == "30.2500"
    updated = copy.deepcopy(order)
    updated["version"] = 2
    updated["lines"][0]["quantity"] = 3
    updated["lines"][0]["baseQuantity"] = 3
    assert bohao.import_order(updated) == document
    assert (
        bohao.query("SELECT count(*) AS n FROM pedidocliente WHERE DocumentoNo=%s", (document,))[0]["n"] == 1
    )
    assert (
        bohao.query("SELECT Cantidad FROM pedidoclientearticulo WHERE DocumentoNo=%s", (document,))[0][
            "Cantidad"
        ]
        == 3
    )
    assert bohao.query("SELECT sum(Stock) AS n FROM stock")[0]["n"] == before


def test_concurrent_replay_creates_one_document(demo):
    bohao, order = demo
    with ThreadPoolExecutor(max_workers=2) as pool:
        documents = list(pool.map(lambda _: bohao.import_order(order), range(2)))
    assert documents[0] == documents[1]


def test_local_edit_conflict_and_transaction_rollback(demo):
    bohao, order = demo
    document = bohao.import_order(order)
    bohao.query("UPDATE pedidocliente SET Observacion='Cambio local' WHERE DocumentoNo=%s", (document,))
    order["version"] = 2
    with pytest.raises(MappingError, match="modificado"):
        bohao.import_order(order)
    bad = copy.deepcopy(order)
    bad["id"] = uuid.uuid4().hex
    bad["lines"][0]["variantExternalId"] = external_id(
        bohao.settings.installation_id, "v", "NO_EXISTE_ABC", "", ""
    )
    with pytest.raises(MappingError, match="No existe"):
        bohao.import_order(bad)
    assert not bohao.query("SELECT 1 FROM nexoflux_sync_order WHERE order_id=%s", (bad["id"],))


def test_replay_after_ack_link_and_dispatch_progress_preserves_native_document(demo):
    bohao, order = demo
    document = bohao.import_order(order)
    order["export"] = {"externalId": "linked", "acknowledgedAt": 123}
    order["customer"]["externalId"] = None  # live links can change without an Order revision
    assert bohao.import_order(order) == document
    before = bohao.query("SELECT * FROM pedidoclientearticulo WHERE DocumentoNo=%s", (document,))
    order["version"] += 1
    order["status"] = "partially_shipped"
    order["lines"][0]["shippedQuantity"] = 1
    order["amounts"]["shippedNetCents"] = 1250
    assert bohao.import_order(order) == document
    assert bohao.query("SELECT * FROM pedidoclientearticulo WHERE DocumentoNo=%s", (document,)) == before
    assert (
        bohao.query("SELECT version FROM nexoflux_sync_order WHERE order_id=%s", (order["id"],))[0]["version"]
        == 2
    )
    order["version"] += 1
    order["lines"][0]["quantity"] = 3
    order["lines"][0]["baseQuantity"] = 3
    with pytest.raises(MappingError, match="expediciones"):
        bohao.import_order(order)


def test_local_tax_summary_edit_is_protected(demo):
    bohao, order = demo
    with bohao.connection() as db, db.cursor() as cursor:
        has_summary = bohao.table_exists(cursor, "pedidoclienteivatotal")
    document = bohao.import_order(order)
    if not has_summary:
        assert (
            bohao.query("SELECT IVA FROM pedidoclientearticulo WHERE DocumentoNo=%s", (document,))[0]["IVA"]
            == 21
        )
        return
    assert (
        bohao.query("SELECT ImporteIVA FROM pedidoclienteivatotal WHERE DocumentoNo=%s", (document,))[0][
            "ImporteIVA"
        ]
        == 5.25
    )
    bohao.query("UPDATE pedidoclienteivatotal SET ImporteIVA=6 WHERE DocumentoNo=%s", (document,))
    order["version"] += 1
    order["notes"] = "Revision"
    with pytest.raises(MappingError, match="modificado"):
        bohao.import_order(order)


def test_deleted_native_document_is_not_acknowledged_on_replay_or_progress(demo):
    bohao, order = demo
    document = bohao.import_order(order)
    bohao.query("DELETE FROM pedidocliente WHERE DocumentoNo=%s", (document,))
    with pytest.raises(MappingError, match="eliminado"):
        bohao.import_order(order)
    order["version"] += 1
    order["status"] = "partially_shipped"
    order["lines"][0]["shippedQuantity"] = 1
    with pytest.raises(MappingError, match="eliminado"):
        bohao.import_order(order)
