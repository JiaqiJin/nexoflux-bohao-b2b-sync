import copy
import csv
import hashlib
import io
import json
import threading
import zipfile

import pytest

from bridge.config import ConfigStore, Settings
from bridge.engine import Engine
from bridge.initial_load import InitialLoad
from bridge.mapping import MappingError
from bridge.state import State


class Source:
    def __init__(self, count=2):
        self.count = count

    def inspect(self):
        return {}

    def rows(self, table, key):
        if table == "ivatipo":
            return [{"IVAID": 1, "IVA": 21}]
        if table == "articuloclase":
            return [{"ClaseID": 1, "PadreID": 0, "IVAID": 1, "NombreES": "中文, familia"}]
        if table == "cliente":
            return [{"EmpresaID": 1, "NombreES": "Cliente", "CIF": "B12345674"}]
        return (
            {
                "ArticuloID": f"sku-{i}",
                "ClaseID": 1,
                "NombreES": '中文, "artículo"',
                "Descripcion": "primera\nsegunda",
                "PrecioMayor": "12.10",
                "CantidadPorUnidad": 6,
            }
            for i in range(self.count)
        )

    def query(self, *args):
        return []

    def variants(self, article):
        if article["ArticuloID"] == "sku-0":
            return (
                [{"name": "Color", "values": ["Rojo", "Azul"]}],
                [(1, 0, {"Color": "Rojo"}), (2, 0, {"Color": "Azul"})],
            )
        return [], [(0, 0, {})]


def exported(config, job):
    packages = []
    for package in job["packages"]:
        with zipfile.ZipFile(
            config.directory / "initial-load" / job["generation"] / package["filename"]
        ) as z:
            manifest = json.loads(z.read("manifest.json"))
            rows = []
            for filename in ("products.csv", "customers.csv", "customer-prices.csv"):
                for row in csv.DictReader(io.StringIO(z.read(filename).decode())):
                    rows.append(
                        (
                            row["kind"],
                            row["externalId"],
                            json.loads(row["payload"]),
                            hashlib.sha256(row["payload"].encode()).hexdigest(),
                        )
                    )
            assert manifest["exportId"] == package["exportId"]
            assert manifest["prices"] == "net"
            packages.append((manifest, rows))
    return packages


class Imported:
    def __init__(self, packages):
        self.status = "completed"
        self.results = {
            m["exportId"]: [{"kind": k, "externalId": e, "fingerprint": h} for k, e, _, h in rows]
            for m, rows in packages
        }
        self.products, self.customers, self.categories = {}, {}, {}
        variants, units = {}, {}
        for _, rows in packages:
            for kind, external, value, _ in rows:
                value = copy.deepcopy(value)
                value.update(id=external, externalId=external, version=1)
                if kind == "category":
                    self.categories[external] = value
                elif kind == "product":
                    value["categoryId"] = value.pop("categoryExternalId")
                    value["variants"] = []
                    self.products[external] = value
                elif kind == "variant":
                    value["saleUnits"] = []
                    variants[external] = value
                    self.products[value["productExternalId"]]["variants"].append(value)
                elif kind == "sale_unit":
                    value["prices"] = []
                    units[external] = value
                    variants[value["variantExternalId"]]["saleUnits"].append(value)
                elif kind == "price":
                    value["priceTierId"] = None
                    units[external]["prices"].append(value)
                elif kind == "customer":
                    self.customers[external] = value

    def call(self, method, path, params=None):
        assert method == "GET" and path.startswith("imports/")
        items = self.results[path.split("/")[1]]
        offset = int((params or {}).get("cursor", 0))
        return {
            "status": self.status,
            "items": items[offset : offset + 3],
            "nextCursor": str(offset + 3) if offset + 3 < len(items) else None,
        }

    def pages(self, path):
        return getattr(self, path).values()


def setup(tmp_path):
    config = ConfigStore(tmp_path)
    settings = Settings(installation_id="bulk", organization_id="demo")
    state = State(tmp_path / "sync.db")
    initial = InitialLoad(config, state, threading.Event(), lambda: None, lambda _: None)
    return config, settings, state, initial


@pytest.mark.parametrize("failure", ["missing_category", "missing_tax_id"])
def test_export_reports_invalid_records_without_losing_valid_records(tmp_path, failure):
    config, settings, _state, initial = setup(tmp_path)

    class InvalidSource(Source):
        def rows(self, table, key):
            if failure == "missing_category" and table == "articuloclase":
                return []
            if failure == "missing_tax_id" and table == "cliente":
                return [{"EmpresaID": 1, "NombreES": "Cliente", "CIF": ""}]
            return super().rows(table, key)

    job = initial.prepare(settings, InvalidSource())
    packages = exported(config, job)
    exported_kinds = [kind for _, rows in packages for kind, _, _, _ in rows]
    assert job["status"] == "awaiting_import"
    assert job["skippedCount"] == (2 if failure == "missing_category" else 1)
    assert len(job["skipped"]) == job["skippedCount"]
    if failure == "missing_category":
        assert job["products"] == 0 and job["customers"] == 1
        assert exported_kinds.count("customer") == 1
        assert all(item["kind"] == "product" for item in job["skipped"])
    else:
        assert job["products"] == 2 and job["customers"] == 0
        assert exported_kinds.count("product") == 2
        assert all(item["kind"] == "customer" for item in job["skipped"])


def test_export_with_only_invalid_records_still_cleans_generation(tmp_path):
    config, settings, state, initial = setup(tmp_path)

    class InvalidSource(Source):
        def rows(self, table, key):
            if table == "articuloclase":
                return []
            if table == "cliente":
                return [{"EmpresaID": 1, "NombreES": "Cliente", "CIF": ""}]
            return super().rows(table, key)

    with pytest.raises(MappingError, match="No hay productos ni clientes válidos"):
        initial.prepare(settings, InvalidSource())

    assert list((config.directory / "initial-load").iterdir()) == []
    assert state.get("initial_load") is None


def test_unicode_variants_pack_net_prices_and_verified_restart_adoption(tmp_path):
    config, settings, state, initial = setup(tmp_path)
    source = Source()
    job = initial.prepare(settings, source)
    packages = exported(config, job)
    prices = [v["unitPrice"] for _, rows in packages for k, _, v, _ in rows if k == "price"]
    # The Bohao amount (12.10 €) reaches B2B unchanged, with no tax removed.
    assert prices == [121000, 726000, 121000, 726000, 121000, 726000]
    assert state.resource("category:1") is None
    restarted = InitialLoad(config, State(state.path), threading.Event(), lambda: None, lambda _: None)
    result = restarted.adopt(settings, Imported(packages))
    assert result["adoptedProducts"] == 2
    assert result["adoptedCustomers"] == 1
    engine = Engine(config, state)
    engine.sync_image = lambda *args: None
    engine.capture_stock = lambda *args: None
    # An unchanged first normal cycle needs no remote catalogue/customer mutation.
    for article in source.rows("articulo", "ArticuloID"):
        engine.catalogue(source, object(), settings, article)
    engine.customers(object(), settings, next(iter(source.rows("cliente", "EmpresaID"))))


@pytest.mark.parametrize("failure", ["pending", "missing", "wrong"])
def test_incomplete_or_different_import_never_adopts(tmp_path, failure):
    config, settings, state, initial = setup(tmp_path)
    job = initial.prepare(settings, Source())
    remote = Imported(exported(config, job))
    if failure == "pending":
        remote.status = "processing"
    elif failure == "missing":
        remote.results[job["packages"][0]["exportId"]].pop()
    else:
        remote.results[job["packages"][0]["exportId"]][0]["fingerprint"] = "wrong"
    with pytest.raises(MappingError):
        initial.adopt(settings, remote)
    assert state.get("initial_load")["status"] == "awaiting_import"
    assert state.resource("category:1") is None


def test_changed_remote_price_is_not_cached_as_unchanged(tmp_path):
    config, settings, state, initial = setup(tmp_path)
    job = initial.prepare(settings, Source())
    remote = Imported(exported(config, job))
    product = next(iter(remote.products.values()))
    product["variants"][0]["saleUnits"][0]["prices"][0]["unitPrice"] += 1
    result = initial.adopt(settings, remote)
    assert result["adoptedProducts"] == 1
    assert state.resource("product:" + product["externalId"]) is None


def test_split_keeps_variants_and_units_with_their_product(tmp_path, monkeypatch):
    monkeypatch.setattr("bridge.initial_load.MAX_ROWS", 13)
    config, settings, _, initial = setup(tmp_path)
    job = initial.prepare(settings, Source(5))
    assert len(job["packages"]) > 1
    for _, rows in exported(config, job):
        products = {e for k, e, _, _ in rows if k == "product"}
        variants = {e for k, e, _, _ in rows if k == "variant"}
        units = {e for k, e, _, _ in rows if k == "sale_unit"}
        for kind, external, value, _ in rows:
            if kind == "variant":
                assert value["productExternalId"] in products
            elif kind == "sale_unit":
                assert value["variantExternalId"] in variants
            elif kind == "price":
                assert external in units


def test_ten_thousand_products_export_without_loss_or_duplicate_identities(tmp_path):
    config, settings, _, initial = setup(tmp_path)
    job = initial.prepare(settings, Source(10_000))
    identities = [e for _, rows in exported(config, job) for k, e, _, _ in rows if k == "product"]
    assert len(identities) == len(set(identities)) == 10_000
    assert job["products"] == 10_000 and job["customers"] == 1
