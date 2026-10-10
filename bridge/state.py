import hashlib
import json
import os
import sqlite3
import time
import uuid
from contextlib import contextmanager
from pathlib import Path


def canonical(value) -> str:
    return json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":"), default=str)


def fingerprint(value) -> str:
    return hashlib.sha256(canonical(value).encode()).hexdigest()


class State:
    def __init__(self, path: Path):
        self.path = path
        self.owner = uuid.uuid4().hex
        path.parent.mkdir(parents=True, exist_ok=True)
        with self.connection() as db:
            db.executescript("""
                PRAGMA journal_mode=WAL;
                CREATE TABLE IF NOT EXISTS setting (key TEXT PRIMARY KEY, value TEXT NOT NULL);
                CREATE TABLE IF NOT EXISTS work (
                    id INTEGER PRIMARY KEY, key TEXT UNIQUE NOT NULL, kind TEXT NOT NULL,
                    payload TEXT NOT NULL, state TEXT NOT NULL DEFAULT 'pending',
                    attempts INTEGER NOT NULL DEFAULT 0, next_at REAL NOT NULL DEFAULT 0,
                    error TEXT, created_at REAL NOT NULL, updated_at REAL NOT NULL);
                CREATE INDEX IF NOT EXISTS work_due ON work(state,next_at);
                CREATE INDEX IF NOT EXISTS work_entity ON work(kind,json_extract(payload,'$.entity'),id)
                    WHERE state!='done';
                CREATE TABLE IF NOT EXISTS event (
                    id INTEGER PRIMARY KEY, level TEXT NOT NULL, message TEXT NOT NULL,
                    created_at REAL NOT NULL);
                CREATE TABLE IF NOT EXISTS resource (
                    key TEXT PRIMARY KEY, fingerprint TEXT NOT NULL, value TEXT NOT NULL);
                CREATE TABLE IF NOT EXISTS lease (key TEXT PRIMARY KEY, expires_at REAL NOT NULL, owner TEXT, pid INTEGER);
            """)
            if "owner" not in {row[1] for row in db.execute("PRAGMA table_info(lease)")}:
                db.execute("ALTER TABLE lease ADD COLUMN owner TEXT")
            if "pid" not in {row[1] for row in db.execute("PRAGMA table_info(lease)")}:
                db.execute("ALTER TABLE lease ADD COLUMN pid INTEGER")

    @contextmanager
    def connection(self):
        db = sqlite3.connect(self.path, timeout=30)
        db.row_factory = sqlite3.Row
        try:
            with db:
                yield db
        finally:
            db.close()

    def get(self, key, default=None):
        with self.connection() as db:
            row = db.execute("SELECT value FROM setting WHERE key=?", (key,)).fetchone()
        return json.loads(row[0]) if row else default

    def set(self, key, value):
        with self.connection() as db:
            db.execute(
                "INSERT INTO setting VALUES (?,?) ON CONFLICT(key) DO UPDATE SET value=excluded.value",
                (key, canonical(value)),
            )

    def enqueue(self, key, kind, payload, db=None):
        if db is None:
            with self.connection() as connection:
                return self.enqueue(key, kind, payload, connection)
        db.execute(
            "INSERT OR IGNORE INTO work(key,kind,payload,created_at,updated_at) VALUES (?,?,?,?,?)",
            (key, kind, canonical(payload), time.time(), time.time()),
        )

    def ingest(self, changes, cursor):
        with self.connection() as db:
            for change in changes:
                if change["recordType"] == "order":
                    payload = {"id": change["recordId"], "entity": change["recordId"]}
                    self.enqueue(f"change:{change['sequence']}", "order", payload, db)
            db.execute(
                "INSERT INTO setting VALUES ('cursor',?) ON CONFLICT(key) DO UPDATE SET value=excluded.value",
                (canonical(cursor),),
            )

    def enqueue_scan(self, kind, rows, key, run, stop, heartbeat=None):
        """Bounded transactions keep a large initial scan durable without one commit per row."""
        batch = []
        for row in rows:
            if stop.is_set():
                break
            batch.append(row)
            if len(batch) == 200:
                self._enqueue_scan_batch(kind, batch, key, run)
                if heartbeat:
                    heartbeat()
                batch = []
        if batch:
            self._enqueue_scan_batch(kind, batch, key, run)

    def _enqueue_scan_batch(self, kind, rows, key, run):
        with self.connection() as db:
            for row in rows:
                entity = row[key] if kind in ("catalogue", "inventory") else str(row[key])
                active = db.execute(
                    "SELECT 1 FROM work WHERE kind=? AND state!='done' "
                    "AND json_extract(payload,'$.entity')=? LIMIT 1",
                    (kind, entity),
                ).fetchone()
                if not active:
                    self.enqueue(
                        f"{kind}:{run}:{entity}", kind, {"entity": entity, "row": {key: row[key]}}, db
                    )

    def compact(self):
        # Transient captures are never replayed after completion. Order inbox keys stay durable.
        with self.connection() as db:
            db.execute(
                "DELETE FROM work WHERE state='done' AND kind IN ('catalogue','stock','customer','inventory') AND updated_at<?",
                (time.time() - 3600,),
            )
            db.execute("PRAGMA incremental_vacuum")

    def pending(self, limit=50):
        with self.connection() as db:
            rows = db.execute(
                """SELECT w.* FROM work w WHERE w.state='pending' AND w.next_at<=?
                AND NOT EXISTS (SELECT 1 FROM work old WHERE old.id<w.id AND old.state!='done'
                    AND old.kind=w.kind AND json_extract(old.payload,'$.entity')=json_extract(w.payload,'$.entity'))
                ORDER BY CASE w.kind WHEN 'order' THEN 0 WHEN 'stock' THEN 1
                    WHEN 'inventory' THEN 2 WHEN 'customer' THEN 3 ELSE 4 END, w.id LIMIT ?""",
                (time.time(), limit),
            ).fetchall()
        return [dict(row) | {"payload": json.loads(row["payload"])} for row in rows]

    def finish(self, work_id):
        with self.connection() as db:
            db.execute(
                "UPDATE work SET state='done',error=NULL,updated_at=? WHERE id=?", (time.time(), work_id)
            )

    def fail(self, work_id, message, permanent=False):
        with self.connection() as db:
            db.execute(
                "UPDATE work SET attempts=attempts+1,state=?,error=?,next_at=?+min(3600,30*(1<<min(attempts,7))),updated_at=? WHERE id=?",
                ("blocked" if permanent else "pending", message, time.time(), time.time(), work_id),
            )

    def retry(self):
        with self.connection() as db:
            db.execute("UPDATE work SET state='pending',next_at=0,error=NULL WHERE state!='done'")

    def event(self, message, level="info"):
        with self.connection() as db:
            db.execute(
                "INSERT INTO event(level,message,created_at) VALUES (?,?,?)", (level, message, time.time())
            )
            db.execute("DELETE FROM event WHERE id < (SELECT coalesce(max(id),0)-1000 FROM event)")

    def resource(self, key):
        with self.connection() as db:
            row = db.execute("SELECT * FROM resource WHERE key=?", (key,)).fetchone()
        return dict(row) | {"value": json.loads(row["value"])} if row else None

    def published_articles(self, installation):
        from .mapping import decode_id

        last = "product:"
        while True:
            with self.connection() as db:
                rows = db.execute(
                    "SELECT key FROM resource WHERE key LIKE 'product:%' AND key>? ORDER BY key LIMIT 200",
                    (last,),
                ).fetchall()
            if not rows:
                return
            for row in rows:
                yield decode_id(row["key"][8:], installation, "p")[0]
            last = rows[-1]["key"]

    def remember(self, key, content, value):
        with self.connection() as db:
            db.execute(
                "INSERT INTO resource VALUES (?,?,?) ON CONFLICT(key) DO UPDATE SET fingerprint=excluded.fingerprint,value=excluded.value",
                (key, fingerprint(content), canonical(value)),
            )

    def acquire(self):
        with self.connection() as db:
            row = db.execute("SELECT owner,pid FROM lease WHERE key='sync'").fetchone()
            if row and row["pid"] and not self.process_alive(row["pid"]):
                db.execute("DELETE FROM lease WHERE key='sync' AND owner=?", (row["owner"],))
            result = db.execute(
                "INSERT INTO lease(key,expires_at,owner,pid) VALUES ('sync',?,?,?) ON CONFLICT(key) DO UPDATE SET expires_at=excluded.expires_at,owner=excluded.owner,pid=excluded.pid WHERE lease.expires_at<?",
                (time.time() + 900, self.owner, os.getpid(), time.time()),
            )
            return result.rowcount == 1

    @staticmethod
    def process_alive(pid):
        import pywintypes
        import win32api
        import win32process

        try:
            handle = win32api.OpenProcess(0x1000, False, pid)
        except pywintypes.error as error:
            return error.winerror != 87  # Access denied does not prove a process stopped.
        try:
            return win32process.GetExitCodeProcess(handle) == 259
        finally:
            handle.Close()

    def renew(self):
        with self.connection() as db:
            result = db.execute(
                "UPDATE lease SET expires_at=? WHERE key='sync' AND owner=?", (time.time() + 900, self.owner)
            )
            if result.rowcount != 1:
                raise RuntimeError("Synchronization lease lost")

    def release(self):
        with self.connection() as db:
            db.execute("DELETE FROM lease WHERE key='sync' AND owner=?", (self.owner,))

    def active_work(self, kind, entity):
        with self.connection() as db:
            return (
                db.execute(
                    "SELECT 1 FROM work WHERE kind=? AND state!='done' AND json_extract(payload,'$.entity')=? LIMIT 1",
                    (kind, entity),
                ).fetchone()
                is not None
            )

    def dashboard(self):
        with self.connection() as db:
            counts = {row[0]: row[1] for row in db.execute("SELECT state,count(*) FROM work GROUP BY state")}
            errors = [
                dict(r)
                for r in db.execute(
                    "SELECT id,kind,error,attempts,state FROM work WHERE error IS NOT NULL ORDER BY id DESC LIMIT 30"
                )
            ]
            events = [dict(r) for r in db.execute("SELECT * FROM event ORDER BY id DESC LIMIT 30")]
        return {
            "counts": counts,
            "errors": errors,
            "events": events,
            "last_sync": self.get("last_sync"),
            "summary": self.get("summary", {}),
            "stock_sweep": self.get("last_stock_sweep"),
        }
