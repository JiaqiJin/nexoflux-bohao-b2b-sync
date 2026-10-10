"""Load only whitelisted CREATE statements from v6.22 into a separate demo database."""

import re
from pathlib import Path

import pymysql


def main():
    source = Path("docs/bohao-v622-schema.sql").read_text(encoding="utf-8")
    definitions = dict(re.findall(r"CREATE TABLE `([^`]+)` (\(.*?;)\s", source, re.DOTALL))
    tables = [
        "articulo",
        "articuloextra",
        "articuloclase",
        "articuloprop",
        "articulocodigobarra",
        "prop",
        "propdeta",
        "cliente",
        "clientesucursal",
        "stock",
        "pedidocliente",
        "pedidoclientearticulo",
        "pedidoclienteivatotal",
        "documentono",
        "dibujo",
        "albaran",
        "albaranarticulo",
        "ivatipo",
        "almacen",
    ]
    connection = pymysql.connect(
        host="127.0.0.1",
        port=3337,
        user="root",
        cursorclass=pymysql.cursors.DictCursor,
        autocommit=True,
        charset="utf8mb4",
    )
    with connection.cursor() as cursor:
        cursor.execute("CREATE DATABASE IF NOT EXISTS bohao_v622_demo CHARACTER SET utf8mb4")
        cursor.execute("USE bohao_v622_demo")
        cursor.execute("SET SESSION sql_mode=''")
        for table in tables:
            if table in definitions:
                cursor.execute(f"CREATE TABLE IF NOT EXISTS `{table}` " + definitions[table])
            elif table != "pedidoclienteivatotal":
                raise ValueError(f"Missing legacy table: {table}")
        for table in (
            "articulo",
            "articuloextra",
            "articuloclase",
            "articulocodigobarra",
            "cliente",
            "stock",
            "dibujo",
            "ivatipo",
            "almacen",
        ):
            cursor.execute(f"SHOW COLUMNS FROM bohao_v622_demo.`{table}`")
            old = {row["Field"].casefold(): row["Field"] for row in cursor.fetchall()}
            cursor.execute(f"SHOW COLUMNS FROM bohao_sync_demo.`{table}`")
            current = {row["Field"].casefold(): row["Field"] for row in cursor.fetchall()}
            shared = old.keys() & current.keys()
            targets = ",".join("`" + old[key] + "`" for key in sorted(shared))
            sources = ",".join("`" + current[key] + "`" for key in sorted(shared))
            cursor.execute(
                f"INSERT IGNORE INTO bohao_v622_demo.`{table}` ({targets}) SELECT {sources} FROM bohao_sync_demo.`{table}`"
            )
    connection.close()
    print("Demo v6.22 preparada en localhost:3337 / bohao_v622_demo")


if __name__ == "__main__":
    main()
