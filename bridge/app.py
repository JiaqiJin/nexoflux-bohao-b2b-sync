import secrets
import threading
from contextlib import asynccontextmanager
from pathlib import Path

from fastapi import BackgroundTasks, FastAPI, HTTPException, Request
from fastapi.responses import FileResponse, JSONResponse
from fastapi.staticfiles import StaticFiles
from pydantic import ValidationError

from .config import ConfigStore, Settings, data_directory
from .engine import Engine, safe_error
from .state import State


def create_app(directory=None, start_worker=True):
    directory = Path(directory or data_directory())
    config = ConfigStore(directory)
    state = State(directory / "sync.db")
    engine = Engine(config, state)
    csrf = secrets.token_urlsafe(32)

    @asynccontextmanager
    async def lifespan(app):
        thread = None
        if start_worker:
            thread = threading.Thread(target=engine.worker, daemon=True)
            thread.start()
        yield
        engine.stop.set()
        if thread:
            thread.join(timeout=35)

    app = FastAPI(
        title="Nexoflux · Bohao Sync", lifespan=lifespan, docs_url=None, redoc_url=None, openapi_url=None
    )
    app.state.engine, app.state.config, app.state.store = engine, config, state

    @app.middleware("http")
    async def local_boundary(request: Request, call_next):
        if request.url.hostname not in {"127.0.0.1", "localhost", "testserver"}:
            return JSONResponse({"detail": "Host no autorizado"}, status_code=403)
        if request.method not in {"GET", "HEAD"}:
            origin = request.headers.get("origin")
            if (origin and origin not in {str(request.base_url).rstrip("/")}) or not secrets.compare_digest(
                request.headers.get("x-bridge-csrf", ""), csrf
            ):
                return JSONResponse({"detail": "Recarga la consola antes de continuar"}, status_code=403)
        response = await call_next(request)
        response.headers["X-Content-Type-Options"] = "nosniff"
        response.headers["Content-Security-Policy"] = (
            "default-src 'self'; script-src 'self'; style-src 'self'; img-src 'self' data:; frame-ancestors 'none'; base-uri 'none'"
        )
        response.headers["Cache-Control"] = "no-store"
        return response

    @app.get("/api/status")
    def status():
        return state.dashboard() | {
            "running": engine.running,
            "progress": engine.progress,
            "enabled": config.load().enabled,
            "csrf": csrf,
            "preflight": state.get("preflight"),
            "initial_load": state.get("initial_load"),
        }

    @app.post("/api/shutdown-for-update")
    def shutdown_for_update():
        if not engine.lock.acquire(blocking=False):
            raise HTTPException(409, "La sincronización está ocupada; inténtalo más tarde")
        try:
            if engine.running:
                raise HTTPException(409, "La sincronización está ocupada; inténtalo más tarde")
            request_shutdown = getattr(app.state, "request_shutdown", None)
            if request_shutdown is None:
                raise HTTPException(503, "El cierre seguro no está disponible")
            engine.stop.set()
        finally:
            engine.lock.release()

        def stop_after_response():
            import time

            time.sleep(0.5)
            request_shutdown()

        threading.Thread(target=stop_after_response, daemon=True).start()
        return {"ok": True}

    @app.get("/api/settings")
    def settings():
        return config.public()

    @app.post("/api/settings")
    def save_settings(body: dict):
        if engine.running:
            raise HTTPException(409, "Espera a que termine el ciclo antes de cambiar la configuración")
        current = config.load().model_dump()
        body.pop("installation_id", None)
        for field in ("mysql_password", "api_key"):
            if not body.get(field):
                body.pop(field, None)
        try:
            updated = Settings(**(current | body))
        except ValidationError as error:
            raise HTTPException(
                422, "Configuración inválida. Revisa URL, tarifa, almacenes e intervalo."
            ) from error
        scope_fields = ("mysql_host", "mysql_port", "mysql_database", "organization_id", "b2b_url")
        if state.get("scope") and any(getattr(updated, key) != current[key] for key in scope_fields):
            raise HTTPException(
                409, "No se puede cambiar la instalación vinculada; utiliza otra carpeta de datos"
            )
        config.save(updated)
        state.event("Configuración guardada")
        return {"ok": True}

    @app.post("/api/preflight")
    def preflight():
        try:
            return engine.preflight()
        except Exception as error:
            raise HTTPException(400, safe_error(error)) from error

    @app.post("/api/sync")
    def sync(background: BackgroundTasks):
        if engine.running:
            raise HTTPException(409, "Ya hay una sincronización en curso")
        background.add_task(engine.cycle)
        return {"ok": True}

    @app.post("/api/automation")
    def automation(body: dict):
        current = config.load()
        initial = state.get("initial_load")
        if body.get("enabled") and initial and initial.get("status") != "ready":
            raise HTTPException(409, "Completa y comprueba la carga inicial antes de activar automático")
        current.enabled = bool(body.get("enabled"))
        config.save(current)
        state.event(
            "Sincronización automática activada" if current.enabled else "Sincronización automática pausada"
        )
        return {"enabled": current.enabled}

    @app.post("/api/retry")
    def retry(background: BackgroundTasks):
        state.retry()
        background.add_task(engine.cycle)
        return {"ok": True}

    @app.get("/api/orders")
    def orders(cursor: str | None = None):
        b2b = None
        try:
            _settings, bohao, b2b = engine.dependencies()
            bohao.initialize()
            imported = {r["order_id"]: str(r["document_no"]) for r in bohao.imported_orders()}
            page = b2b.call("GET", "orders", params={"limit": 20, **({"cursor": cursor} if cursor else {})})
            # Show only summary, not the full customer PII or financial payload.
            items = [
                {
                    "id": o["id"],
                    "number": o["number"],
                    "customer": o["customer"]["name"],
                    "status": o["status"],
                    "version": o["version"],
                    "bohao_document": imported.get(o["id"]),
                    "totalCents": o["amounts"].get("totalCents", o["amounts"]["netCents"]),
                    "netOnly": "totalCents" not in o["amounts"],
                }
                for o in page["items"]
            ]
            return {"items": items, "nextCursor": page.get("nextCursor")}
        except Exception as error:
            raise HTTPException(400, safe_error(error)) from error
        finally:
            if b2b:
                b2b.close()

    @app.post("/api/orders/{order_id}/import")
    def import_order(order_id: str, background: BackgroundTasks):
        state.enqueue(
            f"manual:{order_id}:{__import__('time').time_ns()}", "order", {"id": order_id, "entity": order_id}
        )
        background.add_task(engine.cycle)
        return {"ok": True}

    @app.post("/api/initial/{action}")
    def initial_load(action: str, background: BackgroundTasks):
        if action not in {"prepare", "adopt"}:
            raise HTTPException(404, "Acción no disponible")
        try:
            engine.begin_initial(action)
        except Exception as error:
            raise HTTPException(409, safe_error(error)) from error
        background.add_task(engine.initial, action)
        return {"ok": True}

    @app.get("/api/initial/download/{filename}")
    def initial_download(filename: str):
        job = state.get("initial_load", {})
        if filename not in {package["filename"] for package in job.get("packages", [])}:
            raise HTTPException(404, "Paquete no disponible")
        path = directory / "initial-load" / job["generation"] / filename
        if not path.is_file():
            raise HTTPException(404, "Paquete no disponible")
        return FileResponse(path, media_type="application/zip", filename=filename)

    static = Path(__file__).parent / "static"
    app.mount("/static", StaticFiles(directory=static), name="static")

    @app.get("/")
    def home():
        return FileResponse(static / "index.html")

    return app
