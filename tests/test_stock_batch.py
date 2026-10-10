import time

import httpx
import pytest

from bridge.b2b import B2B, APIError
from bridge.config import ConfigStore, Settings
from bridge.engine import Engine
from bridge.mapping import external_id
from bridge.state import State


def test_readiness_refuses_server_without_batch_route():
    client = B2B(
        Settings(b2b_url="http://localhost", organization_id="demo"),
        transport=httpx.MockTransport(lambda request: httpx.Response(200, json={"paths": {}})),
    )
    try:
        with pytest.raises(APIError, match="STOCK_BATCH_API_REQUIRED"):
            client.require_stock_batch()
    finally:
        client.close()


def test_requests_are_paced_below_server_rate_limit(monkeypatch):
    clock = [0.0]
    monkeypatch.setattr("bridge.b2b.time.monotonic", lambda: clock[0])
    monkeypatch.setattr("bridge.b2b.time.sleep", lambda duration: clock.__setitem__(0, clock[0] + duration))
    client = B2B(
        Settings(b2b_url="http://localhost", organization_id="demo"),
        transport=httpx.MockTransport(lambda request: httpx.Response(200, json={})),
    )
    try:
        for _ in range(5):
            client.call("GET", "changes")
        assert clock[0] == 1.0
    finally:
        client.close()


def jobs(state, count=3):
    for index in range(count):
        state.enqueue(
            str(index),
            "stock",
            {
                "entity": str(index),
                "variantExternalId": str(index),
                "sequence": index + 1,
                "observedAt": int(time.time() * 1000),
                "physicalQuantity": 100,
                "installationId": "demo",
                "reflectedShipmentExternalIds": [],
            },
        )
    return state.pending(limit=25)


def test_batch_partial_failure_and_lost_response_preserve_sequences(tmp_path):
    state = State(tmp_path / "sync.db")
    engine = Engine(ConfigStore(tmp_path), state)
    work = jobs(state)

    class Remote:
        def __init__(self):
            self.lost = True
            self.requests = []

        def call(self, method, path, payload):
            assert path == "stock/external-snapshots"
            self.requests.append(payload)
            if self.lost:
                self.lost = False
                raise APIError(0, "CONNECTION_FAILED")
            return {
                "results": [
                    {"ok": True, "variantExternalId": "0"},
                    {
                        "ok": False,
                        "variantExternalId": "1",
                        "status": 409,
                        "code": "EXTERNAL_SNAPSHOT_CONFLICT",
                    },
                    {"ok": True, "variantExternalId": "2"},
                ]
            }

    remote = Remote()
    with pytest.raises(APIError):
        engine.stock_batch(work, remote)
    assert state.dashboard()["counts"] == {"pending": 3}
    state.retry()
    engine.stock_batch(state.pending(), remote)
    assert remote.requests[0] == remote.requests[1]
    assert state.dashboard()["counts"] == {"blocked": 1, "done": 2}


def test_batch_refuses_mismatched_response_and_discards_expired_capture(tmp_path):
    state = State(tmp_path / "sync.db")
    engine = Engine(ConfigStore(tmp_path), state)
    work = jobs(state, 2)
    work[0]["payload"]["observedAt"] = 1

    class Remote:
        def call(self, method, path, payload):
            assert len(payload["snapshots"]) == 1
            return {"results": [{"ok": True, "variantExternalId": "wrong"}]}

    with pytest.raises(APIError, match="INVALID_BATCH_RESPONSE"):
        engine.stock_batch(work, Remote())
    assert state.dashboard()["counts"] == {"done": 1, "pending": 1}


def test_stock_refresh_only_published_pilot_products_survives_restart(tmp_path):
    state = State(tmp_path / "sync.db")
    for article in ("A", "B"):
        state.remember("product:" + external_id("demo", "p", article), {}, {"variants": []})
    state = State(tmp_path / "sync.db")
    engine = Engine(ConfigStore(tmp_path), state)
    assert state.acquire()
    try:
        engine.schedule_stock(Settings(installation_id="demo", article_ids=["B"]))
        engine.schedule_stock(Settings(installation_id="demo", article_ids=["B"]))
        assert [job["payload"]["row"] for job in state.pending()] == [{"ArticuloID": "B"}]
    finally:
        state.release()


def test_batch_splits_at_reference_budget(tmp_path):
    state = State(tmp_path / "sync.db")
    engine = Engine(ConfigStore(tmp_path), state)
    work = jobs(state, 3)
    for job in work:
        job["payload"]["reflectedShipmentExternalIds"] = ["shipment"] * 1001

    class Remote:
        def call(self, method, path, payload):
            assert len(payload["snapshots"]) == 1
            return {"results": [{"ok": True, "variantExternalId": "0"}]}

    engine.stock_batch(work, Remote())
    assert state.dashboard()["counts"] == {"done": 1, "pending": 2}


def test_stock_sweeps_do_not_starve_initial_catalogue_and_capture_fresh_balances(tmp_path, monkeypatch):
    config = ConfigStore(tmp_path)
    settings = Settings(
        installation_id="demo",
        mysql_user="demo",
        b2b_url="http://localhost",
        organization_id="demo",
        api_key="demo",
    )
    config.save(settings)
    state = State(tmp_path / "sync.db")
    for index in range(30):
        article = str(index)
        state.remember(
            "product:" + external_id("demo", "p", article),
            {},
            {"variants": [{"externalId": external_id("demo", "v", article, "", "")}]},
        )
    clock = [0]
    catalogue = []
    transmitted = []
    monkeypatch.setattr("bridge.engine.time.monotonic", lambda: clock[0])

    class Local:
        def __init__(self, settings):
            pass

        def initialize(self):
            pass

        def rows(self, table, key):
            return [{key: str(index)} for index in range(80)] if table == "articulo" else []

        def inventory(self, article):
            clock[0] += 3
            return [{"PropID1": "", "PropID2": "", "Stock": 42}], []

    class Remote:
        def __init__(self, settings):
            pass

        def close(self):
            pass

        def call(self, method, path, payload):
            assert path == "stock/external-snapshots"
            transmitted.extend(payload["snapshots"])
            return {
                "results": [
                    {"ok": True, "variantExternalId": item["variantExternalId"]}
                    for item in payload["snapshots"]
                ]
            }

    engine = Engine(config, state, Local, Remote)
    engine.categories = lambda *args: None
    engine.pull = lambda *args: False
    original_apply = engine.apply

    def apply(work, *args):
        if work["kind"] == "catalogue":
            catalogue.append(work["payload"]["entity"])
            clock[0] += 3
        else:
            original_apply(work, *args)

    engine.apply = apply
    engine.cycle()
    assert len(catalogue) == 80
    assert len(transmitted) >= 60
    assert all(item["physicalQuantity"] == 42 for item in transmitted)
    assert state.dashboard()["counts"].keys() == {"done"}
    assert state.get("last_stock_sweep")["snapshots"] == 30
