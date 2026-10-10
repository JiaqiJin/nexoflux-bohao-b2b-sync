from decimal import Decimal

import pytest

from bridge.mapping import (
    MappingError,
    customer_payload,
    decode_id,
    external_id,
    native_order_amounts,
    scaled,
    whole,
)
from bridge.state import State


def test_decimal_precision_and_fractional_quantity_refusal():
    assert scaled(Decimal("12.5000")) == 125000
    assert scaled("12.5", 100) == 1250
    assert whole("24.0000") == 24
    with pytest.raises(MappingError):
        whole("0.5")


def test_net_only_order_uses_native_rates_and_compounded_frozen_discounts():
    order = {
        "orderDiscountBps": 500,
        "amounts": {"netCents": 18050},
        "lines": [
            {"quantity": 1, "unitPrice": 1000000, "lineDiscountBps": 1000, "netCents": 8550},
            {"quantity": 1, "unitPrice": 1000000, "lineDiscountBps": 0, "netCents": 9500},
        ],
    }
    amounts = native_order_amounts(order, [Decimal(21), Decimal(4)])
    assert amounts["totalCents"] == 20226
    assert [(g["rateBps"], g["baseCents"], g["taxCents"]) for g in amounts["taxGroups"]] == [
        (400, 9500, 380),
        (2100, 8550, 1796),
    ]
    order["amounts"]["netCents"] = 18051
    with pytest.raises(MappingError, match="Total neto"):
        native_order_amounts(order, [Decimal(21), Decimal(4)])


def test_current_customer_payload_does_not_require_tax_profile():
    payload = customer_payload({"EmpresaID": 1, "CIF": "B12345674", "CountryID": "ES"})
    assert "taxProfile" not in payload


def test_unverified_native_customer_fiscal_profiles_are_blocked():
    for extra in ({"CountryID": "FR"}, {"IVAClase": 1}, {"ReglaIVA": 2}, {"DescuentoExtra": 3}):
        with pytest.raises(MappingError):
            customer_payload({"EmpresaID": 1, "CIF": "B12345674", **extra})


def test_identity_preserves_variants_and_large_identifiers():
    parts = ["999999999999999999", "红", "M"]
    value = external_id("demo", "v", *parts)
    assert decode_id(value, "demo", "v") == parts
    assert external_id("demo", "v", "a", "bc", "") != external_id("demo", "v", "ab", "c", "")
    with pytest.raises(MappingError):
        decode_id(value, "other", "v")


def test_inbox_cursor_and_pending_work_survive_restart(tmp_path):
    path = tmp_path / "state.db"
    state = State(path)
    state.ingest([{"sequence": 1, "recordType": "order", "recordId": "one"}], 1)
    state.ingest([{"sequence": 1, "recordType": "order", "recordId": "one"}], 1)
    restored = State(path)
    assert restored.get("cursor") == 1
    assert len(restored.pending()) == 1
    restored.finish(restored.pending()[0]["id"])
    assert not State(path).pending()


def test_blocked_entity_does_not_skip_to_newer_work(tmp_path):
    state = State(tmp_path / "state.db")
    state.enqueue("1", "order", {"entity": "same"})
    state.enqueue("2", "order", {"entity": "same"})
    state.enqueue("3", "order", {"entity": "other"})
    jobs = state.pending()
    assert [j["key"] for j in jobs] == ["1", "3"]
    state.fail(jobs[0]["id"], "Conflict", permanent=True)
    assert [j["key"] for j in state.pending()] == ["3"]
    state.retry()
    assert state.pending()[0]["key"] == "1"


def test_only_one_worker_holds_lease(tmp_path):
    first = State(tmp_path / "state.db")
    second = State(tmp_path / "state.db")
    assert first.acquire()
    assert not second.acquire()
    first.release()
    assert second.acquire()


def test_abandoned_process_lease_recovers_and_compaction_keeps_order_inbox(tmp_path):
    state = State(tmp_path / "state.db")
    with state.connection() as db:
        db.execute("INSERT INTO lease VALUES ('sync',9999999999,'dead',99999999)")
    assert state.acquire()
    for kind in ("catalogue", "customer", "stock", "order"):
        state.enqueue(kind, kind, {"entity": kind})
    for job in state.pending():
        state.finish(job["id"])
    with state.connection() as db:
        db.execute("UPDATE work SET updated_at=0")
    state.compact()
    with state.connection() as db:
        assert [r[0] for r in db.execute("SELECT kind FROM work")] == ["order"]
