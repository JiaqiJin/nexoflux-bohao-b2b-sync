from decimal import Decimal
from typing import ClassVar

import httpx
import pytest

from bridge.b2b import B2B, APIError
from bridge.config import ConfigStore, Settings
from bridge.engine import Engine
from bridge.mapping import MappingError, external_id
from bridge.state import State


def test_non_paginated_category_contract():
    client = B2B(
        Settings(b2b_url="http://localhost", organization_id="demo"),
        transport=httpx.MockTransport(lambda request: httpx.Response(200, json={"items": [{"id": "one"}]})),
    )
    assert list(client.pages("categories")) == [{"id": "one"}]
    client.close()


def test_dispatch_replay_and_changed_local_line_refused(tmp_path):
    settings = Settings(installation_id="demo")
    engine = Engine(ConfigStore(tmp_path), State(tmp_path / "sync.db"))
    line = {
        "id": "line",
        "lineNumber": 1,
        "variantExternalId": external_id("demo", "v", "SKU", "", ""),
        "factor": 2,
    }
    from bridge.state import canonical

    dispatch = {
        "DocumentoNo": 9,
        "order_id": "order",
        "bridge_order": canonical({"lines": [line]}),
        "Anulado": 0,
        "Fecha": "2026-10-05",
        "lines": [{"OrdenNo": 1, "ArticuloID": "SKU", "PropID1": "", "PropID2": "", "Cantidad": Decimal(4)}],
    }

    class Remote:
        def __init__(self):
            self.shipments = []
            self.posts = 0

        def call(self, method, path, payload=None):
            if method == "GET":
                return {"id": "order", "version": 1, "shipments": self.shipments}
            self.posts += 1
            self.shipments.append(
                {
                    "externalId": payload["externalId"],
                    "void": None,
                    "shippedOn": payload["shippedOn"],
                    "lines": [{"orderLineId": "line", "quantity": 2}],
                }
            )

    remote = Remote()
    assert engine.dispatches(remote, settings, [dispatch]) == [external_id("demo", "s", 9)]
    assert engine.dispatches(remote, settings, [dispatch]) == [external_id("demo", "s", 9)]
    assert remote.posts == 1
    dispatch["lines"][0]["Cantidad"] = Decimal(2)
    with pytest.raises(MappingError, match="modificado"):
        engine.dispatches(remote, settings, [dispatch])


def test_customer_source_reversion_is_not_lost_after_completed_work(tmp_path):
    config = ConfigStore(tmp_path)
    config.save(
        Settings(mysql_user="demo", b2b_url="http://localhost", organization_id="demo", api_key="demo")
    )
    row = {"EmpresaID": 1, "NombreES": "A", "CIF": "B12345674", "CountryID": "ES"}

    class Local:
        def __init__(self, settings):
            pass

        def initialize(self):
            pass

        def rows(self, table, key):
            return [row] if table == "cliente" else []

        def query(self, statement, params):
            return [row]

    class Remote:
        customer = None
        writes: ClassVar[list[str]] = []

        def __init__(self, settings):
            pass

        def call(self, method, path, payload=None, params=None):
            if path == "changes":
                return {"items": [], "nextAfter": 0, "hasMore": False}
            if self.customer is None:
                raise APIError(404, "NOT_FOUND")
            return self.customer

        def upsert(self, path, payload, version=None):
            Remote.customer = payload | {"version": len(self.writes) + 1}
            self.writes.append(payload["name"])
            return self.customer

        def close(self):
            pass

    engine = Engine(config, State(tmp_path / "sync.db"), Local, Remote)
    engine.categories = lambda *args: None
    for name in ("A", "B", "A"):
        row["NombreES"] = name
        engine.cycle()
    assert Remote.writes == ["A", "B", "A"]
    assert engine.state.dashboard()["errors"] == []


def test_changed_image_replaces_only_bridge_owned_image_after_lost_response(tmp_path):
    engine = Engine(ConfigStore(tmp_path), State(tmp_path / "sync.db"))

    class Local:
        data = b"\x89PNGone"

        def image(self, article):
            return self.data

    class Remote:
        def __init__(self):
            self.images = [{"id": "online"}]
            self.uploaded = {}
            self.lose_response = True

        def call(self, method, path, payload=None):
            if method == "DELETE":
                image_id = path.rsplit("/", 1)[1]
                self.images = [image for image in self.images if image["id"] != image_id]
            return {"images": self.images.copy()}

        def upload_image(self, path, data, key, content_type):
            if key not in self.uploaded:
                image = {"id": "local" + str(len(self.uploaded))}
                self.uploaded[key] = image
                self.images.append(image)
            if self.lose_response:
                self.lose_response = False
                raise APIError(0, "CONNECTION_FAILED")
            return {"images": self.images.copy()}

    local, remote = Local(), Remote()
    with pytest.raises(APIError):
        engine.sync_image(local, remote, {}, "P")
    engine.sync_image(local, remote, {}, "P")
    local.data = b"\x89PNGtwo"
    engine.sync_image(local, remote, {}, "P")
    engine.sync_image(local, remote, {}, "P")
    assert remote.images == [{"id": "online"}, {"id": "local1"}]
