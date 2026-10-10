# Relaciones de la Base de Datos: bohaosupermarket3

Este documento describe las relaciones entre las tablas principales de la base de datos MySQL `bohaosupermarket3` (74 tablas en total). El objetivo es facilitar al equipo de desarrollo de la app PDA la comprension de como se conectan las entidades del sistema Bohao Restaurant/Supermarket Management Expert.

La app PDA se conecta a MySQL a traves de un puente REST API construido con Flask. Ver [backend_bridge_setup.md](./backend_bridge_setup.md) para detalles de la conexion.

---

## 1. Diagrama ER (Mermaid)

```mermaid
erDiagram
    %% --- Productos ---
    articulo ||--o{ stock : "tiene stock por almacen"
    articulo ||--o{ ticketarticulo : "se vende en lineas"
    articulo ||--o{ inventarioarticulo : "se cuenta en inventarios"
    articulo ||--o{ stockentradaarticulo : "se recibe en entradas"
    articulo ||--o{ articulocodigobarra : "tiene codigos alternativos"
    articulo }o--|| articuloclase : "pertenece a categoria"

    %% --- Almacen ---
    almacen ||--o{ stock : "almacena productos"

    %% --- Ventas (Ticket) ---
    ticket ||--o{ ticketarticulo : "tiene lineas de venta"
    ticket ||--o{ pago : "tiene pagos"
    ticket ||--o{ ticketcobro : "tiene cobros"
    ticket }o--o| cliente : "cliente asociado (opcional)"
    ticket }o--|| empleado : "operador que crea el ticket"
    ticket }o--|| almacen : "almacen de la venta"

    %% --- Inventarios ---
    inventario ||--o{ inventarioarticulo : "tiene lineas de conteo"
    inventario }o--|| empleado : "operador que realiza conteo"
    inventario }o--|| almacen : "almacen inventariado"

    %% --- Entradas de Stock ---
    stockentrada ||--o{ stockentradaarticulo : "tiene lineas de recepcion"
    stockentrada }o--|| almacen : "almacen destino"
    stockentrada }o--|| proveedor : "proveedor (via EmpresaID)"

    %% --- Pagos ---
    pago }o--|| ticket : "paga un ticket"
    pago }o--|| pagoforma : "forma de pago"

    %% --- Tablas de apoyo ---
    articuloclase {
        smallint ClaseID PK
        smallint PadreID
        varchar NombreES
        varchar NombreCN
    }
    ivatipo {
        smallint IVAID PK
        varchar Nombre
        decimal IVA
        decimal REQ
    }

    %% --- Atributos principales de entidades core ---
    articulo {
        varchar ArticuloID PK
        varchar CodigoBarra
        varchar NombreES
        varchar NombreCN
        decimal PrecioDetalle
        decimal PrecioMayor
        decimal PrecioOferta
        decimal PrecioCoste
        decimal PrecioDomicilio
        decimal PrecioSocio
        decimal PrecioInternet
        decimal PrecioAmigo
        decimal PrecioEspecial
        smallint ClaseID FK
        tinyint PropCount
        varchar Prop1Titulo
        varchar Prop2Titulo
        tinyint Bloqueado
    }
    stock {
        smallint AlmacenID PK_FK
        varchar ArticuloID PK_FK
        varchar PropID1 PK
        varchar PropID2 PK
        decimal Stock
    }
    almacen {
        smallint AlmacenID PK
        varchar NombreES
        tinyint Bloqueado
    }
    ticket {
        bigint DocumentoNo PK
        bigint DocumentoNoEnServidor
        bigint DocumentoNoOriginal
        tinyint CobrarTipo
        tinyint PrecioUsado
        bigint EmpresaID FK
        smallint OperadorID FK
        smallint AlmacenID FK
        decimal Total
        decimal CobroTotal
        tinyint Bloqueado
        tinyint Anulado
    }
    ticketarticulo {
        bigint DocumentoNo FK
        varchar ArticuloID FK
        varchar PropID1
        varchar PropID2
        varchar NombreES
        decimal Precio
        decimal Cantidad
        decimal IVA
        decimal PrecioCoste
    }
    cliente {
        bigint EmpresaID PK
        varchar NombreES
        varchar CIF
        varchar Telefono
        tinyint PrecioUsado
    }
    proveedor {
        bigint EmpresaID PK
        varchar NombreES
        varchar CIF
        varchar Telefono
    }
    empleado {
        smallint EmpleadoID PK
        varchar Nombre
        varchar Contrasena
        tinyint Bloqueado
    }
    pago {
        bigint DocumentoNo PK_FK
        bigint DocumentoOriginalNo
        smallint PagoFormaID FK
        decimal Importe
    }
    pagoforma {
        smallint PagoFormaID PK
        varchar Nombre
    }
    inventario {
        bigint DocumentoNo PK
        smallint AlmacenID FK
        smallint OperadorID FK
        tinyint Bloqueado
    }
    inventarioarticulo {
        bigint DocumentoNo FK
        varchar ArticuloID FK
        varchar PropID1
        varchar PropID2
        decimal Cantidad
        decimal Precio
    }
    stockentrada {
        bigint DocumentoNo PK
        smallint AlmacenID FK
        smallint OperadorID FK
        tinyint Bloqueado
    }
    stockentradaarticulo {
        bigint DocumentoNo FK
        varchar ArticuloID FK
        varchar PropID1
        varchar PropID2
        decimal Cantidad
        decimal Precio
        decimal PrecioCoste
    }
    articulocodigobarra {
        varchar CodigoBarra PK
        varchar ArticuloID FK
    }
```

---

## 2. Detalle de Relaciones

### 2.1 Relaciones de Productos

| Relacion | Tabla Origen | Campo(s) | Tabla Destino | Campo(s) | Cardinalidad | Significado |
|---|---|---|---|---|---|---|
| articulo -> stock | `articulo` | `ArticuloID` | `stock` | `ArticuloID` | 1:N | Un producto tiene registros de stock en multiples almacenes y variantes |
| articulo -> articuloclase | `articulo` | `ClaseID` | `articuloclase` | `ClaseID` | N:1 | Un producto pertenece a una categoria (clase) |
| articulo -> articulocodigobarra | `articulo` | `ArticuloID` | `articulocodigobarra` | `ArticuloID` | 1:N | Un producto puede tener multiples codigos de barras alternativos |
| almacen -> stock | `almacen` | `AlmacenID` | `stock` | `AlmacenID` | 1:N | Un almacen tiene stock de muchos productos |

### 2.2 Relaciones de Ventas (Ticket)

| Relacion | Tabla Origen | Campo(s) | Tabla Destino | Campo(s) | Cardinalidad | Significado |
|---|---|---|---|---|---|---|
| ticket -> ticketarticulo | `ticket` | `DocumentoNo` | `ticketarticulo` | `DocumentoNo` | 1:N | Un ticket tiene multiples lineas de venta |
| ticketarticulo -> articulo | `ticketarticulo` | `ArticuloID` | `articulo` | `ArticuloID` | N:1 | Cada linea referencia al producto vendido |
| ticket -> cliente | `ticket` | `EmpresaID` | `cliente` | `EmpresaID` | N:0..1 | Un ticket puede tener un cliente asociado (walk-in = 0) |
| ticket -> empleado | `ticket` | `OperadorID` | `empleado` | `EmpleadoID` | N:1 | El empleado que creo el ticket |
| ticket -> almacen | `ticket` | `AlmacenID` | `almacen` | `AlmacenID` | N:1 | Almacen donde se realizo la venta |
| ticket -> pago | `ticket` | `DocumentoNo` | `pago` | `DocumentoNo` | 1:N | Un ticket puede tener multiples pagos |
| ticket -> ticketcobro | `ticket` | `DocumentoNo` | `ticketcobro` | `DocumentoNo` | 1:N | Registros de cobro vinculados al ticket |

### 2.3 Relaciones de Recepcion de Mercancia

| Relacion | Tabla Origen | Campo(s) | Tabla Destino | Campo(s) | Cardinalidad | Significado |
|---|---|---|---|---|---|---|
| stockentrada -> stockentradaarticulo | `stockentrada` | `DocumentoNo` | `stockentradaarticulo` | `DocumentoNo` | 1:N | Una entrada tiene multiples lineas de recepcion |
| stockentradaarticulo -> articulo | `stockentradaarticulo` | `ArticuloID` | `articulo` | `ArticuloID` | N:1 | Cada linea referencia al producto recibido |
| stockentrada -> almacen | `stockentrada` | `AlmacenID` | `almacen` | `AlmacenID` | N:1 | Almacen donde se recibe la mercancia |
| stockentrada -> proveedor | `stockentrada` | `EmpresaID` | `proveedor` | `EmpresaID` | N:0..1 | Proveedor de la mercancia (opcional) |

### 2.4 Relaciones de Inventario Fisico

| Relacion | Tabla Origen | Campo(s) | Tabla Destino | Campo(s) | Cardinalidad | Significado |
|---|---|---|---|---|---|---|
| inventario -> inventarioarticulo | `inventario` | `DocumentoNo` | `inventarioarticulo` | `DocumentoNo` | 1:N | Un conteo tiene multiples lineas de productos contados |
| inventarioarticulo -> articulo | `inventarioarticulo` | `ArticuloID` | `articulo` | `ArticuloID` | N:1 | Cada linea referencia al producto contado |
| inventario -> almacen | `inventario` | `AlmacenID` | `almacen` | `AlmacenID` | N:1 | Almacen donde se realiza el conteo |
| inventario -> empleado | `inventario` | `OperadorID` | `empleado` | `EmpleadoID` | N:1 | Empleado que realizo el conteo |

### 2.5 Relaciones de Pagos

| Relacion | Tabla Origen | Campo(s) | Tabla Destino | Campo(s) | Cardinalidad | Significado |
|---|---|---|---|---|---|---|
| pago -> ticket | `pago` | `DocumentoNo` | `ticket` | `DocumentoNo` | N:1 | Cada pago pertenece a un ticket |
| pago -> pagoforma | `pago` | `PagoFormaID` | `pagoforma` | `PagoFormaID` | N:1 | Forma de pago utilizada |

---

## 3. Semantica de Campos Clave

### 3.1 CobrarTipo (estado del ticket)

Campo presente en `ticket` y `ticketcobro`. Indica el estado del proceso de cobro:

| Valor | Significado | Descripcion |
|-------|-------------|-------------|
| 0 | Pendiente | Ticket abierto, aun no cobrado |
| 1 | Cobrado | Ticket cobrado/cerrado correctamente |
| 2 | Anulado | Ticket anulado (no se contabiliza) |
| 3 | Devolucion | Ticket de devolucion |
| 4 | Cobro parcial | Ticket cobrado parcialmente |
| 5 | Colgado/Suspendido | Ticket en espera, pendiente de reanudar |

### 3.2 PrecioUsado (selector de nivel de precio)

Campo presente en `ticket`, `inventario`, `stockentrada`, `cliente` y otros documentos. Selecciona que columna de precio de la tabla `articulo` se utiliza:

| Valor | Nombre | Campo en `articulo` | Uso tipico |
|-------|-------|---------------------|------------|
| 1 | Detalle (Retail) | `PrecioDetalle` | Venta al publico general |
| 2 | Mayor (Wholesale) | `PrecioMayor` | Venta al por mayor |
| 3 | Oferta | `PrecioOferta` | Productos en promocion |
| 4 | Coste | `PrecioCoste` | Entradas de stock, valoracion |
| 5 | Domicilio | `PrecioDomicilio` | Ventas a domicilio |
| 6 | Socio | `PrecioSocio` | Socios/members |
| 7 | Internet | `PrecioInternet` | Ventas online |
| 8 | Amigo | `PrecioAmigo` | Precio especial "amigo" |
| 9 | Especial | `PrecioEspecial` | Precio personalizado |
| 0 | Por defecto del cliente | segun `cliente.PrecioUsado` | Usa el nivel configurado para el cliente |

**Nota**: La tabla `articulo` tiene 9 columnas de precio distintas. La columna `PrecioFactura` se usa exclusivamente para facturacion y no esta asociada al selector `PrecioUsado`.

### 3.3 Bloqueado (flag de bloqueo/borrado logico)

Campo `tinyint(1)` presente en multiples tablas. Funciona como marcador de bloqueo o borrado logico:

| Valor | Significado |
|-------|-------------|
| 0 | Activo / desbloqueado |
| 1 | Bloqueado / inactivo |

Tablas donde aparece:
- `articulo.Bloqueado` - producto desactivado
- `ticket.Bloqueado` - ticket bloqueado (no editable)
- `inventario.Bloqueado` - conteo cerrado/bloqueado
- `stockentrada.Bloqueado` - entrada cerrada/bloqueada
- `empleado.Bloqueado` - empleado desactivado
- `almacen.Bloqueado` - almacen desactivado
- `articuloclase.Bloqueado` - categoria desactivada
- `pagoforma.Bloqueado` - forma de pago desactivada

### 3.4 Patrones de sincronizacion: DocumentoNo, DocumentoNoEnServidor, DocumentoNoOriginal

Las tablas de documentos (`ticket`, `inventario`, `stockentrada`, etc.) usan tres campos para gestionar IDs entre dispositivos locales y el servidor central:

| Campo | Tipo | Significado |
|-------|------|-------------|
| `DocumentoNo` | `bigint unsigned` | **ID local** en el dispositivo/PDA que creo el documento. Es la PK local. |
| `DocumentoNoEnServidor` | `bigint unsigned` | **ID asignado por el servidor** tras la sincronizacion. 0 = aun no sincronizado. |
| `DocumentoNoOriginal` | `bigint unsigned` | **ID del documento original** si este es una copia, modificacion o derivado (ej. ticket modificado). 0 si es original. |

Flujo tipico:
1. El PDA crea un ticket con `DocumentoNo` local (generado secuencialmente por dispositivo).
2. Al sincronizar con el servidor, se asigna `DocumentoNoEnServidor`.
3. Si el ticket se modifica, el nuevo ticket guarda en `DocumentoNoOriginal` el ID del ticket previo.

La tabla `documentono` gestiona las secuencias de IDs por tipo de documento:
- PK compuesta: `(DocumentoTipo, ID)`
- `DocumentoTipo` = nombre de la tabla (ej. "ticket", "inventario")
- `ID` = identificador del dispositivo/terminal
- `No` = ultimo numero secuencial usado

### 3.5 Sistema de Propiedades / Variantes (PropID)

El sistema maneja productos con variantes (talla, color, etc.) mediante las columnas `PropCount`, `PropID1`, `PropID2`:

| Campo | Tipo | Significado |
|-------|------|-------------|
| `PropCount` | `tinyint` | Numero de dimensiones de variante (0, 1 o 2) |
| `PropID1` | `varchar(4)` | ID de la primera variante (talla, tamano, etc.) |
| `PropID2` | `varchar(4)` | ID de la segunda variante (color, material, etc.) |
| `Propiedad` | `varchar(160)` | Descripcion en texto de la combinacion de variantes |

En `articulo`:
- `Prop1Titulo` define el nombre de la dimension 1 (ej. "Talla", "Peso")
- `Prop2Titulo` define el nombre de la dimension 2 (ej. "Color", "Sabor")
- `PropCount` indica cuantas dimensiones tiene el producto (0 = sin variantes)

Tablas que usan el sistema PropID:
- `stock` - PK compuesta incluye `(AlmacenID, ArticuloID, PropID1, PropID2)`
- `ticketarticulo` - identifica la variante vendida
- `inventarioarticulo` - identifica la variante contada
- `stockentradaarticulo` - identifica la variante recibida
- `articuloprop` / `prop` / `propdeta` - definen los valores posibles de cada variante

**Regla**: Cuando `PropCount = 0`, los campos `PropID1` y `PropID2` estan vacios (`""`). Cuando `PropCount = 1`, solo `PropID1` tiene valor. Cuando `PropCount = 2`, ambos tienen valor.

---

## 4. Agrupacion de Tablas por Dominio de Negocio

### Productos
| Tabla | Descripcion |
|-------|-------------|
| `articulo` | Maestro de productos (PK: `ArticuloID varchar(20)`) |
| `articuloextra` | Datos adicionales de productos (timestamps, precio privado) |
| `articulocodigobarra` | Codigos de barras alternativos (PK: `CodigoBarra`) |
| `articuloclase` | Categorias de productos (PK: `ClaseID`). Estructura jerarquica via `PadreID` |
| `articuloclaseorden` | Orden de categorias |
| `articuloprop` | Definicion de propiedades/variantes de productos |
| `articulodibujo` | Imagenes asociadas a productos |
| `articuloprecioconsulta` | Historial de consultas de precios |
| `articulopreciocoste` | Historial de precios de coste |
| `articuloeliminado` | Productos eliminados (auditoria) |
| `articulotiempoultimousar` | Timestamp de ultimo uso de cada producto |

### Inventario / Stock
| Tabla | Descripcion |
|-------|-------------|
| `stock` | Stock actual por almacen y variante (PK compuesta) |
| `almacen` | Maestro de almacenes (PK: `AlmacenID`) |
| `stockextra` | Stock adicional (sin variantes, PK: `AlmacenID + ArticuloID`) |
| `stockajuste` | Cabeceras de ajustes de stock |
| `stockajustearticulo` | Lineas de ajustes de stock |
| `stockcambio` | Registro de cambios de stock (auditoria) |
| `stockcambiocloud` | Cambios de stock pendientes de sincronizar con la nube |
| `stockextracambio` | Cambios en stockextra pendientes de sincronizar |

### Ventas
| Tabla | Descripcion |
|-------|-------------|
| `ticket` | Cabecera de tickets de venta (PK: `DocumentoNo`) |
| `ticketarticulo` | Lineas de detalle de tickets |
| `ticketcobro` | Registros de cobro vinculados a tickets |
| `ticketcolgando` | Tickets suspendidos/en espera |
| `ticketcolgandoarticulo` | Lineas de tickets suspendidos |
| `ticketextra` | Tickets extra/especiales |
| `ticketextraarticulo` | Lineas de tickets extra |
| `ticketoferta` | Tickets con oferta aplicada |
| `ticketdiariototal` | Totales diarios de ventas |
| `ticketivatotal` | Totales de IVA por ticket |
| `ticketsincobrado` | Tickets con cobro pendiente |

### Pagos
| Tabla | Descripcion |
|-------|-------------|
| `pago` | Registros de pago (PK: `DocumentoNo`) |
| `pagoforma` | Formas de pago disponibles (PK: `PagoFormaID`) |
| `cobro` | Registros de cobro generales |
| `preformadepago` | Pre-configuracion de formas de pago |

### Compras / Recepcion
| Tabla | Descripcion |
|-------|-------------|
| `stockentrada` | Cabecera de entradas de mercancia (PK: `DocumentoNo`) |
| `stockentradaarticulo` | Lineas de entrada de mercancia |
| `stocksalida` | Cabecera de salidas de mercancia |
| `stocksalidaarticulo` | Lineas de salida de mercancia |
| `proveedor` | Maestro de proveedores (PK: `EmpresaID`) |
| `pedidoproveedor` | Pedidos a proveedores |
| `pedidoproveedorarticulo` | Lineas de pedidos a proveedores |

### Recuentos de Inventario
| Tabla | Descripcion |
|-------|-------------|
| `inventario` | Cabecera de recuentos fisicos (PK: `DocumentoNo`) |
| `inventarioarticulo` | Lineas de productos contados |
| `inventariodoc` | Relacion entre documentos y recuentos |
| `inventariodocstock` | Stock detallado en el momento del recuento |

### Personas
| Tabla | Descripcion |
|-------|-------------|
| `cliente` | Maestro de clientes (PK: `EmpresaID`) |
| `clienteextra` | Datos adicionales de clientes |
| `clienteclase` | Clases/categorias de clientes |
| `clientediariototal` | Totales diarios por cliente |
| `clientelogin` | Credenciales de acceso de clientes |
| `clientesucursal` | Sucursales de clientes |
| `proveedor` | Maestro de proveedores (PK: `EmpresaID`) |
| `proveedorextra` | Datos adicionales de proveedores |
| `proveedorclase` | Clases de proveedores |
| `proveedorlogin` | Credenciales de acceso de proveedores |
| `proveedorsucursal` | Sucursales de proveedores |
| `empleado` | Maestro de empleados (PK: `EmpleadoID`) |
| `agente` | Agentes comerciales |

### Fiscal / Cumplimiento (VeriFactu)
Las tablas `verifactu_*` gestionan el cumplimiento de la normativa fiscal espanola (VeriFactu):

| Tabla | Descripcion |
|-------|-------------|
| `verifactu` | Registro principal VeriFactu |
| `verifactu_articulo` | Articulos en registros VeriFactu |
| `verifactu_cobro` | Cobros en registros VeriFactu |
| `verifactu_iva_total` | Totales de IVA VeriFactu |
| `verifactu_sin_cobrado` | Registros sin cobro VeriFactu |
| `verifactu_estado` | Estado de envios VeriFactu |
| `verifactu_cola` / `_prod` / `_test` | Cola de envios por entorno |
| `verifactu_ultima` / `_prod` / `_test` | Ultimo registro enviado por entorno |
| `verifactu_blockchain` / `_prod` / `_test` | Cadena de bloques fiscal |
| `verifactu_respuesta` | Respuestas del servicio VeriFactu |
| `verifactu_error` | Errores de envio VeriFactu |
| `verifactu_backup` | Copia de seguridad de registros |

### Sistema
| Tabla | Descripcion |
|-------|-------------|
| `opcion` | Opciones de configuracion global del sistema |
| `server_setting` | Configuracion del servidor |
| `documentono` | Secuencias de numeros de documento por tipo y terminal |
| `tempvalue` | Valores temporales para operaciones en curso |
| `log` | Registro de actividad (audit log) |
| `device` | Dispositivos registrados |
| `ordenadorejecutando` | PCs/terminales ejecutando la aplicacion |

---

## 5. Patrones de Consulta Comunes

### 5.1 Buscar producto por codigo de barras

La busqueda se realiza en dos pasos: primero en el campo principal `CodigoBarra` de `articulo`, y si no se encuentra, se busca en la tabla de codigos alternativos `articulocodigobarra`.

```sql
-- Paso 1: Busqueda directa en articulo
SELECT * FROM articulo
WHERE CodigoBarra = ?
  AND Bloqueado = 0
LIMIT 1;

-- Paso 2 (fallback): Busqueda en codigos alternativos
SELECT a.*
FROM articulo a
JOIN articulocodigobarra acb ON a.ArticuloID = acb.ArticuloID
WHERE acb.CodigoBarra = ?
  AND a.Bloqueado = 0
LIMIT 1;
```

### 5.2 Consultar stock de un producto

```sql
-- Stock total de un producto en todos los almacenes
SELECT s.AlmacenID, al.NombreES, s.PropID1, s.PropID2, s.Stock
FROM stock s
JOIN almacen al ON s.AlmacenID = al.AlmacenID
WHERE s.ArticuloID = ?
  AND al.Bloqueado = 0;

-- Stock de un producto en un almacen especifico
SELECT s.*
FROM stock s
WHERE s.ArticuloID = ?
  AND s.AlmacenID = ?;

-- Stock de una variante concreta
SELECT s.*
FROM stock s
WHERE s.ArticuloID = ?
  AND s.AlmacenID = ?
  AND s.PropID1 = ?
  AND s.PropID2 = ?;
```

### 5.3 Obtener ticket con sus lineas

```sql
-- Ticket con todas sus lineas
SELECT t.*, ta.*
FROM ticket t
JOIN ticketarticulo ta ON t.DocumentoNo = ta.DocumentoNo
WHERE t.DocumentoNo = ?
ORDER BY ta.OrdenNo;

-- Ticket con lineas y datos de producto
SELECT t.DocumentoNo, t.Fecha, t.Total, t.CobrarTipo,
       ta.ArticuloID, ta.NombreES, ta.Cantidad, ta.Precio, ta.IVA,
       ta.PropID1, ta.PropID2, ta.Propiedad
FROM ticket t
JOIN ticketarticulo ta ON t.DocumentoNo = ta.DocumentoNo
WHERE t.DocumentoNo = ?
  AND t.Bloqueado = 0
ORDER BY ta.OrdenNo;
```

### 5.4 Obtener pagos de un ticket

```sql
-- Pagos con descripcion de forma de pago
SELECT p.*, pf.Nombre AS FormaPagoNombre
FROM pago p
JOIN pagoforma pf ON p.PagoFormaID = pf.PagoFormaID
WHERE p.DocumentoNo = ?;
```

### 5.5 Consultar precio de un producto segun nivel

```sql
-- Obtener precio segun PrecioUsado (ejemplo: PrecioUsado = 1 = Detalle)
SELECT ArticuloID, NombreES,
  CASE ?
    WHEN 1 THEN PrecioDetalle
    WHEN 2 THEN PrecioMayor
    WHEN 3 THEN PrecioOferta
    WHEN 4 THEN PrecioCoste
    WHEN 5 THEN PrecioDomicilio
    WHEN 6 THEN PrecioSocio
    WHEN 7 THEN PrecioInternet
    WHEN 8 THEN PrecioAmigo
    WHEN 9 THEN PrecioEspecial
    ELSE PrecioDetalle
  END AS PrecioAplicado
FROM articulo
WHERE ArticuloID = ?;
```

### 5.6 Crear entrada de stock con lineas

```sql
-- 1. Crear cabecera
INSERT INTO stockentrada (DocumentoNo, AlmacenID, OperadorID, Fecha, ...)
VALUES (?, ?, ?, CURDATE(), ...);

-- 2. Insertar lineas
INSERT INTO stockentradaarticulo (DocumentoNo, ArticuloID, PropID1, PropID2, Cantidad, Precio, PrecioCoste, ...)
VALUES (?, ?, ?, ?, ?, ?, ?, ...);

-- 3. Actualizar stock
INSERT INTO stock (AlmacenID, ArticuloID, PropID1, PropID2, Stock)
VALUES (?, ?, ?, ?, ?)
ON DUPLICATE KEY UPDATE Stock = Stock + VALUES(Stock);
```

### 5.7 Crear recuento de inventario

```sql
-- 1. Crear cabecera
INSERT INTO inventario (DocumentoNo, AlmacenID, OperadorID, Fecha, ...)
VALUES (?, ?, ?, CURDATE(), ...);

-- 2. Insertar lineas contadas
INSERT INTO inventarioarticulo (DocumentoNo, ArticuloID, PropID1, PropID2, Cantidad, Precio, ...)
VALUES (?, ?, ?, ?, ?, ?, ...);
```

### 5.8 Buscar productos por categoria

```sql
-- Productos de una categoria (con nombre de categoria)
SELECT a.ArticuloID, a.NombreES, a.CodigoBarra, a.PrecioDetalle,
       ac.NombreES AS CategoriaNombre
FROM articulo a
JOIN articuloclase ac ON a.ClaseID = ac.ClaseID
WHERE a.ClaseID = ?
  AND a.Bloqueado = 0
ORDER BY a.OrdenNo;

-- Productos de una categoria y sus subcategorias (estructura jerarquica)
SELECT a.ArticuloID, a.NombreES, a.CodigoBarra
FROM articulo a
JOIN articuloclase ac ON a.ClaseID = ac.ClaseID
WHERE (ac.ClaseID = ? OR ac.PadreID = ?)
  AND a.Bloqueado = 0
  AND ac.Bloqueado = 0
ORDER BY a.OrdenNo;
```

---

## 6. Notas para el Desarrollo del PDA

### Consideraciones de sincronizacion offline
- Los documentos creados en el PDA usan `DocumentoNo` local.
- `DocumentoNoEnServidor = 0` indica que aun no se ha sincronizado con el servidor.
- El campo `Modificando` (tinyint) actua como semaforo para evitar ediciones concurrentes.

### Conexion via API Flask
Las consultas anteriores NO se ejecutan directamente desde el PDA. Se realizan a traves de endpoints del puente REST API Flask, que traduce las peticiones HTTP a consultas MySQL. Ver [backend_bridge_setup.md](./backend_bridge_setup.md) para la especificacion de endpoints.

### Campos multilingue
Muchas tablas tienen campos duplicados para espanol y chino:
- `NombreES` / `NombreCN` - Nombre en espanol / chino
- La tabla `articulo` tiene `Nombre1`..`Nombre9` para nombres en multiples idiomas

### Control de concurrencia
- `Modificando` (tinyint): Flag de bloqueo optimista durante edicion.
- `UpdateTimeStamp` / `TiempoUltimoEditar`: Para deteccion de conflictos de sincronizacion.
- `Bloqueado`: Una vez fijado a 1, el documento no debe modificarse (estado cerrado).
