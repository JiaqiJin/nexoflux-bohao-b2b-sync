#!/usr/bin/env python3
"""
Bohao PDA API Bridge - Historical LAN Server
====================================================

REST API bridge connecting SUNMI PDA Android app to MySQL bohaosupermarket3.
Runs on the same PC as Bohao Restaurant Management Expert.

Database: MySQL (version depends on installation; 5.7.44 was verified locally)
Server: Flask on 0.0.0.0:5000

Requirements:
    pip install flask pymysql flask-cors waitress

Usage:
    python flask-server-complete.py
"""

import uuid
import logging
import datetime
import functools
import os
from decimal import Decimal

import pymysql
import pymysql.cursors
from flask import Flask, jsonify, request, g
from flask_cors import CORS

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

DB_CONFIG = {
    "host": os.environ.get("BOHAO_DB_HOST", "127.0.0.1"),
    "user": os.environ.get("BOHAO_DB_USER", ""),
    "password": os.environ.get("BOHAO_DB_PASSWORD", ""),
    "database": os.environ.get("BOHAO_DB_NAME", "bohaosupermarket3"),
    "charset": "utf8mb4",
    "cursorclass": pymysql.cursors.DictCursor,
    "autocommit": False,
}

# In-memory token store: {token_string: {empleado_id, nombre, login_time}}
_active_tokens: dict[str, dict] = {}

# ---------------------------------------------------------------------------
# Application setup
# ---------------------------------------------------------------------------

app = Flask(__name__)
CORS(app, resources={r"/api/*": {"origins": "*"}})

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
)
logger = logging.getLogger("bohao-api")

# ---------------------------------------------------------------------------
# Database helpers
# ---------------------------------------------------------------------------


def get_connection() -> pymysql.Connection:
    """Return a new pymysql connection from the config dict."""
    return pymysql.connect(**DB_CONFIG)


class DbConnection:
    """Context manager that provides a pymysql connection with auto-commit/rollback."""

    def __init__(self):
        self.conn: pymysql.Connection | None = None

    def __enter__(self) -> pymysql.Connection:
        self.conn = get_connection()
        self.conn.begin()
        return self.conn

    def __exit__(self, exc_type, exc_val, exc_tb):
        if exc_type is not None:
            self.conn.rollback()
        else:
            self.conn.commit()
        self.conn.close()
        return False


class DbConnectionReadOnly:
    """Context manager for read-only queries (no transaction needed)."""

    def __init__(self):
        self.conn: pymysql.Connection | None = None

    def __enter__(self) -> pymysql.Connection:
        self.conn = get_connection()
        return self.conn

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.conn.close()
        return False


# ---------------------------------------------------------------------------
# Custom JSON encoder for Decimal / datetime
# ---------------------------------------------------------------------------


class BohaoJSONEncoder(app.json_encoder if hasattr(app, "json_encoder") else None):
    """Extended JSON encoder that handles Decimal and datetime objects."""

    def default(self, obj):
        if isinstance(obj, Decimal):
            return float(obj)
        if isinstance(obj, (datetime.date, datetime.datetime)):
            return obj.isoformat()
        return super().default(obj)


app.json_encoder = BohaoJSONEncoder

# ---------------------------------------------------------------------------
# Auth decorator
# ---------------------------------------------------------------------------


def require_auth(f):
    """Decorator that enforces X-Auth-Token header against _active_tokens."""

    @functools.wraps(f)
    def decorated(*args, **kwargs):
        token = request.headers.get("X-Auth-Token")
        if not token or token not in _active_tokens:
            return jsonify({"status": "error", "message": "Unauthorized"}), 401
        g.auth_user = _active_tokens[token]
        return f(*args, **kwargs)

    return decorated


# ---------------------------------------------------------------------------
# Request logging middleware
# ---------------------------------------------------------------------------


@app.before_request
def log_request_info():
    logger.info(
        "%s %s from %s",
        request.method,
        request.path,
        request.remote_addr,
    )


# ---------------------------------------------------------------------------
# Error handlers
# ---------------------------------------------------------------------------


@app.errorhandler(pymysql.Error)
def db_error_handler(err):
    logger.error("Database error: %s", err)
    return jsonify({"status": "error", "message": "Database operation failed"}), 500


@app.errorhandler(400)
def bad_request(err):
    return jsonify({"status": "error", "message": "Bad request"}), 400


@app.errorhandler(404)
def not_found(err):
    return jsonify({"status": "error", "message": "Resource not found"}), 404


# ===========================================================================
# Health / Auth endpoints
# ===========================================================================


@app.route("/api/health", methods=["GET"])
def health_check():
    """Simple health check endpoint."""
    return jsonify({"status": "ok"})


@app.route("/api/auth/login", methods=["POST"])
def auth_login():
    """Authenticate an employee and return a session token.

    Request JSON:
        {"username": "<Nombre>", "password": "<Contrasena>"}

    Response:
        {"status": "success", "data": {"token": "...", "empleado_id": ..., "nombre": "..."}}
    """
    body = request.get_json(silent=True) or {}
    username = body.get("username", "").strip()
    password = body.get("password", "").strip()

    if not username or not password:
        return jsonify({"status": "error", "message": "Username and password required"}), 400

    try:
        with DbConnectionReadOnly() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "SELECT EmpleadoID, Nombre, Contrasena, ContrasenaSegura, Bloqueado "
                    "FROM empleado WHERE Nombre = %s",
                    (username,),
                )
                row = cur.fetchone()

        if not row:
            return jsonify({"status": "error", "message": "Invalid credentials"}), 401
        if row["Bloqueado"]:
            return jsonify({"status": "error", "message": "Account is blocked"}), 403
        if row["Contrasena"] != password and row.get("ContrasenaSegura") != password:
            return jsonify({"status": "error", "message": "Invalid credentials"}), 401

        token = str(uuid.uuid4())
        _active_tokens[token] = {
            "empleado_id": row["EmpleadoID"],
            "nombre": row["Nombre"],
            "login_time": datetime.datetime.now().isoformat(),
        }

        return jsonify({
            "status": "success",
            "data": {
                "token": token,
                "empleado_id": row["EmpleadoID"],
                "nombre": row["Nombre"],
            },
        })
    except pymysql.Error as exc:
        logger.error("Login DB error: %s", exc)
        return jsonify({"status": "error", "message": "Database error"}), 500


@app.route("/api/auth/logout", methods=["POST"])
@require_auth
def auth_logout():
    """Invalidate the current session token.

    Headers:
        X-Auth-Token: <token>
    """
    token = request.headers.get("X-Auth-Token")
    _active_tokens.pop(token, None)
    return jsonify({"status": "success", "message": "Logged out"})


# ===========================================================================
# Product endpoints
# ===========================================================================


@app.route("/api/articulo/<barcode>", methods=["GET"])
@require_auth
def get_articulo_by_barcode(barcode):
    """Look up a product by barcode.

    Searches articulo.CodigoBarra first, then falls back to articulocodigobarra.

    Path params:
        barcode - the barcode string to search

    Response:
        {"status": "success", "data": {product fields}}
    """
    try:
        with DbConnectionReadOnly() as conn:
            with conn.cursor() as cur:
                # Step 1: direct lookup in articulo
                cur.execute(
                    "SELECT ArticuloID, CodigoBarra, NombreES, NombreCN, "
                    "PrecioDetalle, PrecioMayor, PrecioOferta, PrecioCoste, "
                    "Oferta, UnidadNombre, Bloqueado, MiniStock, MaxiStock, "
                    "SitioEnAlmacen, SitioEnEstante, ClaseID "
                    "FROM articulo WHERE CodigoBarra = %s AND Bloqueado = 0 "
                    "LIMIT 1",
                    (barcode,),
                )
                product = cur.fetchone()

                # Step 2: fallback to articulocodigobarra
                if not product:
                    cur.execute(
                        "SELECT a.ArticuloID, a.CodigoBarra, a.NombreES, a.NombreCN, "
                        "a.PrecioDetalle, a.PrecioMayor, a.PrecioOferta, a.PrecioCoste, "
                        "a.Oferta, a.UnidadNombre, a.Bloqueado, a.MiniStock, a.MaxiStock, "
                        "a.SitioEnAlmacen, a.SitioEnEstante, a.ClaseID "
                        "FROM articulo a "
                        "JOIN articulocodigobarra acb ON a.ArticuloID = acb.ArticuloID "
                        "WHERE acb.CodigoBarra = %s AND a.Bloqueado = 0 "
                        "LIMIT 1",
                        (barcode,),
                    )
                    product = cur.fetchone()

        if not product:
            return jsonify({"status": "error", "message": "Product not found"}), 404

        return jsonify({"status": "success", "data": product})
    except pymysql.Error as exc:
        logger.error("get_articulo error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/articulo/search", methods=["GET"])
@require_auth
def search_articulo():
    """Search products by name or ID using LIKE patterns.

    Query params:
        q    - search term (required)
        limit - max results, default 20

    Response:
        {"status": "success", "data": [product, ...]}
    """
    q = request.args.get("q", "").strip()
    limit = request.args.get("limit", "20")
    try:
        limit = int(limit)
    except ValueError:
        limit = 20

    if not q:
        return jsonify({"status": "error", "message": "Query parameter 'q' is required"}), 400

    like = f"%{q}%"

    try:
        with DbConnectionReadOnly() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "SELECT ArticuloID, CodigoBarra, NombreES, NombreCN, "
                    "PrecioDetalle, PrecioMayor, PrecioOferta, PrecioCoste, "
                    "Oferta, UnidadNombre, Bloqueado "
                    "FROM articulo "
                    "WHERE (NombreES LIKE %s OR NombreCN LIKE %s OR ArticuloID LIKE %s) "
                    "AND Bloqueado = 0 "
                    "ORDER BY ArticuloID "
                    "LIMIT %s",
                    (like, like, like, limit),
                )
                rows = cur.fetchall()

        return jsonify({"status": "success", "data": rows})
    except pymysql.Error as exc:
        logger.error("search_articulo error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/articulo/<path:articulo_id>", methods=["PUT"])
@require_auth
def update_articulo(articulo_id):
    """Partial update of a product's fields.

    Path params:
        articulo_id - the ArticuloID (varchar 20)

    Request JSON (all fields optional — only included fields are updated):
        {
            "nombre_es": "string",
            "nombre_cn": "string",
            "precio_detalle": "decimal",
            "precio_mayor": "decimal",
            "precio_oferta": "decimal",
            "precio_coste": "decimal",
            "oferta": false,
            "bloqueado": false,
            "sitio_en_almacen": "string",
            "sitio_en_estante": "string",
            "mini_stock": "decimal",
            "maxi_stock": "decimal"
        }

    Response:
        {"status": "success", "data": {updated product}}
    """
    body = request.get_json(silent=True) or {}
    if not body:
        return jsonify({"status": "error", "message": "Request body is empty"}), 400

    # Map request fields to DB columns
    field_map = {
        "nombre_es": "NombreES",
        "nombre_cn": "NombreCN",
        "precio_detalle": "PrecioDetalle",
        "precio_mayor": "PrecioMayor",
        "precio_oferta": "PrecioOferta",
        "precio_coste": "PrecioCoste",
        "oferta": "Oferta",
        "bloqueado": "Bloqueado",
        "sitio_en_almacen": "SitioEnAlmacen",
        "sitio_en_estante": "SitioEnEstante",
        "mini_stock": "MiniStock",
        "maxi_stock": "MaxiStock",
    }

    set_clauses = []
    params = []
    for json_key, db_col in field_map.items():
        if json_key in body:
            set_clauses.append(f"{db_col} = %s")
            params.append(body[json_key])

    if not set_clauses:
        return jsonify({"status": "error", "message": "No valid fields to update"}), 400

    params.append(articulo_id)

    try:
        with DbConnection() as conn:
            cur = conn.cursor()

            cur.execute(
                f"UPDATE articulo SET {', '.join(set_clauses)} WHERE ArticuloID = %s",
                params,
            )
            if cur.rowcount == 0:
                return jsonify({"status": "error", "message": "Product not found"}), 404

            # Fetch updated row
            cur.execute(
                "SELECT ArticuloID, CodigoBarra, NombreES, NombreCN, "
                "PrecioDetalle, PrecioMayor, PrecioOferta, PrecioCoste, "
                "Oferta, UnidadNombre, Bloqueado, MiniStock, MaxiStock, "
                "SitioEnAlmacen, SitioEnEstante, ClaseID "
                "FROM articulo WHERE ArticuloID = %s",
                (articulo_id,),
            )
            updated = cur.fetchone()

        return jsonify({"status": "success", "data": updated})
    except pymysql.Error as exc:
        logger.error("update_articulo error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/articulo/<path:articulo_id>/stock", methods=["GET"])
@require_auth
def get_articulo_stock(articulo_id):
    """Get stock levels for a specific article across warehouses.

    Path params:
        articulo_id - the ArticuloID

    Query params:
        almacen - optional AlmacenID to filter

    Response:
        {"status": "success", "data": [stock rows]}
    """
    almacen = request.args.get("almacen", "").strip()

    try:
        with DbConnectionReadOnly() as conn:
            with conn.cursor() as cur:
                if almacen:
                    cur.execute(
                        "SELECT s.AlmacenID, al.NombreES AS AlmacenNombre, "
                        "s.ArticuloID, s.PropID1, s.PropID2, s.Stock "
                        "FROM stock s "
                        "JOIN almacen al ON s.AlmacenID = al.AlmacenID "
                        "WHERE s.ArticuloID = %s AND s.AlmacenID = %s "
                        "AND al.Bloqueado = 0",
                        (articulo_id, almacen),
                    )
                else:
                    cur.execute(
                        "SELECT s.AlmacenID, al.NombreES AS AlmacenNombre, "
                        "s.ArticuloID, s.PropID1, s.PropID2, s.Stock "
                        "FROM stock s "
                        "JOIN almacen al ON s.AlmacenID = al.AlmacenID "
                        "WHERE s.ArticuloID = %s AND al.Bloqueado = 0",
                        (articulo_id,),
                    )
                rows = cur.fetchall()

        return jsonify({"status": "success", "data": rows})
    except pymysql.Error as exc:
        logger.error("get_articulo_stock error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


# ===========================================================================
# Stock endpoints
# ===========================================================================


@app.route("/api/stock/low", methods=["GET"])
@require_auth
def get_low_stock():
    """List articles whose current stock is below their MiniStock threshold.

    Query params:
        almacen - AlmacenID (required)
        limit   - max results, default 50

    Response:
        {"status": "success", "data": [low-stock articles]}
    """
    almacen = request.args.get("almacen", "").strip()
    limit = request.args.get("limit", "50")
    try:
        limit = int(limit)
    except ValueError:
        limit = 50

    if not almacen:
        return jsonify({"status": "error", "message": "almacen parameter is required"}), 400

    try:
        with DbConnectionReadOnly() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "SELECT a.ArticuloID, a.NombreES, a.NombreCN, a.CodigoBarra, "
                    "a.UnidadNombre, a.MiniStock, a.MaxiStock, "
                    "s.Stock, s.AlmacenID "
                    "FROM articulo a "
                    "JOIN stock s ON a.ArticuloID = s.ArticuloID AND s.AlmacenID = %s "
                    "WHERE a.Bloqueado = 0 "
                    "AND a.MiniStock > 0 "
                    "AND s.Stock < a.MiniStock "
                    "ORDER BY (a.MiniStock - s.Stock) DESC "
                    "LIMIT %s",
                    (almacen, limit),
                )
                rows = cur.fetchall()

        return jsonify({"status": "success", "data": rows})
    except pymysql.Error as exc:
        logger.error("get_low_stock error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/stock/adjust", methods=["POST"])
@require_auth
def stock_adjust():
    """Create a stock adjustment (stockajuste header + lines + update stock).

    Request JSON:
        {
            "almacen_id": <int>,
            "operador_id": <int>,
            "lines": [
                {
                    "articulo_id": "<str>",
                    "prop_id1": "",
                    "prop_id2": "",
                    "cantidad": <decimal>,   -- positive to add, negative to subtract
                    "precio": <decimal>,
                    "precio_coste": <decimal>,
                    "nombre_es": "<str>",
                    "nombre_cn": "<str>",
                    "codigo_barra": "<str>"
                },
                ...
            ]
        }

    Response:
        {"status": "success", "data": {"documento_no": <int>}}
    """
    body = request.get_json(silent=True) or {}
    almacen_id = body.get("almacen_id")
    operador_id = body.get("operador_id")
    lines = body.get("lines", [])

    if not almacen_id or not operador_id or not lines:
        return jsonify({"status": "error", "message": "almacen_id, operador_id, and lines are required"}), 400

    try:
        with DbConnection() as conn:
            cur = conn.cursor()

            # 1. Insert header with DocumentoNo=0 (auto-increment)
            cur.execute(
                "INSERT INTO stockajuste "
                "(DocumentoNo, AlmacenID, OperadorID, Fecha, PrecioUsado, Bloqueado) "
                "VALUES (0, %s, %s, CURDATE(), 1, 0)",
                (almacen_id, operador_id),
            )
            cur.execute("SELECT LAST_INSERT_ID() AS doc_no")
            doc_no = cur.fetchone()["doc_no"]

            # 2. Insert lines and update stock
            total_cantidad = Decimal("0")
            line_count = 0

            for idx, line in enumerate(lines):
                cantidad = Decimal(str(line.get("cantidad", 0)))
                precio = Decimal(str(line.get("precio", 0)))
                precio_coste = Decimal(str(line.get("precio_coste", 0)))

                cur.execute(
                    "INSERT INTO stockajustearticulo "
                    "(DocumentoNo, ArticuloID, PropID1, PropID2, NombreES, NombreCN, "
                    "CodigoBarra, Cantidad, Precio, PrecioCoste, OrdenNo) "
                    "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                    (
                        doc_no,
                        line["articulo_id"],
                        line.get("prop_id1", ""),
                        line.get("prop_id2", ""),
                        line.get("nombre_es", ""),
                        line.get("nombre_cn", ""),
                        line.get("codigo_barra", ""),
                        cantidad,
                        precio,
                        precio_coste,
                        idx,
                    ),
                )

                # Update stock using ON DUPLICATE KEY
                cur.execute(
                    "INSERT INTO stock (AlmacenID, ArticuloID, PropID1, PropID2, Stock) "
                    "VALUES (%s, %s, %s, %s, %s) "
                    "ON DUPLICATE KEY UPDATE Stock = Stock + VALUES(Stock)",
                    (
                        almacen_id,
                        line["articulo_id"],
                        line.get("prop_id1", ""),
                        line.get("prop_id2", ""),
                        cantidad,
                    ),
                )

                total_cantidad += cantidad
                line_count += 1

            # 3. Update header totals
            cur.execute(
                "UPDATE stockajuste SET LineaTotal = %s, CantidadTotal = %s "
                "WHERE DocumentoNo = %s",
                (line_count, total_cantidad, doc_no),
            )

        return jsonify({"status": "success", "data": {"documento_no": doc_no}})
    except pymysql.Error as exc:
        logger.error("stock_adjust error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


# ===========================================================================
# Inventory endpoints
# ===========================================================================


@app.route("/api/inventario", methods=["POST"])
@require_auth
def create_inventario():
    """Create an inventory count header.

    Request JSON:
        {
            "almacen_id": <int>,
            "articulo_clase_id": <int>,  -- optional, 0 = all categories
            "operador_id": <int>
        }

    Response:
        {"status": "success", "data": {"documento_no": <int>}}
    """
    body = request.get_json(silent=True) or {}
    almacen_id = body.get("almacen_id")
    articulo_clase_id = body.get("articulo_clase_id", 0)
    operador_id = body.get("operador_id")

    if not almacen_id or operador_id is None:
        return jsonify({"status": "error", "message": "almacen_id and operador_id are required"}), 400

    try:
        with DbConnection() as conn:
            cur = conn.cursor()

            cur.execute(
                "INSERT INTO inventario "
                "(DocumentoNo, AlmacenID, ArticuloClaseID, OperadorID, "
                "Fecha, PrecioUsado, Bloqueado) "
                "VALUES (0, %s, %s, %s, CURDATE(), 1, 0)",
                (almacen_id, articulo_clase_id, operador_id),
            )
            cur.execute("SELECT LAST_INSERT_ID() AS doc_no")
            doc_no = cur.fetchone()["doc_no"]

        return jsonify({"status": "success", "data": {"documento_no": doc_no}})
    except pymysql.Error as exc:
        logger.error("create_inventario error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/inventario/<int:doc_no>/line", methods=["POST"])
@require_auth
def add_inventario_line(doc_no):
    """Add a counted line to an inventory document.

    Path params:
        doc_no - the inventory DocumentoNo

    Request JSON:
        {
            "articulo_id": "<str>",
            "prop_id1": "",
            "prop_id2": "",
            "cantidad": <decimal>,
            "precio": <decimal>,
            "precio_coste": <decimal>,
            "nombre_es": "<str>",
            "nombre_cn": "<str>",
            "codigo_barra": "<str>"
        }

    Response:
        {"status": "success", "data": {"documento_no": <int>}}
    """
    body = request.get_json(silent=True) or {}
    articulo_id = body.get("articulo_id")

    if not articulo_id:
        return jsonify({"status": "error", "message": "articulo_id is required"}), 400

    try:
        with DbConnection() as conn:
            cur = conn.cursor()

            # Verify inventario exists and is open
            cur.execute(
                "SELECT DocumentoNo, AlmacenID, LineaTotal FROM inventario "
                "WHERE DocumentoNo = %s AND Bloqueado = 0",
                (doc_no,),
            )
            header = cur.fetchone()
            if not header:
                return jsonify({"status": "error", "message": "Inventory document not found or already closed"}), 404

            cantidad = Decimal(str(body.get("cantidad", 0)))
            precio = Decimal(str(body.get("precio", 0)))
            precio_coste = Decimal(str(body.get("precio_coste", 0)))
            orden_no = (header["LineaTotal"] or 0) + 1

            cur.execute(
                "INSERT INTO inventarioarticulo "
                "(DocumentoNo, ArticuloID, PropID1, PropID2, NombreES, NombreCN, "
                "CodigoBarra, Cantidad, Precio, PrecioCoste, IVA, OrdenNo) "
                "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 0, %s)",
                (
                    doc_no,
                    articulo_id,
                    body.get("prop_id1", ""),
                    body.get("prop_id2", ""),
                    body.get("nombre_es", ""),
                    body.get("nombre_cn", ""),
                    body.get("codigo_barra", ""),
                    cantidad,
                    precio,
                    precio_coste,
                    orden_no,
                ),
            )

            # Update header totals
            cur.execute(
                "UPDATE inventario "
                "SET LineaTotal = LineaTotal + 1, "
                "    CantidadTotal = CantidadTotal + %s, "
                "    Total = Total + (%s * %s) "
                "WHERE DocumentoNo = %s",
                (cantidad, precio, cantidad, doc_no),
            )

        return jsonify({"status": "success", "data": {"documento_no": doc_no, "orden_no": orden_no}})
    except pymysql.Error as exc:
        logger.error("add_inventario_line error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/inventario/<int:doc_no>/close", methods=["PUT"])
@require_auth
def close_inventario(doc_no):
    """Close an inventory document and optionally adjust stock.

    Path params:
        doc_no - the inventory DocumentoNo

    Request JSON:
        {
            "adjust_stock": true   -- if true, overwrite stock with counted quantities
        }

    Response:
        {"status": "success", "data": {"documento_no": <int>}}
    """
    body = request.get_json(silent=True) or {}
    adjust_stock = body.get("adjust_stock", False)

    try:
        with DbConnection() as conn:
            cur = conn.cursor()

            # Verify inventario exists and is open
            cur.execute(
                "SELECT DocumentoNo, AlmacenID FROM inventario "
                "WHERE DocumentoNo = %s AND Bloqueado = 0",
                (doc_no,),
            )
            header = cur.fetchone()
            if not header:
                return jsonify({"status": "error", "message": "Inventory document not found or already closed"}), 404

            almacen_id = header["AlmacenID"]

            if adjust_stock:
                # Fetch all counted lines
                cur.execute(
                    "SELECT ArticuloID, PropID1, PropID2, Cantidad "
                    "FROM inventarioarticulo WHERE DocumentoNo = %s",
                    (doc_no,),
                )
                lines = cur.fetchall()

                for line in lines:
                    # Overwrite stock with counted quantity using REPLACE INTO
                    cur.execute(
                        "INSERT INTO stock (AlmacenID, ArticuloID, PropID1, PropID2, Stock) "
                        "VALUES (%s, %s, %s, %s, %s) "
                        "ON DUPLICATE KEY UPDATE Stock = VALUES(Stock)",
                        (
                            almacen_id,
                            line["ArticuloID"],
                            line["PropID1"],
                            line["PropID2"],
                            line["Cantidad"],
                        ),
                    )

            # Close the document
            cur.execute(
                "UPDATE inventario SET Bloqueado = 1 WHERE DocumentoNo = %s",
                (doc_no,),
            )

        return jsonify({"status": "success", "data": {"documento_no": doc_no}})
    except pymysql.Error as exc:
        logger.error("close_inventario error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


# ===========================================================================
# Sales / Ticket endpoints
# ===========================================================================


@app.route("/api/ticket", methods=["POST"])
@require_auth
def create_ticket():
    """Create a new sales ticket header.

    Request JSON:
        {
            "operador_id": <int>,
            "almacen_id": <int>,
            "precio_usado": <int>,      -- optional, default 1 (retail)
            "empresa_id": <int>         -- optional client, default 0
        }

    Response:
        {"status": "success", "data": {"documento_no": <int>}}
    """
    body = request.get_json(silent=True) or {}
    operador_id = body.get("operador_id")
    almacen_id = body.get("almacen_id")

    if operador_id is None or not almacen_id:
        return jsonify({"status": "error", "message": "operador_id and almacen_id are required"}), 400

    precio_usado = body.get("precio_usado", 1)
    empresa_id = body.get("empresa_id", 0)

    try:
        with DbConnection() as conn:
            cur = conn.cursor()

            cur.execute(
                "INSERT INTO ticket "
                "(DocumentoNo, OperadorID, AlmacenID, EmpresaID, Fecha, "
                "PrecioUsado, Cobrado, Bloqueado) "
                "VALUES (0, %s, %s, %s, CURDATE(), %s, -1, 0)",
                (operador_id, almacen_id, empresa_id, precio_usado),
            )
            cur.execute("SELECT LAST_INSERT_ID() AS doc_no")
            doc_no = cur.fetchone()["doc_no"]

        return jsonify({"status": "success", "data": {"documento_no": doc_no}})
    except pymysql.Error as exc:
        logger.error("create_ticket error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/ticket/<int:doc_no>/line", methods=["POST"])
@require_auth
def add_ticket_line(doc_no):
    """Add a line to a ticket and update ticket totals.

    Path params:
        doc_no - the ticket DocumentoNo

    Request JSON:
        {
            "articulo_id": "<str>",
            "prop_id1": "",
            "prop_id2": "",
            "nombre_es": "<str>",
            "nombre_cn": "<str>",
            "codigo_barra": "<str>",
            "cantidad": <decimal>,
            "precio": <decimal>,
            "precio_coste": <decimal>,
            "iva": <decimal>,           -- optional, default 0
            "descuento": <decimal>      -- optional, default 0
        }

    Response:
        {"status": "success", "data": {"documento_no": <int>, "orden_no": <int>}}
    """
    body = request.get_json(silent=True) or {}
    articulo_id = body.get("articulo_id")

    if not articulo_id:
        return jsonify({"status": "error", "message": "articulo_id is required"}), 400

    try:
        with DbConnection() as conn:
            cur = conn.cursor()

            # Verify ticket exists and is open
            cur.execute(
                "SELECT DocumentoNo, LineaTotal, Total, CantidadTotal "
                "FROM ticket WHERE DocumentoNo = %s AND Bloqueado = 0",
                (doc_no,),
            )
            header = cur.fetchone()
            if not header:
                return jsonify({"status": "error", "message": "Ticket not found or already closed"}), 404

            cantidad = Decimal(str(body.get("cantidad", 1)))
            precio = Decimal(str(body.get("precio", 0)))
            precio_coste = Decimal(str(body.get("precio_coste", 0)))
            iva = Decimal(str(body.get("iva", 0)))
            descuento = Decimal(str(body.get("descuento", 0)))
            orden_no = (header["LineaTotal"] or 0) + 1
            linea_total = cantidad * precio

            cur.execute(
                "INSERT INTO ticketarticulo "
                "(DocumentoNo, ArticuloID, PropID1, PropID2, "
                "NombreES, NombreCN, CodigoBarra, "
                "Cantidad, Precio, PrecioCoste, IVA, Descuento, OrdenNo) "
                "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                (
                    doc_no,
                    articulo_id,
                    body.get("prop_id1", ""),
                    body.get("prop_id2", ""),
                    body.get("nombre_es", ""),
                    body.get("nombre_cn", ""),
                    body.get("codigo_barra", ""),
                    cantidad,
                    precio,
                    precio_coste,
                    iva,
                    descuento,
                    orden_no,
                ),
            )

            # Update ticket totals
            cur.execute(
                "UPDATE ticket "
                "SET LineaTotal = %s, "
                "    CantidadTotal = CantidadTotal + %s, "
                "    Total = Total + %s "
                "WHERE DocumentoNo = %s",
                (orden_no, cantidad, linea_total, doc_no),
            )

        return jsonify({"status": "success", "data": {"documento_no": doc_no, "orden_no": orden_no}})
    except pymysql.Error as exc:
        logger.error("add_ticket_line error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/ticket/<int:doc_no>/close", methods=["PUT"])
@require_auth
def close_ticket(doc_no):
    """Close a ticket/albaran by setting Cobrado=-1, Bloqueado=1 and finalizing totals.

    Optionally assigns a cliente (EmpresaID) to the ticket.

    Path params:
        doc_no - the ticket DocumentoNo

    Request Body (optional):
        {"descuento": "decimal", "cliente_id": int}

    Response:
        {"status": "success", "data": {"documento_no": <int>, ...}}
    """
    data = request.get_json(silent=True) or {}
    cliente_id = data.get("cliente_id")

    try:
        with DbConnection() as conn:
            cur = conn.cursor()

            # Verify ticket exists and is open
            cur.execute(
                "SELECT DocumentoNo, Total, CantidadTotal, LineaTotal "
                "FROM ticket WHERE DocumentoNo = %s AND Bloqueado = 0",
                (doc_no,),
            )
            header = cur.fetchone()
            if not header:
                return jsonify({"status": "error", "message": "Ticket not found or already closed"}), 404

            # Recalculate totals from lines for accuracy
            cur.execute(
                "SELECT "
                "  COUNT(*) AS line_count, "
                "  COALESCE(SUM(Cantidad), 0) AS total_qty, "
                "  COALESCE(SUM(Cantidad * Precio), 0) AS total_amount "
                "FROM ticketarticulo WHERE DocumentoNo = %s",
                (doc_no,),
            )
            totals = cur.fetchone()

            update_fields = [
                "Cobrado = -1",
                "Bloqueado = 1",
                "LineaTotal = %s",
                "CantidadTotal = %s",
                "Total = %s",
                "TiempoUltimoEditar = NOW()",
            ]
            update_values = [
                totals["line_count"],
                totals["total_qty"],
                totals["total_amount"],
            ]

            if cliente_id is not None:
                update_fields.append("EmpresaID = %s")
                update_values.append(cliente_id)

            update_values.append(doc_no)

            cur.execute(
                "UPDATE ticket "
                "SET " + ", ".join(update_fields) + " "
                "WHERE DocumentoNo = %s",
                tuple(update_values),
            )

        response_data = {
            "documento_no": doc_no,
            "linea_total": totals["line_count"],
            "cantidad_total": float(totals["total_qty"]),
            "total": float(totals["total_amount"]),
        }
        if cliente_id is not None:
            response_data["cliente_id"] = cliente_id

        return jsonify({
            "status": "success",
            "data": response_data,
        })
    except pymysql.Error as exc:
        logger.error("close_ticket error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/ticket/<int:doc_no>", methods=["GET"])
@require_auth
def get_ticket(doc_no):
    """Get a ticket with all its lines.

    Path params:
        doc_no - the ticket DocumentoNo

    Response:
        {"status": "success", "data": {"header": {...}, "lines": [...]}}
    """
    try:
        with DbConnectionReadOnly() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "SELECT DocumentoNo, Fecha, OperadorID, AlmacenID, "
                    "EmpresaID, Total, CantidadTotal, LineaTotal, "
                    "Cobrado, Bloqueado, PrecioUsado "
                    "FROM ticket WHERE DocumentoNo = %s",
                    (doc_no,),
                )
                header = cur.fetchone()

                if not header:
                    return jsonify({"status": "error", "message": "Ticket not found"}), 404

                cur.execute(
                    "SELECT ArticuloID, PropID1, PropID2, NombreES, NombreCN, "
                    "CodigoBarra, Cantidad, Precio, PrecioCoste, IVA, Descuento, OrdenNo "
                    "FROM ticketarticulo "
                    "WHERE DocumentoNo = %s ORDER BY OrdenNo",
                    (doc_no,),
                )
                lines = cur.fetchall()

        return jsonify({"status": "success", "data": {"header": header, "lines": lines}})
    except pymysql.Error as exc:
        logger.error("get_ticket error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/ticket/today", methods=["GET"])
@require_auth
def get_tickets_today():
    """Get today's tickets for a given operator.

    Query params:
        operador - OperadorID (required)

    Response:
        {"status": "success", "data": [ticket headers]}
    """
    operador = request.args.get("operador", "").strip()

    if not operador:
        return jsonify({"status": "error", "message": "operador parameter is required"}), 400

    today = datetime.date.today().isoformat()

    try:
        with DbConnectionReadOnly() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "SELECT DocumentoNo, Fecha, OperadorID, AlmacenID, "
                    "Total, CantidadTotal, LineaTotal, Cobrado, PrecioUsado "
                    "FROM ticket "
                    "WHERE OperadorID = %s AND Fecha = %s "
                    "ORDER BY DocumentoNo DESC",
                    (operador, today),
                )
                rows = cur.fetchall()

        return jsonify({"status": "success", "data": rows})
    except pymysql.Error as exc:
        logger.error("get_tickets_today error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


# ===========================================================================
# Payment endpoints
# ===========================================================================


@app.route("/api/pago", methods=["POST"])
@require_auth
def create_pago():
    """Record a payment against a ticket and set Cobrado=1.

    Request JSON:
        {
            "ticket_no": <int>,          -- ticket DocumentoNo being paid
            "pago_forma_id": <int>,      -- payment method ID
            "importe": <decimal>,        -- payment amount
            "operador_id": <int>
        }

    Response:
        {"status": "success", "data": {"documento_no": <int>}}
    """
    body = request.get_json(silent=True) or {}
    ticket_no = body.get("ticket_no")
    pago_forma_id = body.get("pago_forma_id")
    importe = body.get("importe")
    operador_id = body.get("operador_id")

    if not all([ticket_no, pago_forma_id, importe, operador_id]):
        return jsonify({"status": "error", "message": "ticket_no, pago_forma_id, importe, and operador_id are required"}), 400

    try:
        with DbConnection() as conn:
            cur = conn.cursor()

            # Verify ticket exists
            cur.execute(
                "SELECT DocumentoNo, Total FROM ticket WHERE DocumentoNo = %s",
                (ticket_no,),
            )
            ticket = cur.fetchone()
            if not ticket:
                return jsonify({"status": "error", "message": "Ticket not found"}), 404

            # Create payment record
            cur.execute(
                "INSERT INTO pago "
                "(DocumentoNo, Fecha, PagoFormaID, Importe, OperadorID, Bloqueado) "
                "VALUES (0, CURDATE(), %s, %s, %s, 0)",
                (pago_forma_id, importe, operador_id),
            )
            cur.execute("SELECT LAST_INSERT_ID() AS doc_no")
            pago_doc_no = cur.fetchone()["doc_no"]

            # Update payment to reference the ticket via DocumentoOriginalNo
            cur.execute(
                "UPDATE pago SET DocumentoOriginalNo = %s WHERE DocumentoNo = %s",
                (ticket_no, pago_doc_no),
            )

            # Mark ticket as Cobrado=1 (fully charged)
            cur.execute(
                "UPDATE ticket SET Cobrado = 1, TiempoUltimoEditar = NOW() "
                "WHERE DocumentoNo = %s",
                (ticket_no,),
            )

        return jsonify({"status": "success", "data": {"documento_no": pago_doc_no}})
    except pymysql.Error as exc:
        logger.error("create_pago error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/pagoformas", methods=["GET"])
@require_auth
def get_pago_formas():
    """List all active payment methods.

    Response:
        {"status": "success", "data": [pagoforma rows]}
    """
    try:
        with DbConnectionReadOnly() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "SELECT PagoFormaID, Nombre FROM pagoforma "
                    "WHERE Bloqueado = 0 ORDER BY PagoFormaID"
                )
                rows = cur.fetchall()

        return jsonify({"status": "success", "data": rows})
    except pymysql.Error as exc:
        logger.error("get_pago_formas error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


# ===========================================================================
# Receiving / Stock Entrada endpoints
# ===========================================================================


@app.route("/api/stockentrada", methods=["POST"])
@require_auth
def create_stockentrada():
    """Create a goods receiving header.

    Request JSON:
        {
            "almacen_id": <int>,
            "operador_id": <int>,
            "empresa_id": <int>          -- optional supplier ID, default 0
        }

    Response:
        {"status": "success", "data": {"documento_no": <int>}}
    """
    body = request.get_json(silent=True) or {}
    almacen_id = body.get("almacen_id")
    operador_id = body.get("operador_id")

    if not almacen_id or operador_id is None:
        return jsonify({"status": "error", "message": "almacen_id and operador_id are required"}), 400

    empresa_id = body.get("empresa_id", 0)

    try:
        with DbConnection() as conn:
            cur = conn.cursor()

            cur.execute(
                "INSERT INTO stockentrada "
                "(DocumentoNo, AlmacenID, OperadorID, EmpresaID, Fecha, "
                "PrecioUsado, Bloqueado) "
                "VALUES (0, %s, %s, %s, CURDATE(), 1, 0)",
                (almacen_id, operador_id, empresa_id),
            )
            cur.execute("SELECT LAST_INSERT_ID() AS doc_no")
            doc_no = cur.fetchone()["doc_no"]

        return jsonify({"status": "success", "data": {"documento_no": doc_no}})
    except pymysql.Error as exc:
        logger.error("create_stockentrada error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/stockentrada/<int:doc_no>/line", methods=["POST"])
@require_auth
def add_stockentrada_line(doc_no):
    """Add a receiving line and increment stock.

    Path params:
        doc_no - the stockentrada DocumentoNo

    Request JSON:
        {
            "articulo_id": "<str>",
            "prop_id1": "",
            "prop_id2": "",
            "cantidad": <decimal>,
            "precio": <decimal>,
            "precio_coste": <decimal>,
            "nombre_es": "<str>",
            "nombre_cn": "<str>",
            "codigo_barra": "<str>"
        }

    Response:
        {"status": "success", "data": {"documento_no": <int>, "orden_no": <int>}}
    """
    body = request.get_json(silent=True) or {}
    articulo_id = body.get("articulo_id")

    if not articulo_id:
        return jsonify({"status": "error", "message": "articulo_id is required"}), 400

    try:
        with DbConnection() as conn:
            cur = conn.cursor()

            # Verify stockentrada exists and is open
            cur.execute(
                "SELECT DocumentoNo, AlmacenID, LineaTotal "
                "FROM stockentrada WHERE DocumentoNo = %s AND Bloqueado = 0",
                (doc_no,),
            )
            header = cur.fetchone()
            if not header:
                return jsonify({"status": "error", "message": "Stock entrada not found or already closed"}), 404

            almacen_id = header["AlmacenID"]
            cantidad = Decimal(str(body.get("cantidad", 0)))
            precio = Decimal(str(body.get("precio", 0)))
            precio_coste = Decimal(str(body.get("precio_coste", 0)))
            orden_no = (header["LineaTotal"] or 0) + 1

            # Insert line
            cur.execute(
                "INSERT INTO stockentradaarticulo "
                "(DocumentoNo, ArticuloID, PropID1, PropID2, NombreES, NombreCN, "
                "CodigoBarra, Cantidad, Precio, PrecioCoste, OrdenNo) "
                "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                (
                    doc_no,
                    articulo_id,
                    body.get("prop_id1", ""),
                    body.get("prop_id2", ""),
                    body.get("nombre_es", ""),
                    body.get("nombre_cn", ""),
                    body.get("codigo_barra", ""),
                    cantidad,
                    precio,
                    precio_coste,
                    orden_no,
                ),
            )

            # Increment stock
            cur.execute(
                "INSERT INTO stock (AlmacenID, ArticuloID, PropID1, PropID2, Stock) "
                "VALUES (%s, %s, %s, %s, %s) "
                "ON DUPLICATE KEY UPDATE Stock = Stock + VALUES(Stock)",
                (
                    almacen_id,
                    articulo_id,
                    body.get("prop_id1", ""),
                    body.get("prop_id2", ""),
                    cantidad,
                ),
            )

            # Update header totals
            cur.execute(
                "UPDATE stockentrada "
                "SET LineaTotal = %s, "
                "    CantidadTotal = CantidadTotal + %s, "
                "    Total = Total + (%s * %s) "
                "WHERE DocumentoNo = %s",
                (orden_no, cantidad, precio_coste, cantidad, doc_no),
            )

        return jsonify({"status": "success", "data": {"documento_no": doc_no, "orden_no": orden_no}})
    except pymysql.Error as exc:
        logger.error("add_stockentrada_line error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/stockentrada/<int:doc_no>/close", methods=["PUT"])
@require_auth
def close_stockentrada(doc_no):
    """Close a goods receiving document by setting Bloqueado=1.

    Path params:
        doc_no - the stockentrada DocumentoNo

    Response:
        {"status": "success", "data": {"documento_no": <int>}}
    """
    try:
        with DbConnection() as conn:
            cur = conn.cursor()

            # Verify exists and is open
            cur.execute(
                "SELECT DocumentoNo FROM stockentrada "
                "WHERE DocumentoNo = %s AND Bloqueado = 0",
                (doc_no,),
            )
            header = cur.fetchone()
            if not header:
                return jsonify({"status": "error", "message": "Stock entrada not found or already closed"}), 404

            cur.execute(
                "UPDATE stockentrada SET Bloqueado = 1 WHERE DocumentoNo = %s",
                (doc_no,),
            )

        return jsonify({"status": "success", "data": {"documento_no": doc_no}})
    except pymysql.Error as exc:
        logger.error("close_stockentrada error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


# ===========================================================================
# Reference data endpoints
# ===========================================================================


@app.route("/api/almacenes", methods=["GET"])
@require_auth
def get_almacenes():
    """List all active warehouses.

    Response:
        {"status": "success", "data": [almacen rows]}
    """
    try:
        with DbConnectionReadOnly() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "SELECT AlmacenID, NombreES, NombreCN "
                    "FROM almacen WHERE Bloqueado = 0 "
                    "ORDER BY AlmacenID"
                )
                rows = cur.fetchall()

        return jsonify({"status": "success", "data": rows})
    except pymysql.Error as exc:
        logger.error("get_almacenes error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/ivatypes", methods=["GET"])
@require_auth
def get_iva_types():
    """List all active VAT/IVA types.

    Response:
        {"status": "success", "data": [ivatipo rows]}
    """
    try:
        with DbConnectionReadOnly() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "SELECT IVAID, Nombre, IVA, REQ "
                    "FROM ivatipo WHERE Bloqueado = 0 "
                    "ORDER BY IVAID"
                )
                rows = cur.fetchall()

        return jsonify({"status": "success", "data": rows})
    except pymysql.Error as exc:
        logger.error("get_iva_types error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


@app.route("/api/articuloclases", methods=["GET"])
@require_auth
def get_articulo_clases():
    """List all active product categories.

    Response:
        {"status": "success", "data": [articuloclase rows]}
    """
    try:
        with DbConnectionReadOnly() as conn:
            with conn.cursor() as cur:
                cur.execute(
                    "SELECT ClaseID, PadreID, NombreES, NombreCN, IVAID "
                    "FROM articuloclase WHERE Bloqueado = 0 "
                    "ORDER BY ClaseID"
                )
                rows = cur.fetchall()

        return jsonify({"status": "success", "data": rows})
    except pymysql.Error as exc:
        logger.error("get_articulo_clases error: %s", exc)
        return jsonify({"status": "error", "message": str(exc)}), 500


# ===========================================================================
# Device telemetry endpoints
# ===========================================================================


@app.route("/api/device/heartbeat", methods=["POST"])
@require_auth
def device_heartbeat():
    """Receive health metrics from a PDA device.

    Request JSON:
        {
            "serial_no": "string",
            "model": "string",
            "battery_level": <int>,
            "ram_available": <long>,
            "storage_available": <long>,
            "app_version": <int>,
            "wifi_rssi": <int>
        }

    Response:
        {"status": "success", "data": {"received": true}}
    """
    body = request.get_json(silent=True) or {}
    serial_no = body.get("serial_no", "unknown")

    logger.info(
        "Heartbeat from %s: battery=%s%%, ram=%s, storage=%s, app=%s, wifi=%s dBm",
        serial_no,
        body.get("battery_level", "?"),
        body.get("ram_available", "?"),
        body.get("storage_available", "?"),
        body.get("app_version", "?"),
        body.get("wifi_rssi", "?"),
    )

    return jsonify({"status": "success", "data": {"received": True}})


# ===========================================================================
# Main entry point
# ===========================================================================

if __name__ == "__main__":
    from waitress import serve

    logger.info("Starting Bohao PDA API Bridge on 0.0.0.0:5000 with Waitress")
    serve(app, host="0.0.0.0", port=5000, threads=20)
