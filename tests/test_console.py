import threading

from fastapi.testclient import TestClient

from bridge.app import create_app


def test_initial_load_blocks_automation_and_only_downloads_current_packages(tmp_path):
    app = create_app(tmp_path, start_worker=False)
    app.state.store.set(
        "initial_load",
        {"status": "awaiting_import", "generation": "demo", "packages": [{"filename": "bohao.zip"}]},
    )
    directory = tmp_path / "initial-load" / "demo"
    directory.mkdir(parents=True)
    (directory / "bohao.zip").write_bytes(b"export")
    with TestClient(app) as client:
        headers = {"x-bridge-csrf": client.get("/api/status").json()["csrf"]}
        assert client.post("/api/automation", json={"enabled": True}, headers=headers).status_code == 409
        assert client.get("/api/initial/download/config.json").status_code == 404
        download = client.get("/api/initial/download/bohao.zip")
        assert download.content == b"export"
        assert "attachment" in download.headers["content-disposition"]
        app.state.store.set("initial_load", {"status": "ready", "packages": []})
        assert client.post("/api/automation", json={"enabled": True}, headers=headers).status_code == 200


def test_orders_summary_accepts_current_net_only_contract(tmp_path, monkeypatch):
    from bridge.engine import Engine

    class Local:
        def initialize(self):
            pass

        def imported_orders(self):
            return []

    class Remote:
        def call(self, *args, **kwargs):
            return {
                "items": [
                    {
                        "id": "order",
                        "number": "PED-1",
                        "customer": {"name": "Shop"},
                        "status": "confirmed",
                        "version": 1,
                        "amounts": {"netCents": 1710},
                    }
                ]
            }

        def close(self):
            pass

    monkeypatch.setattr(Engine, "dependencies", lambda self: (None, Local(), Remote()))
    with TestClient(create_app(tmp_path, start_worker=False)) as client:
        response = client.get("/api/orders")
        assert response.status_code == 200
        assert response.json()["items"][0]["totalCents"] == 1710
        assert response.json()["items"][0]["netOnly"] is True


def test_console_configuration_secret_redaction_and_csrf(tmp_path):
    with TestClient(create_app(tmp_path, start_worker=False)) as client:
        assert client.get("/").status_code == 200
        token = client.get("/api/status").json()["csrf"]
        assert client.post("/api/settings", json={"mysql_password": "demo-secret"}).status_code == 403
        response = client.post(
            "/api/settings",
            json={"mysql_password": "demo-secret", "api_key": "key-secret"},
            headers={"x-bridge-csrf": token},
        )
        assert response.status_code == 200
        public = client.get("/api/settings").json()
        assert "mysql_password" not in public and "api_key" not in public
        assert public["has_mysql_password"] and public["has_api_key"]
        assert "demo-secret" not in (tmp_path / "config.json").read_text()
        assert (
            client.post(
                "/api/automation",
                json={"enabled": True},
                headers={"x-bridge-csrf": token, "origin": "https://attacker.invalid"},
            ).status_code
            == 403
        )


def test_dns_rebinding_and_remote_http_refused(tmp_path):
    with TestClient(create_app(tmp_path, start_worker=False)) as client:
        token = client.get("/api/status").json()["csrf"]
        assert client.get("/api/settings", headers={"host": "attacker.invalid"}).status_code == 403
        assert (
            client.post(
                "/api/settings", json={"b2b_url": "http://example.com"}, headers={"x-bridge-csrf": token}
            ).status_code
            == 422
        )


def test_update_shutdown_is_csrf_protected_and_waits_until_sync_is_idle(tmp_path):
    app = create_app(tmp_path, start_worker=False)
    stopped = threading.Event()
    app.state.request_shutdown = stopped.set
    with TestClient(app) as client:
        token = client.get("/api/status").json()["csrf"]
        assert client.post("/api/shutdown-for-update").status_code == 403
        headers = {"x-bridge-csrf": token}
        app.state.engine.running = True
        assert client.post("/api/shutdown-for-update", headers=headers).status_code == 409
        assert not app.state.engine.stop.is_set()

        app.state.engine.running = False
        app.state.engine.lock.acquire()
        try:
            assert client.post("/api/shutdown-for-update", headers=headers).status_code == 409
        finally:
            app.state.engine.lock.release()
        response = client.post("/api/shutdown-for-update", headers=headers)
        assert response.status_code == 200
        assert app.state.engine.stop.is_set()
        assert stopped.wait(timeout=2)
