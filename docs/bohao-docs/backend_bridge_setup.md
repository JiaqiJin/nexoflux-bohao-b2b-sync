# Configuración del Backend Bridge (Servidor API)

Para conectar una App móvil (PDA) a la base de datos de Bohao, es obligatorio utilizar un "Backend Bridge" (Puente). Esta guía detalla cómo configurarlo.

## 1. ¿Por qué un Puente?
- **Compatibilidad**: Bohao usa un driver de 32 bits. El puente (en Python 64 bits) usa una conexión nativa que salta esta limitación.
- **Seguridad**: No abres el puerto de MySQL al WiFi, solo el puerto de la API.
- **Rendimiento**: Los datos viajan en formato JSON, mucho más rápido para dispositivos móviles.

## 2. Requisitos Previos
- Python 3.10 o superior instalado en el servidor (PC de Bohao).
- Librerías necesarias:
  ```bash
  pip install flask pymysql flask-cors waitress dbutils
  ```

## 3. Implementación Sugerida (Flask)
Crea un archivo llamado `server.py` en el PC de Bohao con este código base:

```python
from flask import Flask, jsonify, request
from flask_cors import CORS
import pymysql

app = Flask(__name__)
CORS(app) # Permite peticiones desde el móvil

# Configuración de conexión nativa (Sin ODBC)
DB_CONFIG = {
    'host': 'localhost',
    'user': '<CONFIGURAR_EN_LA_CONSOLA>',
    'password': '<CONFIGURAR_EN_LA_CONSOLA>',
    'database': 'bohaosupermarket3',
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor
}
# Para concurrencia alta (Producción real), usar DBUtils.PooledDB con maxconnections=50

@app.route('/api/articulo/<barcode>', methods=['GET'])
def get_articulo(barcode):
    try:
        connection = pymysql.connect(**DB_CONFIG)
        with connection.cursor() as cursor:
            sql = "SELECT ArticuloID, NombreES, NombreCN, PrecioDetalle FROM articulo WHERE CodigoBarra = %s"
            cursor.execute(sql, (barcode,))
            result = cursor.fetchone()
            
            if result:
                return jsonify({"status": "success", "data": result})
            return jsonify({"status": "error", "message": "Producto no encontrado"}), 404
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500
    finally:
        if 'connection' in locals():
            connection.close()

if __name__ == '__main__':
    # Importante: host='0.0.0.0' permite conexiones externas por WiFi
    # Para producción (Bohao Windows), usar Waitress en vez de Flask nativo
    from waitress import serve
    serve(app, host='0.0.0.0', port=5000, threads=20)
```

## 4. Pasos para el Despliegue
1. **Ejecutar el servidor**: `python server.py`.
2. **Obtener IP local**: Abre CMD y escribe `ipconfig`. Busca "Dirección IPv4" (ej: `192.168.1.139`).
3. **Probar desde el navegador del móvil**: Entra a `http://192.168.1.139:5000/api/articulo/8412345678901`.
4. **Configurar Firewall**: Si no carga, crea una "Regla de Entrada" en el Firewall de Windows para el puerto **5000 TCP**.

## 5. Siguientes Pasos
Una vez que el móvil recibe el JSON, puedes implementar las funciones de:
- **Inventario**: Peticiones POST para actualizar la tabla `stock`.
- **Precios**: Consultas rápidas para la PDA.
- **Ventas**: Inserciones en `ticket` y `ticketarticulo`.

## 6. Documentación Completa

> **Nota:** El ejemplo anterior es un punto de partida mínimo. Para producción necesitas todos los endpoints documentados en:
>
> - **[Especificación API completa](api-specification.md)**: ~20 endpoints con request/response schemas, autenticación, y plantillas SQL.
> - **[Servidor Flask completo](flask-server-complete.py)**: Implementación lista para producción con connection pooling, auth middleware, y todos los endpoints.
> - **[Relaciones de la base de datos](db-relationships.md)**: Diagrama ER y relaciones entre las 74 tablas.
> - **[Definición de tablas](table_definitions.md)**: Estructura detallada de todas las tablas.
