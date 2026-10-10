import threading

from bridge.b2b import APIError
from bridge.config import ConfigStore, Settings
from bridge.engine import Engine
from bridge.mapping import external_id
from bridge.state import State


def test_5000_product_scan_resumes_without_duplicates_and_prioritizes_orders_and_stock(tmp_path):
    path = tmp_path / "sync.db"
    state = State(path)
    rows = [{"ArticuloID": f"SKU-{index:05}", "Description": "x" * 1000} for index in range(5000)]
    stop = threading.Event()
    state.enqueue_scan("catalogue", rows, "ArticuloID", 1, stop)
    restored = State(path)
    restored.enqueue_scan("catalogue", rows, "ArticuloID", 2, stop)
    with restored.connection() as db:
        assert db.execute("SELECT count(*) FROM work").fetchone()[0] == 5000
    restored.enqueue("snapshot:1", "stock", {"entity": "SKU-00000", "sequence": 1})
    restored.enqueue("snapshot:2", "stock", {"entity": "SKU-00000", "sequence": 2})
    restored.ingest([{"sequence": 1, "recordType": "order", "recordId": "new-order"}], 1)
    jobs = restored.pending()
    assert [job["kind"] for job in jobs[:3]] == ["order", "stock", "catalogue"]
    assert jobs[2]["payload"] == {"entity": "SKU-00000", "row": {"ArticuloID": "SKU-00000"}}
    restored.finish(jobs[1]["id"])
    assert restored.pending()[1]["key"] == "snapshot:2"


def test_interrupted_scan_keeps_committed_rows_and_resumes(tmp_path):
    state = State(tmp_path / "sync.db")
    stop = threading.Event()

    def rows():
        for index in range(500):
            if index == 235:
                stop.set()
            yield {"EmpresaID": index}

    state.enqueue_scan("customer", rows(), "EmpresaID", 1, stop)
    with state.connection() as db:
        assert db.execute("SELECT count(*) FROM work").fetchone()[0] == 235
    stop.clear()
    state.enqueue_scan("customer", rows(), "EmpresaID", 2, threading.Event())
    with state.connection() as db:
        assert db.execute("SELECT count(*) FROM work").fetchone()[0] == 500


def test_orders_arriving_during_large_load_and_fresh_stock_do_not_wait_for_catalogue(tmp_path, monkeypatch):
    config = ConfigStore(tmp_path)
    config.save(
        Settings(mysql_user="demo", b2b_url="http://localhost", organization_id="demo", api_key="demo")
    )
    clock = [0]
    applied = []
    state = State(tmp_path / "sync.db")

    class Local:
        def __init__(self, settings):
            pass

        def initialize(self):
            pass

        def rows(self, table, key):
            return ({key: str(index)} for index in range(1000)) if table == "articulo" else []

    class Remote:
        def __init__(self, settings):
            pass

        def close(self):
            pass

    engine = Engine(config, state, Local, Remote)
    engine.categories = lambda *args: None
    monkeypatch.setattr("bridge.engine.time.monotonic", lambda: clock[0])

    def pull(remote):
        if clock[0] >= 5:
            state.ingest([{"sequence": 1, "recordType": "order", "recordId": "arrived"}], 1)
        return False

    def apply(job, *args):
        applied.append(job["kind"])
        clock[0] += 1
        if job["kind"] == "catalogue":
            state.enqueue("stock:" + str(job["id"]), "stock", {"entity": job["payload"]["entity"]})

    engine.pull = pull
    engine.apply = apply

    def stock_batch(jobs, remote):
        for job in jobs:
            apply(job)
            state.finish(job["id"])
        return len(jobs)

    engine.stock_batch = stock_batch
    engine.cycle()
    assert applied[:7] == ["catalogue", "stock", "catalogue", "stock", "catalogue", "order", "stock"]
    assert applied.count("catalogue") == applied.count("stock") == 1000
    assert applied.count("order") == 1
    assert state.dashboard()["counts"] == {"done": 2001}


def test_stop_does_not_mark_initial_load_as_completed(tmp_path):
    config = ConfigStore(tmp_path)
    config.save(
        Settings(mysql_user="demo", b2b_url="http://localhost", organization_id="demo", api_key="demo")
    )

    class Local:
        def __init__(self, settings):
            pass

        def initialize(self):
            pass

        def rows(self, table, key):
            return [{key: "one"}, {key: "two"}] if table == "articulo" else []

    class Remote:
        def __init__(self, settings):
            pass

        def close(self):
            pass

    engine = Engine(config, State(tmp_path / "sync.db"), Local, Remote)
    engine.categories = lambda *args: None
    engine.pull = lambda *args: False
    engine.apply = lambda *args: engine.stop.set()
    engine.cycle()
    assert engine.state.get("last_sync") is None
    assert len(engine.state.pending()) == 1
    assert not engine.running


def test_unchanged_categories_skip_writes_but_recreated_categories_are_relinked(tmp_path):
    state = State(tmp_path / "sync.db")
    engine = Engine(ConfigStore(tmp_path), state)
    settings = Settings(installation_id="demo")

    class Local:
        def rows(self, table, key):
            if table == "ivatipo":
                return [{"IVAID": 1, "IVA": 21}]
            return [{"ClaseID": 1, "PadreID": 0, "NombreES": "Cat", "IVAID": 1}]

    class Remote:
        current = None
        writes = 0

        def pages(self, path):
            return [self.current] if self.current else []

        def upsert(self, path, payload, version):
            self.writes += 1
            self.current = payload | {
                "id": str(self.writes),
                "externalId": path.split("/")[1],
                "version": self.writes,
            }
            return dict(self.current)

    remote = Remote()
    assert state.acquire()
    try:
        engine.categories(Local(), remote, settings)
        engine.categories(Local(), remote, settings)
        assert remote.writes == 1
        remote.current = None
        engine.categories(Local(), remote, settings)
        assert remote.writes == 2
        assert state.resource("category:1")["value"]["id"] == "2"
    finally:
        state.release()


def test_secondary_barcodes_and_recreated_category_update_product(tmp_path):
    state = State(tmp_path / "sync.db")
    engine = Engine(ConfigStore(tmp_path), state)
    settings = Settings(installation_id="demo")
    article = {"ArticuloID": "SKU", "ClaseID": 1, "PrecioMayor": 2, "CodigoBarra": "primary"}
    category = {"id": "category-one", "bohaoTaxClass": "standard", "bohaoActive": True}
    state.remember("category:1", {}, category)

    class Local:
        def __init__(self):
            self.barcodes = ["extra-one", None, ""]

        def variants(self, article):
            return [], [("", "", {})]

        def query(self, *args):
            return [{"CodigoBarra": code} for code in self.barcodes]

        def inventory(self, article_id):
            return [{"PropID1": "", "PropID2": "", "Stock": 100}], []

        def image(self, article):
            return None

    class Remote:
        product = None
        writes = 0

        def call(self, method, path, payload=None):
            if self.product is None:
                raise APIError(404, "NOT_FOUND")
            return self.product

        def upsert(self, path, payload, version=None):
            self.writes += 1
            if path.startswith("products/"):
                self.product = payload | {
                    "variants": self.product["variants"] if self.product else [],
                    "version": self.writes,
                }
            elif path.startswith("variants/"):
                self.product["variants"] = [{"externalId": path.split("/")[1], "saleUnits": []}]
            elif path.startswith("sale-units/") and "/prices/" not in path:
                self.product["variants"][0]["saleUnits"] = [payload | {"externalId": path.split("/")[1]}]
            return self.product

    local, remote = Local(), Remote()
    engine.catalogue(local, remote, settings, article)
    initial_writes = remote.writes
    engine.catalogue(local, remote, settings, article)
    assert remote.writes == initial_writes
    local.barcodes = ["extra-two"]
    engine.catalogue(local, remote, settings, article)
    assert remote.writes > initial_writes
    unit = remote.product["variants"][0]["saleUnits"][0]
    assert {code["code"] for code in unit["barcodes"]} == {"primary", "extra-two"}
    state.remember("category:1", {}, category | {"id": "category-two"})
    engine.catalogue(local, remote, settings, article)
    assert remote.product["categoryId"] == "category-two"
    cached = state.resource("product:" + external_id("demo", "p", "SKU"))
    assert cached["value"]["categoryId"] == "category-two"
