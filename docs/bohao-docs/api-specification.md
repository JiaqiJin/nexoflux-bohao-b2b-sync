# Especificacion de API REST - Puente Flask SUNMI PDA <-> Bohao MySQL

> Esta especificación mezcla funciones implementadas y planificadas; el código de `flask-server-complete.py` es la referencia del servidor incluido aquí. No describe el Bridge Nexoflux B2B, que conecta localmente a MySQL y usa otra API.

**Version:** 1.0
**Fecha:** Abril 2026
**Servidor:** `http://192.168.1.139:5000`
**Base de datos:** `bohaosupermarket3` (la versión depende de la instalación; en este equipo se verificó MySQL 5.7.44)
**Usuario DB:** `<CONFIGURAR_EN_LA_CONSOLA>`

---

## Tabla de Contenidos

1. [Visión General](#visión-general)
2. [Autenticación](#autenticación)
3. [Productos (articulo)](#productos-articulo)
4. [Operaciones de Stock](#operaciones-de-stock)
5. [Inventario Físico](#inventario-físico)
6. [Ventas / TPV (ticket)](#ventas--tpv-ticket)
7. [Pagos (pago)](#pagos-pago)
8. [Entrada de Mercancía (stockentrada)](#entrada-de-mercancía-stockentrada)
9. [Modificación de Productos](#modificación-de-productos)
10. [Proveedores](#proveedores)
11. [Salud del Servicio](#salud-del-servicio)
12. [Telemetría de Dispositivos](#telemetría-de-dispositivos)
13. [Datos de Referencia](#datos-de-referencia)
14. [Formato de Errores](#formato-de-errores)
15. [Notas Técnicas](#notas-técnicas)
16. [Módulo: Verificación de Mercancía (对货)](#módulo-verificación-de-mercancía-对货)
17. [Módulo: Transferencia entre Almacenes (库存调拨单)](#módulo-transferencia-entre-almacenes-库存调拨单)
18. [Módulo: Conciliación de Clientes (对客户账单)](#módulo-conciliación-de-clientes-对客户账单)

---

## Visión General

### Propósito

Este documento define la especificación completa de la API REST implementada en Flask que sirve como puente entre la aplicación Android SUNMI PDA y la base de datos MySQL `bohaosupermarket3` del sistema Bohao.

### Arquitectura

```
[PDA Android (Kotlin/Retrofit)] <--WiFi--> [Flask API (192.168.1.139:5000)] <---> [MySQL]
```

### Convenciones

- Todas las peticiones y respuestas usan **JSON** (`Content-Type: application/json`).
- Las URLs siguen el patrón `/api/{recurso}`.
- Los campos numéricos decimales se transmiten como `string` en JSON para evitar pérdida de precisión.
- Los campos booleanos se representan como `0`/`1` o `true`/`false`.
- Los campos de fecha usan formato `YYYY-MM-DD HH:MM:SS`.
- Todas las respuestas exitosas incluyen `"status": "success"`.
- Todas las respuestas de error incluyen `"status": "error"`.
- **Estandar Bilingue**: Los mensajes de error (`message`) usan el formato `MENSAJE_CHINO\nMENSAJE_ESPANOL` para facilitar la lectura en el PDA por personal de distintos idiomas.
- **Precision Decimal**: Se usa la clase `Decimal` en el backend para evitar errores de coma flotante.

### Autenticación en Peticiones

Casi todos los endpoints requieren el encabezado:

```
X-Auth-Token: <token_uuid>
```

Los endpoints públicos (sin token) son:
- `POST /api/auth/login`

---

## Autenticación

### Flujo de Autenticación

1. La app PDA envía `POST /api/auth/login` con credenciales del empleado.
2. El servidor valida contra la tabla `empleado` (campos `Contrasena` y `ContrasenaSegura`).
3. El servidor genera un token UUID y lo almacena en un diccionario en memoria.
4. La app incluye el token en el encabezado `X-Auth-Token` en todas las peticiones posteriores.
5. El token es válido hasta que se llame a `/api/auth/logout` o el servidor se reinicie.

### POST /api/auth/login

Inicia sesión con credenciales de empleado.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/auth/login` |
| **Auth** | No requerida |
| **Tabla afectada** | `empleado` |

**Request Body:**

```json
{
  "username": "string",
  "password": "string"
}
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `username` | string | Si | Nombre del empleado (campo `Nombre` en tabla `empleado`) |
| `password` | string | Si | Contraseña en texto plano (se compara con `Contrasena` o `ContrasenaSegura`) |

**SQL:**

```sql
SELECT EmpleadoID, Nombre, ClaseID, Contrasena, ContrasenaSegura, Bloqueado
FROM empleado
WHERE Nombre = ?
  AND (Contrasena = ? OR ContrasenaSegura = ?)
```

**Lógica de validación:**
1. Busca empleado por `Nombre` con contraseña que coincida `Contrasena` o `ContrasenaSegura`.
2. Si `Bloqueado = 1`, retorna 403 (cuenta bloqueada).
3. Si no se encuentra o contraseña incorrecta, retorna 401.

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "empleado_id": 1,
    "nombre": "string",
    "clase_id": 1,
    "token": "uuid-string"
  }
}
```

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `data.empleado_id` | int | ID del empleado (`EmpleadoID`) |
| `data.nombre` | string | Nombre del empleado |
| `data.clase_id` | int | Clase/rol del empleado (`ClaseID`) |
| `data.token` | string | Token UUID para autenticación posterior |

**Response 401 (Unauthorized):**

```json
{
  "status": "error",
  "message": "用户名或密码错误\nUsuario o contraseña incorrectos"
}
```

**Response 403 (Account Blocked):**

```json
{
  "status": "error",
  "message": "账户已被封锁\nCuenta bloqueada"
}
```

---

### POST /api/auth/logout

Cierra la sesión del empleado y elimina el token del servidor.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/auth/logout` |
| **Auth** | Requerida |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Response 200 (OK):**

```json
{
  "status": "success"
}
```

**Response 401 (Unauthorized):**

```json
{
  "status": "error",
  "message": "Token inválido"
}
```

---

## Productos (articulo)

### GET /api/articulo/{barcode}

Busca un producto en una única consulta exacta por código de barras principal (`articulo.CodigoBarra`), código de barras alternativo (`articulocodigobarra.CodigoBarra`) o código interno del producto (`articulo.ArticuloID`). Si hay una colisión, se prioriza primero el código de barras principal, después el alternativo y por último `ArticuloID`.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/articulo/{barcode}` |
| **Auth** | Requerida |
| **Tablas afectadas** | `articulo`, `articulocodigobarra` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Path Parameters:**

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `barcode` | string | Valor escaneado: código de barras o código interno del producto |

**Resolución de identificadores:**

En una sola consulta exacta, el servidor busca el valor recibido en:

1. Código de barras principal: `articulo.CodigoBarra`.
2. Código de barras alternativo: `articulocodigobarra.CodigoBarra`.
3. Código interno del producto: `articulo.ArticuloID`.

Se excluyen artículos bloqueados. Si más de una fila coincide, se prioriza en ese orden. El servidor devuelve los mismos campos del artículo y el mismo error 404 cuando no hay coincidencia.

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "articulo_id": "string",
    "codigo_barra": "string",
    "nombre_es": "string",
    "nombre_cn": "string",
    "precio_detalle": "decimal",
    "precio_mayor": "decimal",
    "precio_oferta": "decimal",
    "precio_coste": "decimal",
    "oferta": false,
    "unidad_nombre": "string",
    "clase_id": 1,
    "bloqueado": false,
    "sitio_en_almacen": "string",
    "sitio_en_estante": "string",
    "mini_stock": "decimal",
    "maxi_stock": "decimal"
  }
}
```

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `articulo_id` | string | ID del artículo (`ArticuloID`) |
| `codigo_barra` | string | Código de barras principal |
| `nombre_es` | string | Nombre en español |
| `nombre_cn` | string | Nombre en chino |
| `precio_detalle` | decimal | Precio al detal |
| `precio_mayor` | decimal | Precio al mayor |
| `precio_oferta` | decimal | Precio en oferta |
| `precio_coste` | decimal | Precio de costo |
| `oferta` | bool | Si el artículo está en oferta |
| `unidad_nombre` | string | Nombre de la unidad de medida |
| `clase_id` | int | ID de la categoría/clase |
| `bloqueado` | bool | Si el artículo está bloqueado |
| `sitio_en_almacen` | string | Ubicación en almacén |
| `sitio_en_estante` | string | Ubicación en estante |
| `mini_stock` | decimal | Stock mínimo |
| `maxi_stock` | decimal | Stock máximo |

**Response 404 (Not Found):**

```json
{
  "status": "error",
  "message": "Artículo no encontrado"
}
```

---

### GET /api/articulo/search

Busca productos por nombre o codigo de barras. Permite busquedas parciales, paginacion y filtro opcional por clase.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/articulo/search` |
| **Auth** | Requerida |
| **Tabla afectada** | `articulo` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Query Parameters:**

| Parámetro | Tipo | Requerido | Default | Descripción |
|-----------|------|-----------|---------|-------------|
| `q` | string | No | `""` | Texto de búsqueda |
| `clase_id` | int | No | - | Filtro por clase |
| `page` | int | No | 1 | Página |
| `limit` | int | No | 50 | Número máximo de resultados |

**SQL:**

```sql
SELECT
  ArticuloID, CodigoBarra, NombreES, NombreCN,
  PrecioDetalle, PrecioMayor, PrecioOferta, PrecioCoste,
  Oferta, UnidadNombre, ClaseID, Bloqueado
FROM articulo
WHERE (NombreES LIKE %s OR NombreCN LIKE %s OR CodigoBarra LIKE %s)
  AND Bloqueado = 0
LIMIT %s OFFSET %s
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": [
    {
      "articulo_id": "string",
      "codigo_barra": "string",
      "nombre_es": "string",
      "nombre_cn": "string",
      "precio_detalle": "decimal",
      "precio_mayor": "decimal",
      "precio_oferta": "decimal",
      "precio_coste": "decimal",
      "oferta": false,
      "unidad_nombre": "string",
      "clase_id": 1,
      "bloqueado": false
    }
  ]
}
```

No requiere `q` para responder; una consulta vacia devuelve la primera pagina de articulos no bloqueados.

---

### GET /api/articulo/{id}/stock

Obtiene el stock actual de un articulo en todos los almacenes.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/articulo/{id}/stock` |
| **Auth** | Requerida |
| **Tabla afectada** | `stock` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Path Parameters:**

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `id` | string | ID del artículo (`ArticuloID`) |

**SQL:**

```sql
SELECT
  s.AlmacenID AS almacen_id, s.Stock AS stock,
  a.NombreES AS almacen_nombre
FROM stock
LEFT JOIN almacen a ON s.AlmacenID = a.AlmacenID
WHERE s.ArticuloID = ?
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": [
    {
      "almacen_id": 1,
      "almacen_nombre": "string",
      "stock": "decimal"
    }
  ]
}
```

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `almacen_id` | int | ID del almacen |
| `almacen_nombre` | string | Nombre del almacen |
| `stock` | decimal | Cantidad actual en stock |

Si no hay filas de stock, responde `200` con `data: []`.

---

## Operaciones de Stock

### GET /api/stock/low

Obtiene la lista de artículos con stock por debajo del mínimo en un almacén dado.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/stock/low` |
| **Auth** | Requerida |
| **Tablas afectadas** | `stock`, `articulo` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Query Parameters:**

| Parámetro | Tipo | Requerido | Default | Descripción |
|-----------|------|-----------|---------|-------------|
| `almacen` | int | Si | - | ID del almacén |
| `limit` | int | No | 50 | Número máximo de resultados |

**SQL:**

```sql
SELECT
  s.ArticuloID, s.AlmacenID, s.Stock,
  s.MiniStock, s.MaxiStock,
  a.NombreES, a.NombreCN
FROM stock s
JOIN articulo a ON s.ArticuloID = a.ArticuloID
WHERE s.AlmacenID = ?
  AND s.Stock < a.MiniStock
ORDER BY (a.MiniStock - s.Stock) DESC
LIMIT ?
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": [
    {
      "articulo_id": "string",
      "nombre_es": "string",
      "stock": "decimal",
      "ministock": "decimal"
    }
  ]
}
```

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `articulo_id` | string | ID del artículo |
| `nombre_es` | string | Nombre en español |
| `stock` | decimal | Stock actual |
| `ministock` | decimal | Stock mínimo requerido |

---

### POST /api/stock/adjust

Crea un documento de ajuste de stock con múltiples líneas.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/stock/adjust` |
| **Auth** | Requerida |
| **Tablas afectadas** | `stockajuste`, `stockajustearticulo`, `stock` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Request Body:**

```json
{
  "almacen_id": 1,
  "lines": [
    {
      "articulo_id": "string",
      "prop_id1": "string",
      "prop_id2": "string",
      "old_stock": "decimal",
      "new_stock": "decimal",
      "reason": "string"
    }
  ],
  "operador_id": 1,
  "observacion": "string"
}
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `almacen_id` | int | Si | ID del almacén |
| `lines` | array | Si | Lista de líneas de ajuste |
| `lines[].articulo_id` | string | Si | ID del artículo |
| `lines[].prop_id1` | string | No | Propiedad 1 del artículo |
| `lines[].prop_id2` | string | No | Propiedad 2 del artículo |
| `lines[].old_stock` | decimal | Si | Stock anterior |
| `lines[].new_stock` | decimal | Si | Stock nuevo/corregido |
| `lines[].reason` | string | No | Motivo del ajuste |
| `operador_id` | int | Si | ID del operador que realiza el ajuste |
| `observacion` | string | No | Observaciones generales |

**SQL - Cabecera (stockajuste):**

```sql
INSERT INTO stockajuste
  (AlmacenID, OperadorID, Observacion, Fecha, DocumentoNo)
VALUES (?, ?, ?, NOW(), ?)
```

**SQL - Líneas (stockajustearticulo):**

```sql
INSERT INTO stockajustearticulo
  (DocumentoNo, ArticuloID, PropID1, PropID2, OldStock, NewStock, Razon)
VALUES (?, ?, ?, ?, ?, ?, ?)
```

**SQL - Actualizar stock:**

```sql
UPDATE stock
SET Stock = ?
WHERE ArticuloID = ? AND AlmacenID = ?
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "documento_no": 1
  }
}
```

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `documento_no` | long | Número de documento generado |

**Response 400 (Bad Request):**

```json
{
  "status": "error",
  "message": "El campo 'lines' no puede estar vacío"
}
```

---

## Inventario Físico

### POST /api/inventario

Crea un nuevo documento de inventario físico.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/inventario` |
| **Auth** | Requerida |
| **Tabla afectada** | `inventario` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Request Body:**

```json
{
  "almacen_id": 1,
  "clase_id": 1,
  "operador_id": 1
}
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `almacen_id` | int | Si | ID del almacén a inventariar |
| `clase_id` | int | No | ID de la clase/categoria de articulos a inventariar |
| `operador_id` | int | Si | ID del operador que realiza el inventario |

**SQL:**

```sql
INSERT INTO inventario
  (AlmacenID, ArticuloClaseID, OperadorID, Fecha, FechaEntrada, Bloqueado, DocumentoNo)
VALUES (?, ?, ?, CURDATE(), NOW(), 0, ?)
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "documento_no": 1
  }
}
```

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `documento_no` | long | Número de documento de inventario generado |

**Response 400 (Bad Request):**

```json
{
  "status": "error",
  "message": "Parámetros inválidos"
}
```

---

### GET /api/inventario/pending

Obtiene la lista de documentos de inventario que están abiertos (no bloqueados) para un almacén.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/inventario/pending` |
| **Auth** | Requerida |
| **Tabla afectada** | `inventario` |

**Query Parameters:**

| Parámetro | Tipo | Requerido | Descripción |
|-----------|------|-----------|-------------|
| `almacen_id` | int | No | Filtrar por ID de almacén |

**SQL:**

```sql
SELECT DocumentoNo, AlmacenID, OperadorID, FechaEntrada AS Tiempo, LineaTotal 
FROM inventario 
WHERE Bloqueado = 0
  AND AlmacenID = ?
ORDER BY FechaEntrada DESC
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": [
    {
      "DocumentoNo": 35,
      "AlmacenID": 1,
      "OperadorID": 1,
      "Tiempo": "2026-05-06T22:57:22",
      "LineaTotal": 0
    }
  ]
}
```

---

### POST /api/inventario/{documento_no}/line

Agrega una línea de conteo al documento de inventario.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/inventario/{documento_no}/line` |
| **Auth** | Requerida |
| **Tabla afectada** | `inventarioarticulo` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Path Parameters:**

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `documento_no` | long | Número de documento de inventario |

**Request Body:**

```json
{
  "articulo_id": "string",
  "prop_id1": "string",
  "prop_id2": "string",
  "cantidad": "decimal"
}
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `articulo_id` | string | Si | ID del artículo contado |
| `prop_id1` | string | No | Propiedad 1 del artículo |
| `prop_id2` | string | No | Propiedad 2 del artículo |
| `cantidad` | decimal | Si | Cantidad contada físicamente |

**SQL:**

```sql
INSERT INTO inventarioarticulo
  (DocumentoNo, ArticuloID, PropID1, PropID2, Cantidad)
VALUES (?, ?, ?, ?, ?)
```

**Response 200 (OK):**

```json
{
  "status": "success"
}
```

**Response 404 (Not Found):**

```json
{
  "status": "error",
  "message": "Documento de inventario no encontrado"
}
```

---

### PUT /api/inventario/{documento_no}/close

Cierra el documento de inventario. Solo actualiza stock si el backend recibe `adjust_stock = true`.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `PUT` |
| **Path** | `/api/inventario/{documento_no}/close` |
| **Auth** | Requerida |
| **Tablas afectadas** | `inventario` y opcionalmente `stock` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Path Parameters:**

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `documento_no` | long | Número de documento de inventario |

**Request Body:**

```json
{
  "observacion": "string",
  "adjust_stock": true
}
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `observacion` | string | No | Observaciones sobre el inventario |
| `adjust_stock` | bool | No | Si es `true`, sobrescribe el stock del almacen con las cantidades contadas |

**SQL - Marcar inventario como cerrado:**

```sql
UPDATE inventario
SET Bloqueado = 1, Observacion = ?
WHERE DocumentoNo = ?
```

**Comportamiento real:**
- Si `adjust_stock` no se envia o es `false`, el servidor solo bloquea el documento.
- Si `adjust_stock` es `true`, hace `INSERT ... ON DUPLICATE KEY UPDATE` sobre `stock` para dejar la cantidad contada como stock real.

**SQL - Actualizar stock según conteo:**

```sql
INSERT INTO stock (AlmacenID, ArticuloID, PropID1, PropID2, Stock)
VALUES (%s, %s, '', '', %s)
ON DUPLICATE KEY UPDATE Stock = VALUES(Stock)
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "message": "Inventario cerrado y stock ajustado",
  "data": {
    "documento_no": 1,
    "stock_adjusted": true
  }
}
```

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `documento_no` | long | Numero de documento cerrado |
| `stock_adjusted` | bool | Indica si se aplico ajuste de stock |

**Response 404 (Not Found):**

```json
{
  "status": "error",
  "message": "Documento de inventario no encontrado"
}
```

---

## Ventas / TPV (ticket)

### POST /api/ticket

Crea un nuevo ticket/venta (cabecera).

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/ticket` |
| **Auth** | Requerida |
| **Tabla afectada** | `ticket` |

**Request Headers:**

```
X-Auth-Token: <token>
X-Idempotency-Key: <uuid> (Opcional, previene tickets duplicados en cortes de red)
```

**Request Body:**

```json
{
  "almacen_id": 1,
  "operador_id": 1,
  "precio_usado": 1,
  "cajon_id": 1,
  "ordenador_nombre": "string",
  "device_uuid": "string"
}
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `almacen_id` | int | Si | ID del almacén donde se realiza la venta |
| `operador_id` | int | Si | ID del empleado que atiende |
| `precio_usado` | int | Si | Tipo de precio a usar (1=detalle, 2=mayor, etc.) |
| `cajon_id` | int | Si | ID del cajón/terminal |
| `ordenador_nombre` | string | No | Nombre del dispositivo que genera el ticket |
| `device_uuid` | string | No | UUID del dispositivo PDA |

**SQL:**

```sql
INSERT INTO ticket
  (AlmacenID, OperadorID, PrecioUsado, CajonID,
   OrdenadorNombre, DeviceUUID, Fecha, Cobrado, DocumentoNo)
VALUES (?, ?, ?, ?, ?, ?, NOW(), 0, ?)
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "documento_no": 1
  }
}
```

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `documento_no` | long | Número de documento del ticket generado |

---

### POST /api/ticket/{documento_no}/line

Agrega una linea de articulo al ticket. Si el articulo ya existe, el backend suma la cantidad a la linea existente.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/ticket/{documento_no}/line` |
| **Auth** | Requerida |
| **Tablas afectadas** | `ticketarticulo`, `ticket` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Path Parameters:**

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `documento_no` | long | Número de documento del ticket |

**Request Body:**

```json
{
  "articulo_id": "string",
  "prop_id1": "string",
  "prop_id2": "string",
  "codigo_barra": "string",
  "nombre_es": "string",
  "precio": "decimal",
  "cantidad": "decimal",
  "iva": "decimal",
  "descuento": "decimal"
}
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `articulo_id` | string | Si | ID del artículo |
| `prop_id1` | string | No | Propiedad 1 |
| `prop_id2` | string | No | Propiedad 2 |
| `codigo_barra` | string | No | Código de barras escaneado |
| `nombre_es` | string | Si | Nombre del artículo en español |
| `precio` | decimal | Si | Precio unitario aplicado |
| `cantidad` | decimal | Si | Cantidad vendida |
| `iva` | decimal | No | Porcentaje de IVA (default 0) |
| `descuento` | decimal | No | Porcentaje de descuento (default 0) |

**Comportamiento real:**
- El backend valida stock disponible con `FOR UPDATE` antes de insertar o incrementar la linea.
- Si el articulo ya existe en el ticket, hace merge por `ArticuloID` y suma la cantidad enviada.
- No existe endpoint de borrado de linea de ticket en el backend actual.

**SQL - Insertar línea:**

```sql
INSERT INTO ticketarticulo
  (DocumentoNo, ArticuloID, PropID1, PropID2,
   CodigoBarra, NombreES, Precio, Cantidad, IVA, Descuento)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
```

**SQL - Actualizar totales del ticket:**

```sql
UPDATE ticket t
SET
  t.TotalArticulos = (SELECT COUNT(*) FROM ticketarticulo WHERE DocumentoNo = ?),
  t.Total = (SELECT SUM(Precio * Cantidad * (1 - Descuento/100) * (1 + IVA/100))
             FROM ticketarticulo WHERE DocumentoNo = ?)
WHERE t.DocumentoNo = ?
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "documento_no": 1,
    "orden_no": 1
  }
}
```

**Response 404 (Not Found):**

```json
{
  "status": "error",
  "message": "Ticket no encontrado"
}
```

---

### PUT /api/ticket/{documento_no}/close

Cierra el ticket para recalcular totales y bloquearlo. El cobro real sucede en `POST /api/pago`.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `PUT` |
| **Path** | `/api/ticket/{documento_no}/close` |
| **Auth** | Requerida |
| **Tablas afectadas** | `ticket` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Path Parameters:**

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `documento_no` | long | Número de documento del ticket |

**Request Body:**

```json
{
  "descuento": "decimal",
  "cliente_id": 1
}
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `descuento` | decimal | No | Descuento global a aplicar (porcentaje) |
| `cliente_id` | int | No | ID del cliente asociado |

**Comportamiento real:**
- Recalcula `LineaTotal`, `CantidadTotal` y `Total` a partir de `ticketarticulo`.
- Marca `Cobrado = -1` y `Bloqueado = 1`.
- Si el ticket ya estaba bloqueado, responde exito idempotente.

**SQL:**

```sql
UPDATE ticket
SET Cobrado = -1,
    Bloqueado = 1,
    LineaTotal = ?,
    CantidadTotal = ?,
    Total = ?
WHERE DocumentoNo = ?
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "documento_no": 1,
    "linea_total": 5,
    "cantidad_total": "decimal",
    "total": "decimal"
  }
}
```

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `documento_no` | long | Número de documento del ticket |
| `linea_total` | int | Numero de lineas del ticket |
| `cantidad_total` | decimal | Cantidad total sumada |
| `total` | decimal | Total final del ticket |

**Response 404 (Not Found):**

```json
{
  "status": "error",
  "message": "Ticket no encontrado"
}
```

---

### GET /api/ticket/{documento_no}

Obtiene los detalles completos de un ticket (cabecera + líneas).

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/ticket/{documento_no}` |
| **Auth** | Requerida |
| **Tablas afectadas** | `ticket`, `ticketarticulo` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Path Parameters:**

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `documento_no` | long | Número de documento del ticket |

**SQL - Cabecera:**

```sql
SELECT * FROM ticket WHERE DocumentoNo = ?
```

**SQL - Líneas:**

```sql
SELECT * FROM ticketarticulo WHERE DocumentoNo = ?
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "documento_no": 1,
    "almacen_id": 1,
    "operador_id": 1,
    "precio_usado": 1,
    "cajon_id": 1,
    "fecha": "2026-04-25 14:30:00",
    "cobrado": -1,
    "descuento": "decimal",
    "total": "decimal",
    "total_articulos": 5,
    "cliente_id": 1,
    "lineas": [
      {
        "articulo_id": "string",
        "codigo_barra": "string",
        "nombre_es": "string",
        "precio": "decimal",
        "cantidad": "decimal",
        "iva": "decimal",
        "descuento": "decimal",
        "subtotal": "decimal"
      }
    ]
  }
}
```

**Response 404 (Not Found):**

```json
{
  "status": "error",
  "message": "Ticket no encontrado"
}
```

---

### GET /api/ticket/today

Obtiene la lista de tickets del dia actual. Puede filtrarse por almacen.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/ticket/today` |
| **Auth** | Requerida |
| **Tabla afectada** | `ticket` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Query Parameters:**

| Parámetro | Tipo | Requerido | Descripción |
|-----------|------|-----------|-------------|
| `almacen_id` | int | No | Filtra por almacen |

**SQL:**

```sql
SELECT DocumentoNo, AlmacenID, Fecha, Cobrado, Total, TotalArticulos
FROM ticket
WHERE Fecha = CURDATE()
ORDER BY DocumentoNo DESC
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": [
    {
      "documento_no": 1,
      "almacen_id": 1,
      "fecha": "2026-04-25 14:30:00",
      "cobrado": -1,
      "total": "decimal",
      "total_articulos": 5
    }
  ]
}
```

---

### PUT /api/ticket/{documento_no}/line/{articulo_id}/quantity

Establece la cantidad absoluta de una línea de ticket. Solo funciona en tickets abiertos (`Bloqueado = 0`).

| Propiedad | Valor |
|-----------|-------|
| **Método** | `PUT` |
| **Path** | `/api/ticket/{documento_no}/line/{articulo_id}/quantity` |
| **Auth** | Requerida |
| **Tablas afectadas** | `ticket`, `ticketarticulo` |

**Request Body:**

```json
{
  "cantidad": 5.0
}
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `cantidad` | decimal | Si | Nueva cantidad (debe ser > 0) |

**Comportamiento:**
- Verifica que el ticket esté abierto (`Bloqueado = 0`). Rechaza si está cerrado.
- Si la cantidad aumenta, valida stock disponible antes de actualizar.
- Recalcula totales del ticket (`CantidadTotal`, `Total`) tras la actualización.

**Response 200 (OK):**

```json
{
  "status": "success",
  "message": "Cantidad actualizada",
  "data": {
    "documento_no": 1,
    "articulo_id": "ART001",
    "nueva_cantidad": 5.0
  }
}
```

**Response 400 (Bad Request):**
- `"Falta cantidad"` — campo `cantidad` ausente
- `"La cantidad debe ser mayor a 0"` — cantidad ≤ 0
- `"El ticket está cerrado, no se puede modificar"` — ticket bloqueado
- Stock insuficiente con detalle de disponible/solicitado

**Response 404 (Not Found):**
- Línea o ticket no encontrado

---

### DELETE /api/ticket/{documento_no}/line/{articulo_id}

Elimina una línea de un ticket abierto y recalcula totales.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `DELETE` |
| **Path** | `/api/ticket/{documento_no}/line/{articulo_id}` |
| **Auth** | Requerida |
| **Tablas afectadas** | `ticket`, `ticketarticulo` |

**Comportamiento:**
- Elimina la línea y recalcula `LineaTotal`, `CantidadTotal`, `Total` del ticket.

**Response 200 (OK):**

```json
{
  "status": "success",
  "message": "Línea eliminada"
}
```

---

### PUT /api/ticket/{documento_no}/annul

Anula un ticket ya cobrado (`Cobrado = 1`) y restaura el stock. Solo aplica a tickets pagados.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `PUT` |
| **Path** | `/api/ticket/{documento_no}/annul` |
| **Auth** | Requerida |
| **Tablas afectadas** | `ticket`, `ticketarticulo`, `stock` |

**Comportamiento:**
- Verifica que `Cobrado = 1` (ticket pagado). Rechaza si no está pagado.
- Restaura stock sumando las cantidades de cada línea al almacén correspondiente.
- Marca `Anulado = 1` en el ticket.

**Response 200 (OK):**

```json
{
  "status": "success",
  "message": "Ticket anulado y stock restaurado"
}
```

**Response 400 (Bad Request):**
- `"票据未付款，无法作废\nEl ticket no está cobrado, no se puede anular"` — Cobrado ≠ 1

**Response 404 (Not Found):**
- Ticket no encontrado

---

### PUT /api/ticket/{documento_no}/cancel

Cancela un ticket abierto (no cobrado). Elimina líneas y el ticket.

| Propiedad | Valor |
|-----------|-------|
| **Método**** | `PUT` |
| **Path** | `/api/ticket/{documento_no}/cancel` |
| **Auth** | Requerida |
| **Tablas afectadas** | `ticket`, `ticketarticulo` |

**Comportamiento:**
- Solo permite cancelar tickets con `Cobrado ≠ 1` (no pagados).
- Elimina todas las líneas (`ticketarticulo`) y el ticket (`ticket`).

**Response 200 (OK):**

```json
{
  "status": "success",
  "message": "Ticket cancelado"
}
```

**Response 400 (Bad Request):**
- `"El ticket ya está cobrado, use anulación"` — Cobrado = 1

---

## Pagos (pago)

### POST /api/pago

Registra un pago para un ticket abierto. En el backend actual este endpoint convierte el ticket en factura, inserta un unico pago y bloquea el ticket original.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/pago` |
| **Auth** | Requerida |
| **Tablas afectadas** | `factura`, `facturaarticulo`, `facturaivatotal`, `pago`, `ticket` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Request Body:**

```json
{
  "documento_no": 1,
  "pago_forma_id": 1,
  "importe": "decimal",
  "operador_id": 1
}
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `documento_no` | long | Si | Número de documento del ticket a pagar |
| `pago_forma_id` | int | Si | ID de la forma de pago (efectivo, tarjeta, etc.) |
| `importe` | decimal | Si | Monto del pago |
| `operador_id` | int | Si | ID del operador que recibe el pago |

**Comportamiento real:**
- Obtiene el ticket con `FOR UPDATE` y rechaza tickets ya cobrados o bloqueados.
- Genera una factura nueva (`DocumentoOrigenTipo = 'T'`).
- Inserta un registro en `pago` vinculado a la factura (`DocumentoOriginalTipo = 'F'`).
- Marca el ticket original como `Cobrado = 1` y `Bloqueado = 1`.
- No soporta multipago real sobre el mismo ticket: una segunda llamada para el mismo `documento_no` falla.

**SQL - Insertar pago:**

```sql
INSERT INTO pago
  (DocumentoNo, Fecha, PagoFormaID, Importe, OperadorID,
   DocumentoOriginalNo, DocumentoOriginalTipo, Bloqueado)
VALUES (?, CURDATE(), ?, ?, ?, ?, 'F', 0)
```

**SQL - Marcar ticket como cobrado:**

```sql
UPDATE ticket
SET Cobrado = 1, Bloqueado = 1
WHERE DocumentoNo = ?
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "pago_no": 1,
    "factura_no": 1001,
    "ticket_no": 1
  }
}
```

**Response 400 (Bad Request):**

```json
{
  "status": "error",
  "message": "El importe no puede ser negativo"
}
```

**Response 404 (Not Found):**

```json
{
  "status": "error",
  "message": "Ticket no encontrado"
}
```

---

### GET /api/pagoformas

Obtiene todas las formas de pago disponibles.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/pagoformas` |
| **Auth** | Requerida |
| **Tabla afectada** | `pagoforma` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**SQL:**

```sql
SELECT * FROM pagoforma ORDER BY PagoFormaID
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": [
    {
      "pago_forma_id": 1,
      "nombre": "string"
    }
  ]
}
```

---

## Entrada de Mercancía (stockentrada)

### POST /api/stockentrada

Crea un nuevo documento de entrada de mercancia.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/stockentrada` |
| **Auth** | Requerida |
| **Tabla afectada** | `stockentrada` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Request Body:**

```json
{
  "almacen_id": 1,
  "operador_id": 1,
  "proveedor_id": 1,
  "empresa_id": 1
}
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `almacen_id` | int | Si | ID del almacén que recibe la mercancía |
| `operador_id` | int | Si | ID del operador que registra la entrada |
| `proveedor_id` | int | No | Alias usado por la app Android |
| `empresa_id` | int | No | Campo que realmente persiste en `stockentrada.EmpresaID` |

**SQL:**

```sql
INSERT INTO stockentrada
  (DocumentoNo, AlmacenID, OperadorID, EmpresaID, Fecha, PrecioUsado, Bloqueado, CantidadTotal, LineaTotal, Total)
VALUES (?, ?, ?, ?, CURDATE(), 1, 0, 0, 0, 0)
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "documento_no": 1
  }
}
```

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `documento_no` | long | Número de documento generado |

---

### POST /api/stockentrada/{documento_no}/line

Agrega una línea de artículo a la entrada de mercancía. **Nota:** Si el artículo ya existe en el documento, el servidor actualizará la línea existente sumando las cantidades y actualizando los metadatos (Merge automático).

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/stockentrada/{documento_no}/line` |
| **Auth** | Requerida |
| **Tablas afectadas** | `stockentradaarticulo`, `stock`, `stockentrada` |

**Request Body:**

```json
{
  "articulo_id": "string",
  "cantidad": "decimal",
  "precio_coste": "decimal",
  "nombre_es": "string",
  "nombre_cn": "string",
  "codigo_barra": "string"
}
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `articulo_id` | string | Si | ID del artículo |
| `cantidad` | decimal | Si | Cantidad a agregar si es alta nueva o merge por escaneo |
| `precio_coste` | decimal | No | Precio de coste (actualiza la ficha del producto) |
| `nombre_es` | string | No | Nombre en español (para consistencia en la verificación) |
| `nombre_cn` | string | No | Nombre en chino |
| `codigo_barra` | string | No | Código de barras |

**Response 200 (OK):**

```json
{
  "status": "success",
  "message": "Línea añadida/actualizada",
  "data": {
    "orden_no": 1
  }
}
```

| Campo | Tipo | Descripción |
|-------|------|-------------|
| `orden_no` | int | El número de orden (índice) de la línea en el documento |

**Comportamiento del Servidor:**
1. Si el producto NO existe: crea una nueva linea, incrementa `LineaTotal`, `CantidadTotal`, `Total` y `stock`. Devuelve el nuevo `orden_no`.
2. Si el producto YA existe y se llama al endpoint de alta: suma la `cantidad` enviada a la linea existente, actualiza `CantidadTotal`, `Total` y `stock`, y conserva el `orden_no`.
3. Si `precio_coste > 0`, sincroniza tambien `articulo.PrecioCoste`.

---

### PUT /api/stockentrada/{doc_no}/line/{orden_no}

Actualiza una linea especifica de un documento de entrada.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `PUT` |
| **Path** | `/api/stockentrada/{doc_no}/line/{orden_no}` |
| **Auth** | Requerida |

**Comportamiento real:**
- Sustituye la cantidad absoluta de la linea (`Cantidad = new_cantidad`).
- Ajusta la cabecera por diferencia (`CantidadTotal`, `Total`).
- Ajusta el `stock` por la diferencia entre cantidad nueva y antigua.
- Si `precio_coste > 0`, sincroniza el coste en la ficha maestra del producto.

---

### GET /api/stockentrada/pending

Obtiene la lista de documentos de entrada abiertos (`Bloqueado = 0`) para el modulo de Verificacion.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/stockentrada/pending` |

**Response:** Lista de cabeceras de `stockentrada`, incluyendo `documento_no`, `fecha`, `empresa_id`, `proveedor_nombre`, `linea_total`, `cantidad_total` y `bloqueado`.

---

### PUT /api/stockentrada/{documento_no}/close

Cierra el documento de entrada de mercancia, bloqueandolo contra ediciones. No recalcula stock en este paso porque el stock ya se ajusto al crear o editar lineas.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `PUT` |
| **Path** | `/api/stockentrada/{documento_no}/close` |
| **Auth** | Requerida |
| **Tabla afectada** | `stockentrada` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Path Parameters:**

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `documento_no` | long | Número de documento de entrada |

**SQL:**

```sql
UPDATE stockentrada
SET Bloqueado = 1
WHERE DocumentoNo = ?
```

**Response 200 (OK):**

```json
{
  "status": "success"
}
```

**Response 404 (Not Found):**

```json
{
  "status": "error",
  "message": "Documento de entrada no encontrado"
}
```

---

## Datos de Referencia

### GET /api/almacenes

Obtiene la lista de todos los almacenes.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/almacenes` |
| **Auth** | Requerida |
| **Tabla afectada** | `almacen` |

**SQL:**

```sql
SELECT AlmacenID AS id, NombreES AS nombre FROM almacen WHERE Bloqueado = 0
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": [
    {
      "id": 1,
      "nombre": "string"
    }
  ]
}
```

---

### GET /api/ivatypes

Obtiene la lista de todos los tipos de IVA.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/ivatypes` |
| **Auth** | Requerida |
| **Tabla afectada** | `ivatipo` |

**SQL:**

```sql
SELECT IVAID as id, Nombre as nombre, IVA as valor FROM ivatipo WHERE Bloqueado = 0
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": [
    {
      "id": 1,
      "nombre": "string",
      "valor": "decimal"
    }
  ]
}
```

---

### GET /api/articuloclases

Obtiene la lista de todas las categorías/clases de artículos.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/articuloclases` |
| **Auth** | Requerida |
| **Tabla afectada** | `articuloclase` |

**SQL:**

```sql
SELECT ClaseID AS id, NombreES AS nombre FROM articuloclase
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": [
    {
      "id": 1,
      "nombre": "string"
    }
  ]
}
```

---

## Modificación de Productos

### PUT /api/articulo/{id}

Actualiza los datos de un producto existente.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `PUT` |
| **Path** | `/api/articulo/{id}` |
| **Auth** | Requerida |
| **Tabla afectada** | `articulo` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Path Parameters:**

| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `id` | string | ID del artículo (`ArticuloID`, varchar) |

**Request Body:**

```json
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
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `nombre_es` | string | No | Nombre en español |
| `nombre_cn` | string | No | Nombre en chino |
| `precio_detalle` | decimal | No | Precio al detal |
| `precio_mayor` | decimal | No | Precio al mayor |
| `precio_oferta` | decimal | No | Precio en oferta |
| `precio_coste` | decimal | No | Precio de costo |
| `oferta` | bool | No | Si está en oferta |
| `bloqueado` | bool | No | Si está bloqueado |
| `sitio_en_almacen` | string | No | Ubicación en almacén |
| `sitio_en_estante` | string | No | Ubicación en estante |
| `mini_stock` | decimal | No | Stock mínimo |
| `maxi_stock` | decimal | No | Stock máximo |

Solo los campos incluidos en el body serán actualizados (partial update).

**SQL:**

```sql
UPDATE articulo
SET NombreES = COALESCE(?, NombreES),
    NombreCN = COALESCE(?, NombreCN),
    PrecioDetalle = COALESCE(?, PrecioDetalle),
    PrecioMayor = COALESCE(?, PrecioMayor),
    PrecioOferta = COALESCE(?, PrecioOferta),
    PrecioCoste = COALESCE(?, PrecioCoste),
    Oferta = COALESCE(?, Oferta),
    Bloqueado = COALESCE(?, Bloqueado),
    SitioEnAlmacen = COALESCE(?, SitioEnAlmacen),
    SitioEnEstante = COALESCE(?, SitioEnEstante),
    MiniStock = COALESCE(?, MiniStock),
    MaxiStock = COALESCE(?, MaxiStock)
WHERE ArticuloID = ?
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "articulo_id": "string",
    "updated_fields": ["nombre_es", "precio_detalle"]
  }
}
```

**Response 404 (Not Found):**

```json
{
  "status": "error",
  "message": "Artículo no encontrado"
}
```

**Response 400 (Bad Request):**

```json
{
  "status": "error",
  "message": "No se proporcionaron campos para actualizar"
}
```

---

## Proveedores

> Estado actual: `GET /api/proveedores` esta declarado en el cliente Android (`BohaoApi`) pero no existe en `server.py`. Tratar esta seccion como especificacion pendiente, no como endpoint operativo del backend actual.

### GET /api/proveedores

Obtiene la lista de todos los proveedores activos.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/proveedores` |
| **Auth** | Requerida |
| **Tabla afectada** | `proveedor` |

**Request Headers:**

```
X-Auth-Token: <token>
```

**SQL:**

```sql
SELECT EmpresaID, NombreES, NombreCN, CIF, Telefono
FROM proveedor
WHERE Bloqueado = 0
ORDER BY NombreES
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": [
    {
      "proveedor_id": 1,
      "nombre_es": "string",
      "nombre_cn": "string",
      "cif": "string",
      "telefono": "string"
    }
  ]
}
```

---

## Salud del Servicio

### GET /api/health

Verifica que el servidor Flask y la conexión MySQL están operativos. No requiere autenticación.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/health` |
| **Auth** | No requerida |

**SQL (verificación):**

```sql
SELECT 1
```

**Response 200 (OK):**

```json
{
  "status": "ok",
  "db": "connected",
  "timestamp": "2026-04-26T10:00:00"
}
```

**Response 503 (Service Unavailable):**

```json
{
  "status": "error",
  "db": "disconnected",
  "message": "Database connection failed"
}
```

---

## Telemetría de Dispositivos

### POST /api/device/heartbeat

Registra métricas de salud del dispositivo PDA. Endpoint opcional para monitorización remota.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/device/heartbeat` |
| **Auth** | Requerida |
| **Tabla afectada** | Nueva tabla `device_heartbeat` (crear si no existe) |

**Request Headers:**

```
X-Auth-Token: <token>
```

**Request Body:**

```json
{
  "device_sn": "string",
  "model": "string",
  "battery_level": 85,
  "free_storage_mb": 1024,
  "free_ram_mb": 512,
  "wifi_ssid": "string",
  "app_version": "1.0.0"
}
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `device_sn` | string | Si | Número de serie del dispositivo SUNMI |
| `model` | string | No | Modelo del dispositivo |
| `battery_level` | int | No | Porcentaje de batería (0–100) |
| `free_storage_mb` | long | No | Almacenamiento libre en MB |
| `free_ram_mb` | long | No | RAM libre en MB |
| `wifi_ssid` | string | No | SSID de la red WiFi conectada |
| `app_version` | string | No | Versión de la app PDA |

**SQL (crear tabla si no existe):**

```sql
CREATE TABLE IF NOT EXISTS device_heartbeat (
    id INT AUTO_INCREMENT PRIMARY KEY,
    device_sn VARCHAR(50) NOT NULL,
    model VARCHAR(50),
    battery_level INT,
    free_storage_mb BIGINT,
    free_ram_mb BIGINT,
    wifi_ssid VARCHAR(100),
    app_version VARCHAR(20),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_device_sn (device_sn),
    INDEX idx_timestamp (timestamp)
);
```

**SQL:**

```sql
INSERT INTO device_heartbeat
  (device_sn, model, battery_level, free_storage_mb, free_ram_mb, wifi_ssid, app_version)
VALUES (?, ?, ?, ?, ?, ?, ?)
```

**Response 200 (OK):**

```json
{
  "status": "success"
}
```

---

## Formato de Errores

Todos los errores siguen el mismo formato estándar:

```json
{
  "status": "error",
  "message": "Descripción legible del error"
}
```

### Códigos de Estado HTTP

| Código | Significado | Cuándo se usa |
|--------|-------------|---------------|
| `200` | OK | La petición se completó exitosamente |
| `400` | Bad Request | Faltan parámetros requeridos, stock insuficiente o documento bloqueado |
| `401` | Unauthorized | Token de autenticación ausente, inválido o expirado |
| `404` | Not Found | El recurso solicitado no existe |
| `500` | Internal Server Error | Error inesperado del servidor (error SQL, excepción no controlada) |

### Estándar Bilingüe (ZH/ES)

A partir de la versión 1.1, los mensajes de error críticos (stock, auth, bloqueos) se devuelven en formato bilingüe:

```json
{
  "status": "error",
  "message": "单据已被锁定\nEl documento ya está bloqueado"
}
```

El PDA (Kotlin) detecta el carácter `\n` para mostrar el mensaje en varias líneas si es necesario.

### Ejemplos de Errores Comunes

**Token ausente:**

```json
{
  "status": "error",
  "message": "Token de autenticación requerido"
}
```

**Token inválido:**

```json
{
  "status": "error",
  "message": "Token inválido o expirado"
}
```

**Parámetros faltantes:**

```json
{
  "status": "error",
  "message": "El campo 'almacen_id' es requerido"
}
```

**Registro no encontrado:**

```json
{
  "status": "error",
  "message": "Artículo no encontrado"
}
```

**Error del servidor:**

```json
{
  "status": "error",
  "message": "Error interno del servidor"
}
```

> **Nota de implementación:** En caso de error 500, los detalles técnicos (traceback, SQL error) se registran en los logs del servidor Flask y **no** se exponen al cliente por seguridad.

---

## Notas Técnicas

### Generación de DocumentoNo

El número de documento (`DocumentoNo`) se genera de forma secuencial. Existen dos estrategias posibles:

**Estrategia 1 - Tabla `documentono`:**

```sql
-- Obtener el siguiente número para un tipo de documento
UPDATE documentono
SET UltimoNo = UltimoNo + 1
WHERE TipoDocumento = 'ticket';

SELECT UltimoNo FROM documentono WHERE TipoDocumento = 'ticket';
```

Los valores de `TipoDocumento` son: `'ticket'`, `'stockentrada'`, `'stockajuste'`, `'inventario'`.

**Estrategia 2 - MySQL LAST_INSERT_ID():**

```sql
INSERT INTO ticket (...) VALUES (...);
SELECT LAST_INSERT_ID() AS DocumentoNo;
```

Se recomienda la **Estrategia 1** para mantener compatibilidad con el sistema Bohao existente y evitar conflictos de IDs.

### CORS

CORS está habilitado para todos los orígenes (`*`) ya que la API opera exclusivamente en la red local (192.168.1.x). Configuración en Flask:

```python
from flask_cors import CORS

app = Flask(__name__)
CORS(app, resources={r"/api/*": {"origins": "*"}})
```

### Rate Limiting

No se implementa rate limiting. La API funciona en una red local WiFi privada (192.168.1.x) con un número limitado de dispositivos PDA conectados simultáneamente.

### Dependencias del Servidor Flask

```
flask
pymysql
flask-cors
```

### Configuración de Conexión MySQL

```python
DB_CONFIG = {
    'host': 'localhost',
    'port': 3306,
    'user': '<CONFIGURAR_EN_LA_CONSOLA>',
    'password': '<password>',
    'database': 'bohaosupermarket3',
    'charset': 'utf8mb4',
    'cursorclass': pymysql.cursors.DictCursor
}
```

### Manejo de Transacciones

Las operaciones que afectan múltiples tablas (ej: crear ticket + líneas, ajuste de stock) deben ejecutarse dentro de una transacción SQL:

```python
connection.begin()
try:
    # ... operaciones INSERT/UPDATE ...
    connection.commit()
except Exception as e:
    connection.rollback()
    raise
```

### Configuración Retrofit (Android/Kotlin)

```kotlin
// Ejemplo de configuración del cliente Retrofit
val retrofit = Retrofit.Builder()
    .baseUrl("http://192.168.1.139:5000")
    .addConverterFactory(GsonConverterFactory.create())
    .build()

// Interceptor para token de autenticación
val client = OkHttpClient.Builder()
    .addInterceptor { chain ->
        val request = chain.request().newBuilder()
            .addHeader("X-Auth-Token", authToken)
            .build()
        chain.proceed(request)
    }
    .build()
```

### Nota sobre Seguridad

Esta API está diseñada para operar en una red local aislada. No se implementan:
- HTTPS/TLS (red local de confianza)
- Rate limiting (tráfico controlado y limitado)
- Tokens JWT (se usan tokens UUID simples en memoria)
- Encriptación de contraseñas en tránsito (la contraseña viaja en texto plano en el JSON)

Si en el futuro la API se expone a una red pública, se deben implementar todas las medidas de seguridad estándar.
---

## Módulo: Verificación de Mercancía (对货)

Este módulo permite verificar que la mercancía recibida físicamente coincide con el albarán de entrada generado previamente en el sistema.

### GET /api/stockentrada/pending

Obtiene la lista de albaranes de entrada que aún no han sido verificados (no bloqueados).

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/stockentrada/pending` |
| **Auth** | Requerida |
| **Tablas afectadas** | `stockentrada`, `almacen`, `proveedor` |

**Query Parameters:**

| Parámetro | Tipo | Requerido | Descripción |
|-----------|------|-----------|-------------|
| `almacen_id` | int | No | Filtrar albaranes por almacén |

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": [
    {
      "documento_no": 12345,
      "fecha": "2026-05-01",
      "almacen_id": 1,
      "almacen_nombre": "Almacén Central",
      "empresa_id": 50,
      "proveedor_nombre": "Proveedor Ejemplo S.L.",
      "cantidad_total": 100.0,
      "linea_total": 10,
      "total": 1500.50
    }
  ]
}
```

---

### POST /api/stockentrada

Crea un nuevo documento de entrada de stock (cabecera).

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/stockentrada` |
| **Auth** | Requerida |
| **Tabla afectada** | `stockentrada` |

**Request Body:**

```json
{
  "almacen_id": 1,
  "operador_id": 999,
  "empresa_id": 10
}
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "documento_no": 12345
  }
}
```

---

### POST /api/stockentrada/{doc_no}/line

Agrega una línea al albarán de entrada. Este endpoint realiza tres acciones automáticas:
1. **Inserta la línea** en `stockentradaarticulo`.
2. **Actualiza los totales** (`LineaTotal`, `CantidadTotal`, `Total`) en la cabecera `stockentrada`.
3. **Actualiza el stock** físico en la tabla `stock`.
4. **Sincroniza el precio de coste** en la ficha maestra del producto (`articulo.PrecioCoste`).

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/stockentrada/{doc_no}/line` |
| **Auth** | Requerida |
| **Tablas afectadas** | `stockentradaarticulo`, `stockentrada`, `stock`, `articulo` |

**Request Body:**

```json
{
  "articulo_id": "ART001",
  "cantidad": 10.5,
  "precio": 5.0,
  "precio_coste": 5.0,
  "codigo_barra": "123456789",
  "nombre_es": "Producto A"
}
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "message": "Línea añadida, totales actualizados, stock incrementado y coste de producto actualizado"
}
```

---

### GET /api/stockentrada/{doc_no}

Obtiene el detalle completo de un albarán de entrada, incluyendo sus líneas, para iniciar el proceso de verificación.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/stockentrada/{doc_no}` |
| **Auth** | Requerida |
| **Tablas afectadas** | `stockentrada`, `stockentradaarticulo` |

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "header": {
      "documento_no": 12345,
      "almacen_id": 1,
      "proveedor_nombre": "Proveedor Ejemplo",
      "total": 1500.50
    },
    "lines": [
      {
        "articulo_id": "ART001",
        "codigo_barra": "123456789",
        "nombre_es": "Producto A",
        "cantidad_esperada": 10.0,
        "precio_coste": 5.0,
        "orden_no": 1
      }
    ]
  }
}
```

---

### PUT /api/stockentrada/{doc_no}/verify

Cierra el proceso de verificación. Actualiza las cantidades reales en el albarán, incrementa el stock físico y bloquea el documento para evitar ediciones posteriores.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `PUT` |
| **Path** | `/api/stockentrada/{doc_no}/verify` |
| **Auth** | Requerida |
| **Tablas afectadas** | `stockentrada`, `stockentradaarticulo`, `stock` |

**Request Body:**

```json
{
  "lines": [
    {
      "articulo_id": "ART001",
      "cantidad_esperada": 10.0,
      "cantidad_real": 9.0,
      "nombre_es": "Producto A"
    }
  ]
}
```

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "documento_no": 12345,
    "discrepancies": [
      {
        "articulo_id": "ART001",
        "nombre_es": "Producto A",
        "cantidad_esperada": 10.0,
        "cantidad_real": 9.0,
        "diferencia": -1.0
      }
    ],
    "total_discrepancies": 1
  }
}
```

---

## Módulo: Transferencia entre Almacenes (库存调拨单)

Permite mover mercancía de un almacén a otro, registrando la salida del origen y la entrada en el destino.

### POST /api/stocktraspaso

Inicia un nuevo documento de transferencia. Se utiliza la tabla `stockajuste` con una observación especial `TRASPASO:{destino_id}`.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/stocktraspaso` |
| **Auth** | Requerida |
| **Tabla afectada** | `stockajuste` |

**Request Body:**

```json
{
  "almacen_origen_id": 1,
  "almacen_destino_id": 2,
  "operador_id": 999,
  "observacion": "Traspaso urgente"
}
```

---

### POST /api/stocktraspaso/{doc_no}/line

Añade un artículo al traspaso. Realiza dos operaciones de stock: resta en el origen e incrementa en el destino.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/stocktraspaso/{doc_no}/line` |
| **Auth** | Requerida |
| **Tablas afectadas** | `stockajustearticulo`, `stock` |

**Request Body:**

```json
{
  "articulo_id": "ART001",
  "cantidad": 5.0,
  "codigo_barra": "123456789",
  "nombre_es": "Producto A",
  "precio_coste": 5.0
}
```

---

### PUT /api/stocktraspaso/{doc_no}/close

Bloquea el documento de traspaso marcándolo como completado.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `PUT` |
| **Path** | `/api/stocktraspaso/{doc_no}/close` |
| **Auth** | Requerida |
| **Tabla afectada** | `stockajuste` |

---

## Módulo: Conciliación de Clientes (对客户账单)

Permite consultar el estado de cuenta y facturas pendientes de cobro para clientes específicos.

### GET /api/clientes

Obtiene el listado de clientes con paginación, permitiendo filtrar por aquellos que tienen saldos pendientes.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/clientes` |
| **Auth** | Requerida |
| **Tabla afectada** | `cliente`, `factura` |

**Query Parameters:**

| Parámetro | Tipo | Requerido | Default | Descripción |
|-----------|------|-----------|---------|-------------|
| `q` | string | No | `""` | Búsqueda por nombre, CIF o teléfono |
| `only_pending` | bool | No | `false` | `true` para listar solo clientes con deuda |
| `page` | int | No | 1 | Página |
| `limit` | int | No | 20 | Número máximo de resultados |

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": [
    {
      "cliente_id": 1,
      "nombre_es": "string",
      "nombre_cn": "string",
      "telefono": "string",
      "cif": "string",
      "saldo_pendiente": "decimal"
    }
  ],
  "page": 1,
  "limit": 20,
  "total": 100,
  "total_pages": 5
}
```

---

### POST /api/cliente

Crea un nuevo cliente en el sistema.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `POST` |
| **Path** | `/api/cliente` |
| **Auth** | Requerida |
| **Tabla afectada** | `cliente`, `clienteextra` |

**Request Body:**

```json
{
  "nombre_es": "string",
  "nombre_cn": "string",
  "telefono": "string",
  "cif": "string"
}
```

| Campo | Tipo | Requerido | Descripción |
|-------|------|-----------|-------------|
| `nombre_es` | string | Si | Nombre o razón social del cliente |
| `nombre_cn` | string | No | Nombre en chino (búsqueda bilingüe) |
| `telefono` | string | No | Teléfono de contacto |
| `cif` | string | No | Identificación fiscal (CIF/NIF) |

**Consideraciones Técnicas (Edge Cases):**
1. **Concurrencia:** La tabla `cliente` no utiliza `AUTO_INCREMENT`. Para evitar colisiones (`Error 1062 Duplicate entry`) y deadlocks (`Error 1213`) bajo alta concurrencia, el endpoint utiliza un bloqueo a nivel de aplicación (Python `threading.Lock`) llamado `TABLE_LOCKS['cliente']`.
2. **Generación de ID (`GREATEST`):** El cálculo del nuevo ID (`next_id`) examina simultáneamente la tabla `cliente` y `clienteextra` usando la función `GREATEST`. Esto previene fallos causados por IDs huérfanos que puedan existir en la tabla extra sin su contraparte en la tabla principal.
3. **Trigger Oculto MySQL:** La base de datos Bohao cuenta con un *trigger* interno en la tabla `cliente` que inserta un registro automáticamente en `clienteextra`. El backend *no* debe intentar realizar la inserción manual en `clienteextra` tras insertar en `cliente`, o provocará un `1062 Duplicate entry`.

**Response 200 (OK):**

```json
{
  "status": "success",
  "message": "Cliente creado",
  "data": {
    "cliente_id": 102
  }
}
```

---

### GET /api/clientes/{cliente_id}/facturas

Obtiene el histórico de facturas de un cliente, detallando cuáles están cobradas y cuáles pendientes.

| Propiedad | Valor |
|-----------|-------|
| **Método** | `GET` |
| **Path** | `/api/clientes/{cliente_id}/facturas` |
| **Auth** | Requerida |
| **Tabla afectada** | `factura` |

**Response 200 (OK):**

```json
{
  "status": "success",
  "data": {
    "cliente_id": 101,
    "total_pendiente": 450.0,
    "facturas": [
      {
        "documento_no": 9001,
        "fecha": "2026-04-15",
        "total": 200.0,
        "cobro_total": 0.0,
        "pendiente": 200.0,
        "cobrado": 0
      }
    ]
  }
}
```
