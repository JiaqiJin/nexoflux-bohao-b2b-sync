"""Clone a small demo from the supplied local schema into an isolated MySQL instance."""

import getpass
import json
import os
from pathlib import Path

import pymysql


def main():
    source = pymysql.connect(
        host="127.0.0.1",
        user=os.environ.get("BOHAO_SOURCE_USER") or input("Usuario MySQL origen: "),
        password=os.environ.get("BOHAO_SOURCE_PASSWORD") or getpass.getpass("Contraseña MySQL origen: "),
        database="bohaosupermarket3",
        cursorclass=pymysql.cursors.DictCursor,
    )
    destination = pymysql.connect(
        host="127.0.0.1",
        port=3337,
        user="root",
        password="",
        cursorclass=pymysql.cursors.DictCursor,
        autocommit=True,
    )
    with source.cursor() as original, destination.cursor() as target:
        target.execute("CREATE DATABASE IF NOT EXISTS bohao_sync_demo CHARACTER SET utf8mb4")
        target.execute("USE bohao_sync_demo")
        target.execute("SET SESSION sql_mode=''")
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
        for table in tables:
            original.execute(f"SHOW CREATE TABLE `{table}`")
            create = original.fetchone()["Create Table"].replace(
                "CREATE TABLE", "CREATE TABLE IF NOT EXISTS", 1
            )
            target.execute(create)
        original.execute(
            "SELECT * FROM articulo WHERE PropCount=0 AND PrecioMayor>0 AND Bloqueado=0 AND Privado=0 ORDER BY ArticuloID LIMIT 3"
        )
        articles = original.fetchall()
        datasets = {"articulo": articles}
        for table in ("articuloclase", "ivatipo", "almacen"):
            original.execute(f"SELECT * FROM `{table}`")
            datasets[table] = original.fetchall()
        original.execute("SELECT * FROM cliente LIMIT 1")
        customer = original.fetchone()
        customer.update(
            EmpresaID=1001,
            NombreES="Cliente demo del bridge",
            CIF="B12345674",
            CountryID="ES",
            Email="demo@example.com",
            Bloqueado=0,
        )
        datasets["cliente"] = [customer]
        for article in articles:
            for table in ("articuloextra", "articulocodigobarra"):
                original.execute(f"SELECT * FROM `{table}` WHERE ArticuloID=%s", (article["ArticuloID"],))
                datasets.setdefault(table, []).extend(original.fetchall())
            if article["DibujoID"]:
                original.execute("SELECT * FROM dibujo WHERE DibujoID=%s", (article["DibujoID"],))
                datasets.setdefault("dibujo", []).extend(original.fetchall())
        for table, rows in datasets.items():
            for row in rows:
                statement = f"INSERT IGNORE INTO `{table}` ({','.join('`' + key + '`' for key in row)}) VALUES ({','.join(['%s'] * len(row))})"
                target.execute(statement, tuple(row.values()))
        for article in articles:
            target.execute(
                "INSERT IGNORE INTO stock(AlmacenID,ArticuloID,PropCount,PropID1,PropID2,Stock) VALUES(1,%s,0,'','',100)",
                (article["ArticuloID"],),
            )
        Path(".scratch/demo-articles.json").write_text(
            json.dumps([r["ArticuloID"] for r in articles]), encoding="utf-8"
        )
        print(
            f"Demo creada en localhost:3337 / bohao_sync_demo: {len(articles)} artículos, 1 cliente, stock 100 por artículo"
        )
    source.close()
    destination.close()


if __name__ == "__main__":
    main()
