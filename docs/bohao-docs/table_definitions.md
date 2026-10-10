# Definición de Tablas: bohaosupermarket3

Este documento contiene la estructura detallada (columnas, tipos de datos) de las tablas de la base de datos.

Instantánea contrastada con la instalación local el 10 de octubre de 2026. Los esquemas pueden diferir entre versiones de Bohao; v6.22 se conserva por separado en `../bohao-v622-schema.sql`.

## 1. Tablas Core (Principales)
### Tabla: `articulo`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| ArticuloID | varchar(20) | NO | PRI |  |  |
| CodigoBarra | varchar(20) | NO | MUL |  |  |
| Prop1Titulo | varchar(40) | NO |  |  |  |
| Prop2Titulo | varchar(40) | NO |  |  |  |
| PropCount | tinyint(4) | NO |  | 0 |  |
| NombreES | varchar(255) | NO |  |  |  |
| NombreCN | varchar(80) | NO |  |  |  |
| Descripcion | varchar(120) | NO |  |  |  |
| PrecioDetalle | decimal(12,4) | NO |  | 0.0000 |  |
| PrecioDomicilio | decimal(12,4) | NO |  | 0.0000 |  |
| PrecioSocio | decimal(12,4) | NO |  | 0.0000 |  |
| PrecioMayor | decimal(12,4) | NO |  | 0.0000 |  |
| PrecioFactura | decimal(12,4) | NO |  | 0.0000 |  |
| PrecioInternet | decimal(12,4) | NO |  | 0.0000 |  |
| PrecioAmigo | decimal(12,4) | NO |  | 0.0000 |  |
| PrecioEspecial | decimal(12,4) | NO |  | 0.0000 |  |
| PrecioOferta | decimal(12,4) | NO |  | 0.0000 |  |
| PrecioCoste | decimal(12,4) | NO |  | 0.0000 |  |
| CantidadPorUnidad | decimal(12,4) | NO |  | 1.0000 |  |
| CantidadPorUnidad2 | decimal(12,4) | NO |  | 1.0000 |  |
| VolumenPeso | decimal(12,4) | NO |  | 0.0000 |  |
| UnidadUsarRegla | smallint(5) unsigned | NO |  | 0 |  |
| ClaseID | smallint(5) unsigned | NO | MUL | 1 |  |
| UnidadNombre | varchar(30) | NO |  |  |  |
| FechaPrecioCoste | date | YES |  | NULL |  |
| Descuento | decimal(5,2) | NO |  | 0.00 |  |
| FacturaPorcentaje | decimal(5,2) | NO |  | 100.00 |  |
| FechaCaducada | date | YES |  | NULL |  |
| EmpresaID | bigint(12) unsigned | NO |  | 0 |  |
| Oferta | tinyint(1) | NO |  | 0 |  |
| Privado | tinyint(1) | NO |  | 0 |  |
| UsarPrecioPorCantidad | tinyint(1) | NO |  | 0 |  |
| UsarDescuentoPorCantidad | tinyint(1) | NO |  | 0 |  |
| Precio1 | decimal(12,4) | NO |  | 0.0000 |  |
| Descuento1 | decimal(5,2) | NO |  | 0.00 |  |
| Cantidad1 | decimal(12,4) | NO |  | 0.0000 |  |
| Precio2 | decimal(12,4) | NO |  | 0.0000 |  |
| Descuento2 | decimal(5,2) | NO |  | 0.00 |  |
| Cantidad2 | decimal(12,4) | NO |  | 0.0000 |  |
| Precio3 | decimal(12,4) | NO |  | 0.0000 |  |
| Descuento3 | decimal(5,2) | NO |  | 0.00 |  |
| Cantidad3 | decimal(12,4) | NO |  | 0.0000 |  |
| Precio4 | decimal(12,4) | NO |  | 0.0000 |  |
| Descuento4 | decimal(5,2) | NO |  | 0.00 |  |
| Cantidad4 | decimal(12,4) | NO |  | 0.0000 |  |
| Precio5 | decimal(12,4) | NO |  | 0.0000 |  |
| Descuento5 | decimal(5,2) | NO |  | 0.00 |  |
| Cantidad5 | decimal(12,4) | NO |  | 0.0000 |  |
| Precio6 | decimal(12,4) | NO |  | 0.0000 |  |
| Descuento6 | decimal(5,2) | NO |  | 0.00 |  |
| Nombre1 | varchar(255) | NO |  |  |  |
| Nombre2 | varchar(255) | NO |  |  |  |
| Nombre3 | varchar(255) | NO |  |  |  |
| Nombre4 | varchar(255) | NO |  |  |  |
| Nombre5 | varchar(255) | NO |  |  |  |
| Nombre6 | varchar(255) | NO |  |  |  |
| Nombre7 | varchar(255) | NO |  |  |  |
| Nombre8 | varchar(255) | NO |  |  |  |
| Nombre9 | varchar(255) | NO |  |  |  |
| SitioEnAlmacen | varchar(60) | NO |  |  |  |
| SitioEnEstante | varchar(60) | NO |  |  |  |
| SerialNo | varchar(80) | NO |  |  |  |
| MiniStock | decimal(18,4) | NO |  | 0.0000 |  |
| MaxiStock | decimal(18,4) | NO |  | 0.0000 |  |
| DibujoID | bigint(20) unsigned | NO | MUL | 0 |  |
| Recomendado | tinyint(1) | NO |  | 0 |  |
| DescuentoCambioProhibido | tinyint(1) | NO |  | 0 |  |
| AliIngrediente | varchar(255) | NO |  |  |  |
| AliPesoTotal | varchar(20) | NO |  |  |  |
| AliPesoNeto | varchar(20) | NO |  |  |  |
| AliFechaCaducada | varchar(20) | NO |  |  |  |
| AliLugarFabricante | varchar(20) | NO |  |  |  |
| AliImportador | varchar(40) | NO |  |  |  |
| AliNumeroSanitario | varchar(20) | NO |  |  |  |
| AliNumeroLote | varchar(20) | NO |  |  |  |
| AliAdjuncion | varchar(255) | NO |  |  |  |
| MultiCodigo | varchar(1024) | NO |  |  |  |
| OrdenNo | int(10) unsigned | NO | MUL | 0 |  |
| OrdenNoFinal | bigint(20) | NO | MUL | 0 |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| Observacion | varchar(2048) | YES |  | NULL |

### Tabla: `articuloextra`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| ArticuloID | varchar(20) | NO | PRI |  |  |
| ConsultaParcial | varchar(1024) | NO |  |  |  |
| Signo | tinyint(1) | NO |  | -1 |  |
| TiempoSigno | datetime | YES |  | NULL |  |
| UpdateTimeStamp | timestamp | NO |  | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |
| CreateTimeStamp | timestamp | NO |  | CURRENT_TIMESTAMP |  |
| PrecioPrivado | decimal(12,4) | NO |  | 0.0000 |

### Tabla: `articulocodigobarra`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| CodigoBarra | varchar(20) | NO | PRI |  |  |
| ArticuloID | varchar(20) | NO |

### Tabla: `stock`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| AlmacenID | smallint(5) unsigned | NO | PRI | 1 |  |
| ArticuloID | varchar(20) | NO | PRI |  |  |
| PropCount | smallint(5) unsigned | NO |  | 0 |  |
| PropID1 | varchar(4) | NO | PRI |  |  |
| PropID2 | varchar(4) | NO | PRI |  |  |
| Stock | decimal(18,4) | NO |  | 0.0000 |  |
| SitioEnAlmacen | varchar(60) | NO |  |  |  |
| SitioEnEstante | varchar(60) | NO |  |  |  |
| MiniStock | decimal(18,4) | NO |  | 0.0000 |  |
| MaxiStock | decimal(18,4) | NO |  | 0.0000 |

### Tabla: `ticket`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| DocumentoNo | bigint(18) unsigned | NO | PRI | 0 |  |
| DocumentoNoEnServidor | bigint(18) unsigned | NO |  | 0 |  |
| DocumentoNoOriginal | bigint(18) unsigned | NO |  | 0 |  |
| Fecha | date | YES | MUL | NULL |  |
| FechaEntrada | datetime | NO |  | CURRENT_TIMESTAMP |  |
| FechaOriginal | datetime | YES |  | NULL |  |
| TiempoUltimoEditar | datetime | YES |  | NULL |  |
| TiempoUltimoActualizar | datetime | YES |  | NULL |  |
| VeriFactuUUID | bigint(20) unsigned | NO |  | 0 |  |
| DocumentoOrigenTipo | varchar(40) | NO |  |  |  |
| DocumentoOrigenNo | bigint(18) unsigned | NO |  | 0 |  |
| DocumentoDestinoTipo | varchar(40) | NO |  |  |  |
| DocumentoDestinoNo | bigint(18) unsigned | NO |  | 0 |  |
| CobrarTipo | tinyint(3) unsigned | NO |  | 0 |  |
| Efectivo | decimal(14,4) | NO |  | 0.0000 |  |
| Descuento | decimal(5,2) | NO |  | 0.00 |  |
| Descuento2 | decimal(5,2) | NO |  | 0.00 |  |
| DescuentoDirecto | decimal(10,4) | NO |  | 0.0000 |  |
| Total | decimal(14,4) | NO |  | 0.0000 |  |
| DescuentoTotal | decimal(10,4) | NO |  | 0.0000 |  |
| DescuentoExtra | decimal(5,2) | NO |  | 0.00 |  |
| DescuentoUsarRegla | smallint(5) unsigned | NO |  | 0 |  |
| Ganancias | decimal(12,4) | NO |  | 0.0000 |  |
| CobroTotal | decimal(14,4) | NO |  | 0.0000 |  |
| CantidadTotal | decimal(12,4) | NO |  | 0.0000 |  |
| PaqueteTotal | decimal(12,4) | NO |  | 0.0000 |  |
| CajaTotal | decimal(12,4) | NO |  | 0.0000 |  |
| VolumenPesoTotal | decimal(12,4) | NO |  | 0.0000 |  |
| LineaTotal | int(10) unsigned | NO |  | 0 |  |
| ReglaIVA | tinyint(2) unsigned | NO |  | 0 |  |
| IVASerie | tinyint(2) unsigned | NO |  | 0 |  |
| PrecioUsado | tinyint(2) unsigned | NO |  | 1 |  |
| CajonID | smallint(5) unsigned | NO |  | 0 |  |
| EmpresaID | bigint(12) unsigned | NO |  | 0 |  |
| SucursalID | smallint(5) unsigned | NO |  | 0 |  |
| ClienteIVAClase | tinyint(2) unsigned | NO |  | 0 |  |
| ClienteReglaIVA | tinyint(2) unsigned | NO |  | 0 |  |
| UsarClienteReglaIVA | tinyint(1) | NO |  | 0 |  |
| AgenteID | smallint(5) unsigned | NO |  | 0 |  |
| TransportistaID | smallint(5) unsigned | NO |  | 0 |  |
| TransporteModoID | smallint(5) unsigned | NO |  | 0 |  |
| EnvioGasto | decimal(14,4) | NO |  | 0.0000 |  |
| CocheNo | varchar(40) | NO |  |  |  |
| OperadorID | smallint(5) unsigned | NO |  | 0 |  |
| VerificadorID | smallint(5) unsigned | NO |  | 0 |  |
| AlmacenID | smallint(5) unsigned | NO |  | 1 |  |
| DocumentoAdjuntoSimbolo | varchar(60) | NO |  |  |  |
| PreFormaDePagoNo | int(10) unsigned | NO |  | 0 |  |
| OrdenadorNombre | varchar(16) | NO |  |  |  |
| DeviceUUID | varchar(64) | NO |  |  |  |
| DocumentoHash | varchar(255) | NO |  |  |  |
| SubTiendaID | varchar(16) | NO |  |  |  |
| DocumentoIntercambioNo | bigint(18) | NO |  | 0 |  |
| AbonoTotal | decimal(14,4) | NO |  | 0.0000 |  |
| Cobrado | tinyint(1) | NO |  | -1 |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| Anulado | tinyint(1) | NO |  | 0 |  |
| Modificando | tinyint(1) | NO |  | 0 |  |
| EmailMandado | tinyint(1) | NO |  | 0 |  |
| ProgressID | tinyint(3) unsigned | NO |  | 0 |  |
| ProgressStatus | tinyint(3) unsigned | NO |  | 0 |  |
| LogID | bigint(20) unsigned | NO |  | 0 |  |
| HayAdjunto | tinyint(1) | NO |  | 0 |  |
| Imprimido | tinyint(1) | NO |  | 0 |  |
| Observacion | varchar(2048) | YES |  | NULL |  |
| UpdateTimeStamp | timestamp | NO |  | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |

### Tabla: `ticketarticulo`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| DocumentoNo | bigint(18) unsigned | NO | MUL | 0 |  |
| ArticuloID | varchar(20) | NO |  |  |  |
| PropCount | smallint(5) unsigned | NO |  | 0 |  |
| PropID1 | varchar(4) | NO |  |  |  |
| PropID2 | varchar(4) | NO |  |  |  |
| Propiedad | varchar(160) | NO |  |  |  |
| SerialNo | varchar(4096) | NO |  |  |  |
| CodigoBarra | varchar(20) | NO |  |  |  |
| CodigoBarraBalanza | tinyint(1) | NO |  | 0 |  |
| NombreES | varchar(255) | NO |  |  |  |
| NombreCN | varchar(80) | NO |  |  |  |
| Precio | decimal(12,4) | NO |  | 0.0000 |  |
| Cantidad | decimal(12,4) | NO |  | 0.0000 |  |
| IVA | decimal(6,3) | NO |  | 0.000 |  |
| REQ | decimal(6,3) | NO |  | 0.000 |  |
| Descuento | decimal(5,2) | NO |  | 0.00 |  |
| DescuentoCambioProhibido | tinyint(1) | NO |  | 0 |  |
| PrecioCoste | decimal(12,4) | NO |  | 0.0000 |  |
| PrecioAgente | decimal(12,4) | NO |  | 0.0000 |  |
| Comentario | varchar(1024) | YES |  | NULL |  |
| NecesitaSerialNo | tinyint(1) | NO |  | 0 |  |
| Temporal | tinyint(1) | NO |  | 0 |  |
| OrdenNo | int(10) unsigned | NO |  | 0 |

### Tabla: `cliente`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| EmpresaID | bigint(12) unsigned | NO | PRI | 0 |  |
| NombreES | varchar(100) | NO |  |  |  |
| NombreCN | varchar(60) | NO |  |  |  |
| CIF | varchar(60) | NO |  |  |  |
| NumeroIVA | varchar(30) | NO |  |  |  |
| Domicilio | varchar(120) | NO |  |  |  |
| CodigoPostal | varchar(20) | NO |  |  |  |
| Poblacion | varchar(60) | NO |  |  |  |
| Provincia | varchar(60) | NO |  |  |  |
| Pais | varchar(60) | NO |  |  |  |
| CountryID | varchar(2) | NO |  |  |  |
| PersonaContacto | varchar(60) | NO |  |  |  |
| Sexo | smallint(5) unsigned | NO |  | 0 |  |
| Cumpleano | date | YES |  | NULL |  |
| Telefono | varchar(40) | NO |  |  |  |
| Telefono2 | varchar(40) | NO |  |  |  |
| Fax | varchar(40) | NO |  |  |  |
| Email | varchar(60) | NO |  |  |  |
| Web | varchar(60) | NO |  |  |  |
| IM | varchar(40) | NO |  |  |  |
| IVAClase | tinyint(2) unsigned | NO |  | 0 |  |
| ReglaIVA | tinyint(2) unsigned | NO |  | 0 |  |
| FacturaPorcentaje | decimal(5,2) | NO |  | 100.00 |  |
| FacturaDescuento | decimal(5,2) | NO |  | 0.00 |  |
| FacturaSDIID | varchar(40) | NO |  |  |  |
| FacturaCEC | varchar(60) | NO |  |  |  |
| BancoCuentaNo | varchar(200) | NO |  |  |  |
| NecesitaFactura | tinyint(1) | NO |  | 0 |  |
| AutoEmailDocumento | tinyint(1) | NO |  | 0 |  |
| Descuento | decimal(5,2) | NO |  | 0.00 |  |
| DescuentoSerie | tinyint(3) | NO |  | 0 |  |
| DescuentoExtra | decimal(5,2) | NO |  | 0.00 |  |
| MaxSobregiro | decimal(18,4) | NO |  | 0.0000 |  |
| SerSocio | tinyint(1) | NO |  | 0 |  |
| TarjetaSocioID | varchar(40) | YES | UNI | NULL |  |
| ClaseID | smallint(5) unsigned | NO | MUL | 1 |  |
| AgenteID | smallint(5) unsigned | NO |  | 0 |  |
| TransportistaID | smallint(5) unsigned | NO |  | 0 |  |
| TransporteModoID | smallint(5) unsigned | NO |  | 0 |  |
| EnvioGasto | decimal(14,4) | NO |  | 0.0000 |  |
| CocheNo | varchar(40) | NO |  |  |  |
| ChinoProhibido | tinyint(1) | NO |  | 0 |  |
| Extrajero | tinyint(1) | NO |  | 0 |  |
| Idioma | tinyint(3) | NO |  | 0 |  |
| IdiomaSerie | tinyint(3) | NO |  | 0 |  |
| PrecioUsado | tinyint(2) unsigned | NO |  | 0 |  |
| LoginEnabled | tinyint(1) | NO |  | 0 |  |
| ImprimirArticuloOrden | smallint(5) unsigned | NO |  | 0 |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| VeriFactu | tinyint(1) | NO |  | 0 |  |
| UltimaFechaVeriFactu | date | YES |  | NULL |  |
| Observacion | varchar(2048) | YES |  | NULL |

### Tabla: `proveedor`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| EmpresaID | bigint(12) unsigned | NO | PRI | 0 |  |
| NombreES | varchar(100) | NO |  |  |  |
| NombreCN | varchar(60) | NO |  |  |  |
| CIF | varchar(60) | NO |  |  |  |
| NumeroIVA | varchar(30) | NO |  |  |  |
| Domicilio | varchar(120) | NO |  |  |  |
| CodigoPostal | varchar(20) | NO |  |  |  |
| Poblacion | varchar(60) | NO |  |  |  |
| Provincia | varchar(60) | NO |  |  |  |
| Pais | varchar(60) | NO |  |  |  |
| CountryID | varchar(2) | NO |  |  |  |
| PersonaContacto | varchar(60) | NO |  |  |  |
| Sexo | smallint(5) unsigned | NO |  | 0 |  |
| Cumpleano | date | YES |  | NULL |  |
| Telefono | varchar(40) | NO |  |  |  |
| Telefono2 | varchar(40) | NO |  |  |  |
| Fax | varchar(40) | NO |  |  |  |
| Email | varchar(60) | NO |  |  |  |
| Web | varchar(60) | NO |  |  |  |
| IM | varchar(40) | NO |  |  |  |
| IVAClase | tinyint(2) unsigned | NO |  | 0 |  |
| ReglaIVA | tinyint(2) unsigned | NO |  | 0 |  |
| FacturaPorcentaje | decimal(5,2) | NO |  | 100.00 |  |
| FacturaDescuento | decimal(5,2) | NO |  | 0.00 |  |
| FacturaSDIID | varchar(40) | NO |  |  |  |
| FacturaCEC | varchar(60) | NO |  |  |  |
| BancoCuentaNo | varchar(200) | NO |  |  |  |
| NecesitaFactura | tinyint(1) | NO |  | 0 |  |
| AutoEmailDocumento | tinyint(1) | NO |  | 0 |  |
| Descuento | decimal(5,2) | NO |  | 0.00 |  |
| DescuentoSerie | tinyint(3) | NO |  | 0 |  |
| DescuentoExtra | decimal(5,2) | NO |  | 0.00 |  |
| MaxSobregiro | decimal(18,4) | NO |  | 0.0000 |  |
| SerSocio | tinyint(1) | NO |  | 0 |  |
| TarjetaSocioID | varchar(40) | YES | UNI | NULL |  |
| ClaseID | smallint(5) unsigned | NO | MUL | 1 |  |
| AgenteID | smallint(5) unsigned | NO |  | 0 |  |
| TransportistaID | smallint(5) unsigned | NO |  | 0 |  |
| TransporteModoID | smallint(5) unsigned | NO |  | 0 |  |
| EnvioGasto | decimal(14,4) | NO |  | 0.0000 |  |
| CocheNo | varchar(40) | NO |  |  |  |
| ChinoProhibido | tinyint(1) | NO |  | 0 |  |
| Extrajero | tinyint(1) | NO |  | 0 |  |
| Idioma | tinyint(3) | NO |  | 0 |  |
| IdiomaSerie | tinyint(3) | NO |  | 0 |  |
| PrecioUsado | tinyint(2) unsigned | NO |  | 0 |  |
| LoginEnabled | tinyint(1) | NO |  | 0 |  |
| ImprimirArticuloOrden | smallint(5) unsigned | NO |  | 0 |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| Observacion | varchar(2048) | YES |  | NULL |

### Tabla: `empleado`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| EmpleadoID | smallint(5) unsigned | NO | PRI | 0 |  |
| Nombre | varchar(18) | NO | UNI |  |  |
| Contrasena | varchar(255) | NO |  |  |  |
| ContrasenaSegura | varchar(255) | NO |  |  |  |
| Idioma | tinyint(3) | NO |  | 0 |  |
| IdiomaSerie | tinyint(3) | NO |  | 0 |  |
| ClaseID | smallint(5) unsigned | NO |  | 1 |  |
| CIF | varchar(60) | NO |  |  |  |
| Telefono | varchar(40) | NO |  |  |  |
| Telefono2 | varchar(40) | NO |  |  |  |
| Fax | varchar(40) | NO |  |  |  |
| Email | varchar(60) | NO |  |  |  |
| Web | varchar(60) | NO |  |  |  |
| IM | varchar(40) | NO |  |  |  |
| LastLoginTime | datetime | YES |  | NULL |  |
| LastLoginInfo | varchar(200) | NO |  |  |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| Observacion | varchar(2048) | YES |  | NULL |

### Tabla: `inventario`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| DocumentoNo | bigint(18) unsigned | NO | PRI | 0 |  |
| DocumentoNoEnServidor | bigint(18) unsigned | NO |  | 0 |  |
| DocumentoNoOriginal | bigint(18) unsigned | NO |  | 0 |  |
| AlmacenID | smallint(5) unsigned | NO |  | 1 |  |
| ArticuloClaseID | smallint(5) unsigned | NO |  | 0 |  |
| CantidadTotal | decimal(12,4) | NO |  | 0.0000 |  |
| PaqueteTotal | decimal(12,4) | NO |  | 0.0000 |  |
| CajaTotal | decimal(12,4) | NO |  | 0.0000 |  |
| VolumenPesoTotal | decimal(12,4) | NO |  | 0.0000 |  |
| LineaTotal | int(10) unsigned | NO |  | 0 |  |
| PrecioUsado | tinyint(2) unsigned | NO |  | 1 |  |
| Total | decimal(14,4) | NO |  | 0.0000 |  |
| Fecha | date | YES | MUL | NULL |  |
| FechaEntrada | datetime | NO |  | CURRENT_TIMESTAMP |  |
| FechaOriginal | datetime | YES |  | NULL |  |
| TiempoUltimoEditar | datetime | YES |  | NULL |  |
| TiempoUltimoActualizar | datetime | YES |  | NULL |  |
| TransportistaID | smallint(5) unsigned | NO |  | 0 |  |
| TransporteModoID | smallint(5) unsigned | NO |  | 0 |  |
| EnvioGasto | decimal(14,4) | NO |  | 0.0000 |  |
| OperadorID | smallint(5) unsigned | NO |  | 0 |  |
| VerificadorID | smallint(5) unsigned | NO |  | 0 |  |
| DocumentoAdjuntoSimbolo | varchar(60) | NO |  |  |  |
| OrdenadorNombre | varchar(16) | NO |  |  |  |
| SubTiendaID | varchar(16) | NO |  |  |  |
| DocumentoIntercambioNo | bigint(18) | NO |  | 0 |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| Modificando | tinyint(1) | NO |  | 0 |  |
| Observacion | varchar(2048) | YES |  | NULL |  |
| UpdateTimeStamp | timestamp | NO |  | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |

### Tabla: `factura`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| DocumentoNo | bigint(18) unsigned | NO | PRI | 0 |  |
| DocumentoNoEnServidor | bigint(18) unsigned | NO |  | 0 |  |
| DocumentoNoOriginal | bigint(18) unsigned | NO |  | 0 |  |
| EmpresaID | bigint(12) unsigned | NO |  | 0 |  |
| SucursalID | smallint(5) unsigned | NO |  | 0 |  |
| ClienteIVAClase | tinyint(2) unsigned | NO |  | 0 |  |
| ClienteReglaIVA | tinyint(2) unsigned | NO |  | 0 |  |
| UsarClienteReglaIVA | tinyint(1) | NO |  | 0 |  |
| Descuento | decimal(5,2) | NO |  | 0.00 |  |
| Descuento2 | decimal(5,2) | NO |  | 0.00 |  |
| DescuentoDirecto | decimal(10,4) | NO |  | 0.0000 |  |
| Total | decimal(14,4) | NO |  | 0.0000 |  |
| DescuentoTotal | decimal(10,4) | NO |  | 0.0000 |  |
| DescuentoExtra | decimal(5,2) | NO |  | 0.00 |  |
| CobrarTipo | tinyint(3) unsigned | NO |  | 0 |  |
| Efectivo | decimal(14,4) | NO |  | 0.0000 |  |
| Ganancias | decimal(12,4) | NO |  | 0.0000 |  |
| CantidadTotal | decimal(12,4) | NO |  | 0.0000 |  |
| PaqueteTotal | decimal(12,4) | NO |  | 0.0000 |  |
| CajaTotal | decimal(12,4) | NO |  | 0.0000 |  |
| VolumenPesoTotal | decimal(12,4) | NO |  | 0.0000 |  |
| LineaTotal | int(10) unsigned | NO |  | 0 |  |
| Fecha | date | YES | MUL | NULL |  |
| FechaEntrada | datetime | NO |  | CURRENT_TIMESTAMP |  |
| FechaOriginal | datetime | YES |  | NULL |  |
| TiempoUltimoEditar | datetime | YES |  | NULL |  |
| TiempoUltimoActualizar | datetime | YES |  | NULL |  |
| DocumentoOrigenTipo | varchar(40) | NO |  |  |  |
| DocumentoOrigenNo | bigint(18) unsigned | NO |  | 0 |  |
| DocumentoDestinoTipo | varchar(40) | NO |  |  |  |
| DocumentoDestinoNo | bigint(18) unsigned | NO |  | 0 |  |
| ReglaIVA | tinyint(2) unsigned | NO |  | 0 |  |
| IVASerie | tinyint(2) unsigned | NO |  | 0 |  |
| PrecioUsado | tinyint(2) unsigned | NO |  | 1 |  |
| AgenteID | smallint(5) unsigned | NO |  | 0 |  |
| TransportistaID | smallint(5) unsigned | NO |  | 0 |  |
| TransporteModoID | smallint(5) unsigned | NO |  | 0 |  |
| EnvioGasto | decimal(14,4) | NO |  | 0.0000 |  |
| CocheNo | varchar(40) | NO |  |  |  |
| OperadorID | smallint(5) unsigned | NO |  | 0 |  |
| VerificadorID | smallint(5) unsigned | NO |  | 0 |  |
| AlmacenID | smallint(5) unsigned | NO |  | 1 |  |
| Cobrado | tinyint(1) | NO |  | -1 |  |
| CobroTotal | decimal(14,4) | NO |  | 0.0000 |  |
| AbonoTotal | decimal(14,4) | NO |  | 0.0000 |  |
| CajonID | smallint(5) unsigned | NO |  | 0 |  |
| DescuentoUsarRegla | smallint(5) unsigned | NO |  | 0 |  |
| FormaDePago | enum('Efectivo','Tarjeta','Cheque','Transferencia','Pendiente','Vale','Cupon','Descuento','Otro','ValeSalida','DescuentoCliente','Multi') | NO |  | Efectivo |  |
| DocumentoAdjuntoSimbolo | varchar(60) | NO |  |  |  |
| PreFormaDePagoNo | int(10) unsigned | NO |  | 0 |  |
| OrdenadorNombre | varchar(16) | NO |  |  |  |
| DeviceUUID | varchar(64) | NO |  |  |  |
| DocumentoHash | varchar(255) | NO |  |  |  |
| SubTiendaID | varchar(16) | NO |  |  |  |
| DocumentoIntercambioNo | bigint(18) | NO |  | 0 |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| Anulado | tinyint(1) | NO |  | 0 |  |
| Modificando | tinyint(1) | NO |  | 0 |  |
| EmailMandado | tinyint(1) | NO |  | 0 |  |
| ProgressID | tinyint(3) unsigned | NO |  | 0 |  |
| ProgressStatus | tinyint(3) unsigned | NO |  | 0 |  |
| LogID | bigint(20) unsigned | NO |  | 0 |  |
| HayAdjunto | tinyint(1) | NO |  | 0 |  |
| Imprimido | tinyint(1) | NO |  | 0 |  |
| Observacion | varchar(2048) | YES |  | NULL |  |
| UpdateTimeStamp | timestamp | NO |  | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |

### Tabla: `pago`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| DocumentoNo | bigint(18) unsigned | NO | PRI | 0 |  |
| DocumentoNoEnServidor | bigint(18) unsigned | NO |  | 0 |  |
| DocumentoNoOriginal | bigint(18) unsigned | NO |  | 0 |  |
| DocumentoOriginalTipo | char(1) | NO |  |  |  |
| DocumentoOriginalNo | bigint(18) unsigned | NO |  | 0 |  |
| DocumentoAdjuntoSimbolo | varchar(60) | NO |  |  |  |
| EmpresaID | bigint(12) unsigned | NO |  | 0 |  |
| Fecha | date | YES |  | NULL |  |
| PagoFormaID | smallint(5) unsigned | NO |  | 0 |  |
| Importe | decimal(14,4) | NO |  | 0.0000 |  |
| FechaEntrada | datetime | NO |  | CURRENT_TIMESTAMP |  |
| FechaOriginal | datetime | YES |  | NULL |  |
| TiempoUltimoEditar | datetime | YES |  | NULL |  |
| TiempoUltimoActualizar | datetime | YES |  | NULL |  |
| AgenteID | smallint(5) unsigned | NO |  | 0 |  |
| TransportistaID | smallint(5) unsigned | NO |  | 0 |  |
| TransporteModoID | smallint(5) unsigned | NO |  | 0 |  |
| EnvioGasto | decimal(14,4) | NO |  | 0.0000 |  |
| HayAdjunto | tinyint(1) | NO |  | 0 |  |
| OperadorID | smallint(5) unsigned | NO |  | 0 |  |
| VerificadorID | smallint(5) unsigned | NO |  | 0 |  |
| OrdenadorNombre | varchar(16) | NO |  |  |  |
| DocumentoIntercambioNo | bigint(18) | NO |  | 0 |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| Observacion | varchar(2048) | YES |  | NULL |  |
| UpdateTimeStamp | timestamp | NO |  | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |

### Tabla: `almacen`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| AlmacenID | smallint(5) unsigned | NO | PRI | 0 |  |
| NombreES | varchar(30) | NO |  |  |  |
| NombreCN | varchar(60) | NO |  |  |  |
| SoloSubTienda | tinyint(1) | NO |  | 0 |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| Observacion | varchar(2048) | YES |  | NULL |  |

### Tabla: `articuloclase`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| ClaseID | smallint(5) unsigned | NO | PRI | 1 |  |
| PadreID | smallint(5) unsigned | NO |  | 0 |  |
| NombreES | varchar(60) | NO |  |  |  |
| NombreCN | varchar(60) | NO |  |  |  |
| IVAID | smallint(5) unsigned | NO |  | 1 |  |
| Descuento | decimal(5,2) | NO |  | 0.00 |  |
| Descuento1 | decimal(5,2) | NO |  | 0.00 |  |
| Descuento2 | decimal(5,2) | NO |  | 0.00 |  |
| Descuento3 | decimal(5,2) | NO |  | 0.00 |  |
| Descuento4 | decimal(5,2) | NO |  | 0.00 |  |
| Descuento5 | decimal(5,2) | NO |  | 0.00 |  |
| Descuento6 | decimal(5,2) | NO |  | 0.00 |  |
| Descuento7 | decimal(5,2) | NO |  | 0.00 |  |
| Descuento8 | decimal(5,2) | NO |  | 0.00 |  |
| Descuento9 | decimal(5,2) | NO |  | 0.00 |  |
| TicketDescuentoUsarRegla | tinyint(3) unsigned | NO |  | 0 |  |
| FacturaPorcentaje | decimal(5,2) | NO |  | 100.00 |  |
| UnidadUsarRegla | smallint(5) unsigned | NO |  | 0 |  |
| UnidadNombre | varchar(30) | NO |  |  |  |
| ContarGanancias | tinyint(1) | NO |  | 0 |  |
| ContarVolumenPeso | tinyint(1) | NO |  | 0 |  |
| StockBloqueado | tinyint(1) | NO |  | 0 |  |
| PadreGrupo | varchar(1024) | NO |  | 0 |  |
| NecesitaSerialNo | tinyint(1) | NO |  | 0 |  |
| DescuentoCambioProhibido | tinyint(1) | NO |  | 0 |  |
| ClienteInvisible | tinyint(1) | NO |  | 0 |  |
| Oferta | tinyint(1) | NO |  | 0 |  |
| Privado | tinyint(1) | NO |  | 0 |  |
| ArticuloTipo | smallint(5) unsigned | NO |  | 0 |  |
| Nombre1 | varchar(60) | NO |  |  |  |
| Nombre2 | varchar(60) | NO |  |  |  |
| Nombre3 | varchar(60) | NO |  |  |  |
| Nombre4 | varchar(60) | NO |  |  |  |
| Nombre5 | varchar(60) | NO |  |  |  |
| Nombre6 | varchar(60) | NO |  |  |  |
| Nombre7 | varchar(60) | NO |  |  |  |
| Nombre8 | varchar(60) | NO |  |  |  |
| Nombre9 | varchar(60) | NO |  |  |  |
| PrecioDetalleGananciaPorcentaje | decimal(5,2) | NO |  | 0.00 |  |
| PrecioDomicilioGananciaPorcentaje | decimal(5,2) | NO |  | 0.00 |  |
| PrecioSocioGananciaPorcentaje | decimal(5,2) | NO |  | 0.00 |  |
| PrecioMayorGananciaPorcentaje | decimal(5,2) | NO |  | 0.00 |  |
| PrecioFacturaGananciaPorcentaje | decimal(5,2) | NO |  | 0.00 |  |
| PrecioInternetGananciaPorcentaje | decimal(5,2) | NO |  | 0.00 |  |
| PrecioAmigoGananciaPorcentaje | decimal(5,2) | NO |  | 0.00 |  |
| PrecioEspecialGananciaPorcentaje | decimal(5,2) | NO |  | 0.00 |  |
| PrecioOfertaGananciaPorcentaje | decimal(5,2) | NO |  | 0.00 |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| Observacion | varchar(2048) | YES |  | NULL |  |

### Tabla: `ivatipo`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| IVAID | smallint(5) unsigned | NO | PRI | 0 |  |
| Nombre | varchar(30) | NO |  |  |  |
| IVA | decimal(6,3) | NO |  | 0.000 |  |
| REQ | decimal(6,3) | NO |  | 0.000 |  |
| IVA1 | decimal(6,3) | NO |  | 0.000 |  |
| REQ1 | decimal(6,3) | NO |  | 0.000 |  |
| IVA2 | decimal(6,3) | NO |  | 0.000 |  |
| REQ2 | decimal(6,3) | NO |  | 0.000 |  |
| IVA3 | decimal(6,3) | NO |  | 0.000 |  |
| REQ3 | decimal(6,3) | NO |  | 0.000 |  |
| IVA4 | decimal(6,3) | NO |  | 0.000 |  |
| REQ4 | decimal(6,3) | NO |  | 0.000 |  |
| IVA5 | decimal(6,3) | NO |  | 0.000 |  |
| REQ5 | decimal(6,3) | NO |  | 0.000 |  |
| IVA6 | decimal(6,3) | NO |  | 0.000 |  |
| REQ6 | decimal(6,3) | NO |  | 0.000 |  |
| IVA7 | decimal(6,3) | NO |  | 0.000 |  |
| REQ7 | decimal(6,3) | NO |  | 0.000 |  |
| IVA8 | decimal(6,3) | NO |  | 0.000 |  |
| REQ8 | decimal(6,3) | NO |  | 0.000 |  |
| IVA9 | decimal(6,3) | NO |  | 0.000 |  |
| REQ9 | decimal(6,3) | NO |  | 0.000 |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| Observacion | varchar(2048) | YES |  | NULL |  |

### Tabla: `pagoforma`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| PagoFormaID | smallint(5) unsigned | NO | PRI | 0 |  |
| Nombre | varchar(30) | NO |  |  |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| Observacion | varchar(2048) | YES |  | NULL |  |

### Tabla: `cajon`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| CajonID | smallint(5) unsigned | NO | PRI | 0 |  |
| Nombre | varchar(60) | NO |  |  |  |
| Saldo | decimal(14,4) | NO |  | 0.0000 |  |
| SoloSaldo | tinyint(1) | NO |  | 0 |  |
| OrdenadorNombre | varchar(16) | NO |  |  |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| Observacion | varchar(2048) | YES |  | NULL |  |

### Tabla: `inventarioarticulo`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| DocumentoNo | bigint(18) unsigned | NO | MUL | 0 |  |
| ArticuloID | varchar(20) | NO |  |  |  |
| PropCount | smallint(5) unsigned | NO |  | 0 |  |
| PropID1 | varchar(4) | NO |  |  |  |
| PropID2 | varchar(4) | NO |  |  |  |
| Propiedad | varchar(160) | NO |  |  |  |
| SerialNo | varchar(4096) | NO |  |  |  |
| CodigoBarra | varchar(20) | NO |  |  |  |
| CodigoBarraBalanza | tinyint(1) | NO |  | 0 |  |
| NombreES | varchar(255) | NO |  |  |  |
| NombreCN | varchar(80) | NO |  |  |  |
| Precio | decimal(12,4) | NO |  | 0.0000 |  |
| Cantidad | decimal(12,4) | NO |  | 0.0000 |  |
| IVA | decimal(6,3) | NO |  | 0.000 |  |
| REQ | decimal(6,3) | NO |  | 0.000 |  |
| Descuento | decimal(5,2) | NO |  | 0.00 |  |
| DescuentoCambioProhibido | tinyint(1) | NO |  | 0 |  |
| PrecioCoste | decimal(12,4) | NO |  | 0.0000 |  |
| PrecioAgente | decimal(12,4) | NO |  | 0.0000 |  |
| Comentario | varchar(1024) | YES |  | NULL |  |
| NecesitaSerialNo | tinyint(1) | NO |  | 0 |  |
| Temporal | tinyint(1) | NO |  | 0 |  |
| OrdenNo | int(10) unsigned | NO |  | 0 |  |

### Tabla: `stockajuste`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| DocumentoNo | bigint(18) unsigned | NO | PRI | 0 |  |
| DocumentoNoEnServidor | bigint(18) unsigned | NO |  | 0 |  |
| DocumentoNoOriginal | bigint(18) unsigned | NO |  | 0 |  |
| AlmacenID | smallint(5) unsigned | NO |  | 1 |  |
| CantidadTotal | decimal(12,4) | NO |  | 0.0000 |  |
| PaqueteTotal | decimal(12,4) | NO |  | 0.0000 |  |
| CajaTotal | decimal(12,4) | NO |  | 0.0000 |  |
| VolumenPesoTotal | decimal(12,4) | NO |  | 0.0000 |  |
| LineaTotal | int(10) unsigned | NO |  | 0 |  |
| PrecioUsado | tinyint(2) unsigned | NO |  | 1 |  |
| Total | decimal(14,4) | NO |  | 0.0000 |  |
| Fecha | date | YES | MUL | NULL |  |
| FechaEntrada | datetime | NO |  | CURRENT_TIMESTAMP |  |
| FechaOriginal | datetime | YES |  | NULL |  |
| TiempoUltimoEditar | datetime | YES |  | NULL |  |
| TiempoUltimoActualizar | datetime | YES |  | NULL |  |
| TransportistaID | smallint(5) unsigned | NO |  | 0 |  |
| TransporteModoID | smallint(5) unsigned | NO |  | 0 |  |
| EnvioGasto | decimal(14,4) | NO |  | 0.0000 |  |
| OperadorID | smallint(5) unsigned | NO |  | 0 |  |
| VerificadorID | smallint(5) unsigned | NO |  | 0 |  |
| DocumentoAdjuntoSimbolo | varchar(60) | NO |  |  |  |
| OrdenadorNombre | varchar(16) | NO |  |  |  |
| SubTiendaID | varchar(16) | NO |  |  |  |
| DocumentoIntercambioNo | bigint(18) | NO |  | 0 |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| Modificando | tinyint(1) | NO |  | 0 |  |
| Observacion | varchar(2048) | YES |  | NULL |  |
| UpdateTimeStamp | timestamp | NO |  | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |

### Tabla: `stockajustearticulo`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| DocumentoNo | bigint(18) unsigned | NO | MUL | 0 |  |
| ArticuloID | varchar(20) | NO |  |  |  |
| PropCount | smallint(5) unsigned | NO |  | 0 |  |
| PropID1 | varchar(4) | NO |  |  |  |
| PropID2 | varchar(4) | NO |  |  |  |
| Propiedad | varchar(160) | NO |  |  |  |
| SerialNo | varchar(4096) | NO |  |  |  |
| CodigoBarra | varchar(20) | NO |  |  |  |
| CodigoBarraBalanza | tinyint(1) | NO |  | 0 |  |
| NombreES | varchar(255) | NO |  |  |  |
| NombreCN | varchar(80) | NO |  |  |  |
| Precio | decimal(12,4) | NO |  | 0.0000 |  |
| Cantidad | decimal(12,4) | NO |  | 0.0000 |  |
| IVA | decimal(6,3) | NO |  | 0.000 |  |
| REQ | decimal(6,3) | NO |  | 0.000 |  |
| Descuento | decimal(5,2) | NO |  | 0.00 |  |
| DescuentoCambioProhibido | tinyint(1) | NO |  | 0 |  |
| PrecioCoste | decimal(12,4) | NO |  | 0.0000 |  |
| PrecioAgente | decimal(12,4) | NO |  | 0.0000 |  |
| Comentario | varchar(1024) | YES |  | NULL |  |
| NecesitaSerialNo | tinyint(1) | NO |  | 0 |  |
| Temporal | tinyint(1) | NO |  | 0 |  |
| OrdenNo | int(10) unsigned | NO |  | 0 |  |

### Tabla: `stockentrada`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| DocumentoNo | bigint(18) unsigned | NO | PRI | 0 |  |
| DocumentoNoEnServidor | bigint(18) unsigned | NO |  | 0 |  |
| DocumentoNoOriginal | bigint(18) unsigned | NO |  | 0 |  |
| EmpresaID | bigint(12) unsigned | NO |  | 0 |  |
| SucursalID | smallint(5) unsigned | NO |  | 0 |  |
| Descuento | decimal(5,2) | NO |  | 0.00 |  |
| Descuento2 | decimal(5,2) | NO |  | 0.00 |  |
| DescuentoDirecto | decimal(10,4) | NO |  | 0.0000 |  |
| ReglaIVA | tinyint(2) unsigned | NO |  | 0 |  |
| IVASerie | tinyint(2) unsigned | NO |  | 0 |  |
| PrecioUsado | tinyint(2) unsigned | NO |  | 1 |  |
| Total | decimal(14,4) | NO |  | 0.0000 |  |
| DescuentoTotal | decimal(10,4) | NO |  | 0.0000 |  |
| DescuentoExtra | decimal(5,2) | NO |  | 0.00 |  |
| Ganancias | decimal(12,4) | NO |  | 0.0000 |  |
| CantidadTotal | decimal(12,4) | NO |  | 0.0000 |  |
| PaqueteTotal | decimal(12,4) | NO |  | 0.0000 |  |
| CajaTotal | decimal(12,4) | NO |  | 0.0000 |  |
| VolumenPesoTotal | decimal(12,4) | NO |  | 0.0000 |  |
| LineaTotal | int(10) unsigned | NO |  | 0 |  |
| Fecha | date | YES | MUL | NULL |  |
| FechaEntrada | datetime | NO |  | CURRENT_TIMESTAMP |  |
| FechaOriginal | datetime | YES |  | NULL |  |
| TiempoUltimoEditar | datetime | YES |  | NULL |  |
| TiempoUltimoActualizar | datetime | YES |  | NULL |  |
| DocumentoOrigenTipo | varchar(40) | NO |  |  |  |
| DocumentoOrigenNo | bigint(18) unsigned | NO |  | 0 |  |
| DocumentoDestinoTipo | varchar(40) | NO |  |  |  |
| DocumentoDestinoNo | bigint(18) unsigned | NO |  | 0 |  |
| AgenteID | smallint(5) unsigned | NO |  | 0 |  |
| TransportistaID | smallint(5) unsigned | NO |  | 0 |  |
| TransporteModoID | smallint(5) unsigned | NO |  | 0 |  |
| EnvioGasto | decimal(14,4) | NO |  | 0.0000 |  |
| OperadorID | smallint(5) unsigned | NO |  | 0 |  |
| VerificadorID | smallint(5) unsigned | NO |  | 0 |  |
| AlmacenID | smallint(5) unsigned | NO |  | 1 |  |
| DocumentoAdjuntoSimbolo | varchar(60) | NO |  |  |  |
| OrdenadorNombre | varchar(16) | NO |  |  |  |
| DeviceUUID | varchar(64) | NO |  |  |  |
| DocumentoHash | varchar(255) | NO |  |  |  |
| SubTiendaID | varchar(16) | NO |  |  |  |
| DocumentoIntercambioNo | bigint(18) | NO |  | 0 |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| Anulado | tinyint(1) | NO |  | 0 |  |
| Modificando | tinyint(1) | NO |  | 0 |  |
| EmailMandado | tinyint(1) | NO |  | 0 |  |
| ProgressID | tinyint(3) unsigned | NO |  | 0 |  |
| ProgressStatus | tinyint(3) unsigned | NO |  | 0 |  |
| LogID | bigint(20) unsigned | NO |  | 0 |  |
| HayAdjunto | tinyint(1) | NO |  | 0 |  |
| Imprimido | tinyint(1) | NO |  | 0 |  |
| Observacion | varchar(2048) | YES |  | NULL |  |
| UpdateTimeStamp | timestamp | NO |  | CURRENT_TIMESTAMP | on update CURRENT_TIMESTAMP |

### Tabla: `stockentradaarticulo`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| DocumentoNo | bigint(18) unsigned | NO | MUL | 0 |  |
| ArticuloID | varchar(20) | NO |  |  |  |
| PropCount | smallint(5) unsigned | NO |  | 0 |  |
| PropID1 | varchar(4) | NO |  |  |  |
| PropID2 | varchar(4) | NO |  |  |  |
| Propiedad | varchar(160) | NO |  |  |  |
| SerialNo | varchar(4096) | NO |  |  |  |
| CodigoBarra | varchar(20) | NO |  |  |  |
| CodigoBarraBalanza | tinyint(1) | NO |  | 0 |  |
| NombreES | varchar(255) | NO |  |  |  |
| NombreCN | varchar(80) | NO |  |  |  |
| Precio | decimal(12,4) | NO |  | 0.0000 |  |
| Cantidad | decimal(12,4) | NO |  | 0.0000 |  |
| IVA | decimal(6,3) | NO |  | 0.000 |  |
| REQ | decimal(6,3) | NO |  | 0.000 |  |
| Descuento | decimal(5,2) | NO |  | 0.00 |  |
| DescuentoCambioProhibido | tinyint(1) | NO |  | 0 |  |
| PrecioCoste | decimal(12,4) | NO |  | 0.0000 |  |
| PrecioAgente | decimal(12,4) | NO |  | 0.0000 |  |
| Comentario | varchar(1024) | YES |  | NULL |  |
| NecesitaSerialNo | tinyint(1) | NO |  | 0 |  |
| Temporal | tinyint(1) | NO |  | 0 |  |
| OrdenNo | int(10) unsigned | NO |  | 0 |  |

### Tabla: `ticketcobro`
| Field | Type | Null | Key | Default | Extra |
| --- | --- | --- | --- | --- | --- |
| DocumentoNo | bigint(18) unsigned | NO | MUL | 0 |  |
| Fecha | date | YES | MUL | NULL |  |
| FechaEntrada | datetime | NO |  | CURRENT_TIMESTAMP |  |
| CobrarTipo | tinyint(3) unsigned | NO |  | 0 |  |
| CobroDocNo | varchar(40) | NO |  |  |  |
| Importe | decimal(14,4) | NO |  | 0.0000 |  |
| Reembolso | decimal(14,4) | NO |  | 0.0000 |  |
| OperadorID | smallint(5) unsigned | NO |  | 0 |  |
| VerificadorID | smallint(5) unsigned | NO |  | 0 |  |
| OrdenadorNombre | varchar(16) | NO |  |  |  |
| Bloqueado | tinyint(1) | NO |  | 0 |  |
| DeviceUUID | varchar(64) | NO |  |  |  |
| ValorDevuelto | varchar(5120) | NO |  |  |  |
| Observacion | varchar(2048) | YES |  | NULL |  |

## 2. Todas las Tablas (Resumen de Esquema)

<details><summary>Esquema de abono</summary>

```
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
ClienteIVAClase	tinyint(2) unsigned	NO		0	
ClienteReglaIVA	tinyint(2) unsigned	NO		0	
UsarClienteReglaIVA	tinyint(1)	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
CobrarTipo	tinyint(3) unsigned	NO		0	
Efectivo	decimal(14,4)	NO		0.0000	
Ganancias	decimal(12,4)	NO		0.0000	
PagoTotal	decimal(14,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL		
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES			
TiempoUltimoEditar	datetime	YES			
TiempoUltimoActualizar	datetime	YES			
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
FacturaNo	bigint(18) unsigned	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
CocheNo	varchar(40)	NO			
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
Cobrado	tinyint(1)	NO		-1	
CobroTotal	decimal(14,4)	NO		0.0000	
AbonoTotal	decimal(14,4)	NO		0.0000	
CajonID	smallint(5) unsigned	NO		0	
DescuentoUsarRegla	smallint(5) unsigned	NO		0	
FormaDePago	enum('Efectivo','Tarjeta','Cheque','Transferencia','Pendiente','Vale','Cupon','Descuento','Otro','ValeSalida','DescuentoCliente','Multi')	NO		Efectivo	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES			
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

Para ahorrar espacio, se listan los esquemas de forma compacta.

<details><summary>Esquema de abonoarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de abonodiariolista</summary>

```
Field	Type	Null	Key	Default	Extra
Fecha	date	NO	PRI	NULL	
DiarioListaNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de abonoivatotal</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
Fecha	date	YES		NULL	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
BaseImponible	decimal(14,4)	NO		0.0000	
ImporteIVA	decimal(12,4)	NO		0.0000	
ImporteREQ	decimal(12,4)	NO		0.0000	
SubTotal	decimal(14,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de abonoproveedor</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
PagoTotal	decimal(14,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de abonoproveedorarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de abonoproveedorivatotal</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
Fecha	date	YES		NULL	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
BaseImponible	decimal(14,4)	NO		0.0000	
ImporteIVA	decimal(12,4)	NO		0.0000	
ImporteREQ	decimal(12,4)	NO		0.0000	
SubTotal	decimal(14,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de adjunto</summary>

```
Field	Type	Null	Key	Default	Extra
AdjuntoID	bigint(20) unsigned	NO	PRI	NULL	auto_increment
Tipo	smallint(5) unsigned	NO		0	
Titulo	varchar(80)	NO			
ObjetoTipo	varchar(40)	NO			
ObjetoID	varchar(40)	NO			
BinaryID	bigint(20) unsigned	NO	MUL	0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de adjuntotemp</summary>

```
Field	Type	Null	Key	Default	Extra
AdjuntoID	bigint(20) unsigned	NO	PRI	NULL	auto_increment
Tipo	smallint(5) unsigned	NO		0	
Titulo	varchar(80)	NO			
ObjetoTipo	varchar(40)	NO			
ObjetoID	varchar(40)	NO			
BinaryID	bigint(20) unsigned	NO	MUL	0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de agente</summary>

```
Field	Type	Null	Key	Default	Extra
AgenteID	smallint(5) unsigned	NO	PRI	0	
Nombre	varchar(60)	NO			
Contrasena	varchar(40)	NO		b59c67bf196a4758191e42f76670ceba	
Idioma	tinyint(3)	NO		0	
IdiomaSerie	tinyint(3)	NO		0	
ClaseID	smallint(5) unsigned	NO		1	
CIF	varchar(60)	NO			
Domicilio	varchar(120)	NO			
CodigoPostal	varchar(20)	NO			
Poblacion	varchar(60)	NO			
Provincia	varchar(60)	NO			
Telefono	varchar(40)	NO			
Telefono2	varchar(40)	NO			
Fax	varchar(40)	NO			
Email	varchar(60)	NO			
Web	varchar(60)	NO			
IM	varchar(40)	NO			
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de agenteclase</summary>

```
Field	Type	Null	Key	Default	Extra
ClaseID	smallint(5) unsigned	NO	PRI	1	
PadreID	smallint(5) unsigned	NO		0	
NombreES	varchar(60)	NO			
NombreCN	varchar(60)	NO			
Comision	decimal(5,2)	NO		0.00	
PoderesPrecioUsado	varchar(20)	NO			
TabletaPoderes	varchar(20)	NO			
AlmacenID	smallint(5) unsigned	NO		1	
PadreGrupo	varchar(1024)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de albaran</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
ClienteIVAClase	tinyint(2) unsigned	NO		0	
ClienteReglaIVA	tinyint(2) unsigned	NO		0	
UsarClienteReglaIVA	tinyint(1)	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
VeriFactuUUID	bigint(20) unsigned	NO		0	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
CobrarTipo	tinyint(3) unsigned	NO		0	
Efectivo	decimal(14,4)	NO		0.0000	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
CocheNo	varchar(40)	NO			
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
CajonID	smallint(5) unsigned	NO		0	
DescuentoUsarRegla	smallint(5) unsigned	NO		0	
FormaDePago	enum('Efectivo','Tarjeta','Cheque','Transferencia','Pendiente','Vale','Cupon','Descuento','Otro','ValeSalida','DescuentoCliente','Multi')	NO		Efectivo	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
PreFormaDePagoNo	int(10) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
AbonoTotal	decimal(14,4)	NO		0.0000	
CobroTotal	decimal(14,4)	NO		0.0000	
Cobrado	tinyint(1)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de albaranarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de albaranivatotal</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
Fecha	date	YES		NULL	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
BaseImponible	decimal(14,4)	NO		0.0000	
ImporteIVA	decimal(12,4)	NO		0.0000	
ImporteREQ	decimal(12,4)	NO		0.0000	
SubTotal	decimal(14,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de albaranproveedor</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
PagoTotal	decimal(14,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de albaranproveedorarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de almacen</summary>

```
Field	Type	Null	Key	Default	Extra
AlmacenID	smallint(5) unsigned	NO	PRI	0	
NombreES	varchar(30)	NO			
NombreCN	varchar(60)	NO			
SoloSubTienda	tinyint(1)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de almacencloud</summary>

```
Field	Type	Null	Key	Default	Extra
AlmacenID	smallint(5)	NO	PRI	0	
NombreES	varchar(30)	NO			
NombreCN	varchar(60)	NO			
SoloSubTienda	tinyint(1)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de almacenmovimiento</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
AlmacenOrigenID	smallint(5)	NO		1	
AlmacenDestinoID	smallint(5)	NO		1	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de almacenmovimientoarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de archivoconfiguracion</summary>

```
Field	Type	Null	Key	Default	Extra
NombreID	varchar(120)	NO	PRI		
Familia	varchar(60)	NO			
Nombre	varchar(60)	NO			
Configuracion	longtext	YES		NULL	
ContenidoMD5	varchar(40)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de articuloclase</summary>

```
Field	Type	Null	Key	Default	Extra
ClaseID	smallint(5) unsigned	NO	PRI	1	
PadreID	smallint(5) unsigned	NO		0	
NombreES	varchar(60)	NO			
NombreCN	varchar(60)	NO			
IVAID	smallint(5) unsigned	NO		1	
Descuento	decimal(5,2)	NO		0.00	
Descuento1	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
Descuento3	decimal(5,2)	NO		0.00	
Descuento4	decimal(5,2)	NO		0.00	
Descuento5	decimal(5,2)	NO		0.00	
Descuento6	decimal(5,2)	NO		0.00	
Descuento7	decimal(5,2)	NO		0.00	
Descuento8	decimal(5,2)	NO		0.00	
Descuento9	decimal(5,2)	NO		0.00	
TicketDescuentoUsarRegla	tinyint(3) unsigned	NO		0	
FacturaPorcentaje	decimal(5,2)	NO		100.00	
UnidadUsarRegla	smallint(5) unsigned	NO		0	
UnidadNombre	varchar(30)	NO			
ContarGanancias	tinyint(1)	NO		0	
ContarVolumenPeso	tinyint(1)	NO		0	
StockBloqueado	tinyint(1)	NO		0	
PadreGrupo	varchar(1024)	NO		0	
NecesitaSerialNo	tinyint(1)	NO		0	
DescuentoCambioProhibido	tinyint(1)	NO		0	
ClienteInvisible	tinyint(1)	NO		0	
Oferta	tinyint(1)	NO		0	
Privado	tinyint(1)	NO		0	
ArticuloTipo	smallint(5) unsigned	NO		0	
Nombre1	varchar(60)	NO			
Nombre2	varchar(60)	NO			
Nombre3	varchar(60)	NO			
Nombre4	varchar(60)	NO			
Nombre5	varchar(60)	NO			
Nombre6	varchar(60)	NO			
Nombre7	varchar(60)	NO			
Nombre8	varchar(60)	NO			
Nombre9	varchar(60)	NO			
PrecioDetalleGananciaPorcentaje	decimal(5,2)	NO		0.00	
PrecioDomicilioGananciaPorcentaje	decimal(5,2)	NO		0.00	
PrecioSocioGananciaPorcentaje	decimal(5,2)	NO		0.00	
PrecioMayorGananciaPorcentaje	decimal(5,2)	NO		0.00	
PrecioFacturaGananciaPorcentaje	decimal(5,2)	NO		0.00	
PrecioInternetGananciaPorcentaje	decimal(5,2)	NO		0.00	
PrecioAmigoGananciaPorcentaje	decimal(5,2)	NO		0.00	
PrecioEspecialGananciaPorcentaje	decimal(5,2)	NO		0.00	
PrecioOfertaGananciaPorcentaje	decimal(5,2)	NO		0.00	
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de articuloclaseorden</summary>

```
Field	Type	Null	Key	Default	Extra
ClaseID	smallint(5) unsigned	NO	PRI	1	
OrdenNo	int(10)	NO	UNI	NULL	auto_increment
```

</details>

<details><summary>Esquema de articulodibujo</summary>

```
Field	Type	Null	Key	Default	Extra
ArticuloID	varchar(20)	NO	PRI		
DibujoMD5	varchar(40)	NO	PRI		
DibujoID	bigint(20) unsigned	NO	MUL	0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de articuloeliminado</summary>

```
Field	Type	Null	Key	Default	Extra
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
Fecha	datetime	YES	MUL	NULL	
OperadorID	smallint(5) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
```

</details>

<details><summary>Esquema de articuloorden</summary>

```
Field	Type	Null	Key	Default	Extra
ArticuloID	varchar(20)	NO	PRI		
OrdenNo	bigint(20)	NO	UNI	NULL	auto_increment
```

</details>

<details><summary>Esquema de articuloprecioconsulta</summary>

```
Field	Type	Null	Key	Default	Extra
ArticuloID	varchar(20)	NO	PRI		
Vez	int(10) unsigned	NO		0	
Comentario	varchar(1024)	YES		NULL	
```

</details>

<details><summary>Esquema de articulopreciocoste</summary>

```
Field	Type	Null	Key	Default	Extra
ArticuloID	varchar(20)	NO	MUL		
PrecioCoste	decimal(12,4)	NO		0.0000	
Descuento	decimal(5,2)	NO		0.00	
PrecioFinal	decimal(12,4)	NO		0.0000	
DocumentoNo	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
Fecha	datetime	YES	MUL	NULL	
```

</details>

<details><summary>Esquema de articuloprop</summary>

```
Field	Type	Null	Key	Default	Extra
ArticuloID	varchar(20)	NO	PRI		
PropIndex	tinyint(4) unsigned	NO	PRI	0	
PropID	varchar(4)	NO	PRI		
Nombre	varchar(80)	NO			
Bloqueado	tinyint(1)	NO		0	
```

</details>

<details><summary>Esquema de articulotiempoultimousar</summary>

```
Field	Type	Null	Key	Default	Extra
ArticuloID	varchar(20)	NO	PRI		
PrecioPrivado	decimal(12,4)	NO		0.0000	
TiempoUltimoUsar	datetime	YES		NULL	
```

</details>

<details><summary>Esquema de bartender</summary>

```
Field	Type	Null	Key	Default	Extra
BarTenderID	smallint(5) unsigned	NO	PRI	0	
Title	varchar(80)	NO			
Family	smallint(5) unsigned	NO		0	
FormatFile	longtext	YES		NULL	
FormatMD5	varchar(40)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de binaryfile</summary>

```
Field	Type	Null	Key	Default	Extra
BinaryID	bigint(20) unsigned	NO	PRI	NULL	auto_increment
FileName	varchar(80)	NO			
FileExt	varchar(20)	NO			
FileMD5	varchar(40)	NO	MUL		
BinaryFile	longblob	YES		NULL	
Shared	tinyint(1)	NO		-1	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de cajon</summary>

```
Field	Type	Null	Key	Default	Extra
CajonID	smallint(5) unsigned	NO	PRI	0	
Nombre	varchar(60)	NO			
Saldo	decimal(14,4)	NO		0.0000	
SoloSaldo	tinyint(1)	NO		0	
OrdenadorNombre	varchar(16)	NO			
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de cajonimpexp</summary>

```
Field	Type	Null	Key	Default	Extra
CajonImpExpNo	int(10) unsigned	NO	PRI	0	
CajonID	smallint(5) unsigned	NO		0	
ImpExpEspecial	tinyint(1)	NO		0	
Fecha	datetime	YES		NULL	
Total	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de clienteclase</summary>

```
Field	Type	Null	Key	Default	Extra
ClaseID	smallint(5) unsigned	NO	PRI	1	
PadreID	smallint(5) unsigned	NO		0	
NombreES	varchar(60)	NO			
NombreCN	varchar(60)	NO			
IVAClase	tinyint(2) unsigned	NO		0	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2)	NO		-1	
FacturaPorcentaje	decimal(5,2)	NO		100.00	
FacturaDescuento	decimal(5,2)	NO		0.00	
NecesitaFactura	tinyint(1)	NO		0	
AutoEmailDocumento	tinyint(1)	NO		0	
Descuento	decimal(5,2)	NO		0.00	
DescuentoSerie	tinyint(3)	NO		0	
MaxSobregiro	decimal(18,4)	NO		0.0000	
SerSocio	tinyint(1)	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
ChinoProhibido	tinyint(1)	NO		0	
Extrajero	tinyint(1)	NO		0	
Idioma	tinyint(3)	NO		0	
IdiomaSerie	tinyint(3)	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		0	
ImprimirArticuloOrden	smallint(5) unsigned	NO		0	
Privado	tinyint(1)	NO		0	
ArticuloClaseInvisible	varchar(2048)	YES		NULL	
PadreGrupo	varchar(1024)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de clientediariototal</summary>

```
Field	Type	Null	Key	Default	Extra
Fecha	date	NO	PRI	NULL	
EmpresaID	bigint(12) unsigned	NO	MUL	0	
Vez	int(10) unsigned	NO		0	
Total	decimal(16,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de clienteextra</summary>

```
Field	Type	Null	Key	Default	Extra
EmpresaID	bigint(12) unsigned	NO	PRI	0	
TiempoUltimoUsar	datetime	YES		NULL	
ConsultaParcial	varchar(1024)	NO			
Signo	tinyint(1)	NO		-1	
TiempoSigno	datetime	YES		NULL	
VeriFactuActualizarEstado	tinyint(3)	NO		0	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
CreateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	
```

</details>

<details><summary>Esquema de clientelogin</summary>

```
Field	Type	Null	Key	Default	Extra
EmpresaID	bigint(12) unsigned	NO	PRI	0	
Nombre	varchar(18)	NO	PRI		
LoginID	int(10) unsigned	NO	UNI	NULL	auto_increment
Contrasena	varchar(40)	NO			
SucursalID	smallint(5) unsigned	NO		0	
Idioma	tinyint(3)	NO		0	
IdiomaSerie	tinyint(3)	NO		0	
Telefono	varchar(40)	NO			
Email	varchar(60)	NO			
Web	varchar(60)	NO			
IM	varchar(40)	NO			
LastLoginTime	datetime	YES		NULL	
LastLoginInfo	varchar(200)	NO			
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de clientesucursal</summary>

```
Field	Type	Null	Key	Default	Extra
EmpresaID	bigint(12) unsigned	NO	PRI	0	
SucursalID	smallint(5) unsigned	NO	PRI	0	
NombreES	varchar(60)	NO			
NombreCN	varchar(60)	NO			
Domicilio	varchar(120)	NO			
CodigoPostal	varchar(20)	NO			
Poblacion	varchar(60)	NO			
Provincia	varchar(60)	NO			
Pais	varchar(60)	NO			
CountryID	varchar(2)	NO			
PersonaContacto	varchar(60)	NO			
Telefono	varchar(40)	NO			
Telefono2	varchar(40)	NO			
Fax	varchar(40)	NO			
Email	varchar(60)	NO			
Web	varchar(60)	NO			
IM	varchar(40)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de cobro</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
DocumentoOriginalTipo	char(1)	NO			
DocumentoOriginalNo	bigint(18) unsigned	NO		0	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
EmpresaID	bigint(12) unsigned	NO		0	
Fecha	date	YES		NULL	
PagoFormaID	smallint(5) unsigned	NO		0	
Importe	decimal(14,4)	NO		0.0000	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
HayAdjunto	tinyint(1)	NO		0	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de codigobarrabalanza</summary>

```
Field	Type	Null	Key	Default	Extra
CodigoBarraBalanza	varchar(7)	NO	PRI		
NombreES	varchar(30)	NO			
NombreCN	varchar(24)	NO			
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
ClaseID	smallint(5) unsigned	NO		1	
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de consultatipo</summary>

```
Field	Type	Null	Key	Default	Extra
ConsultaTipoID	smallint(5) unsigned	NO	PRI	0	
Nombre	varchar(40)	NO			
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de cupon</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
Importe	decimal(14,4)	NO		0.0000	
Fecha	date	YES		NULL	
Localizador	varchar(16)	NO			
EmpresaID	bigint(12) unsigned	NO		0	
MiniImporte	decimal(14,4)	NO		0.0000	
FechaInicio	date	YES		NULL	
FechaCaducada	date	YES		NULL	
CreadorID	smallint(5) unsigned	NO		0	
TiempoCreado	datetime	YES		NULL	
TiendasCadenaIDCreado	smallint(5) unsigned	NO		0	
Usado	tinyint(1)	NO		0	
UsadorID	smallint(5) unsigned	NO		0	
TiempoUsado	datetime	YES		NULL	
TiendasCadenaIDUsado	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
DeviceUUID	varchar(64)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de currencyrate</summary>

```
Field	Type	Null	Key	Default	Extra
CurrencyRateID	smallint(6) unsigned	NO	PRI	0	
Nombre	varchar(30)	NO			
EUR	decimal(12,4)	NO		1.0000	
USD	decimal(12,4)	NO		1.0000	
CNY	decimal(12,4)	NO		1.0000	
```

</details>

<details><summary>Esquema de dbsql</summary>

```
Field	Type	Null	Key	Default	Extra
SQLID	int(10) unsigned	NO	PRI	0	
Nombre	varchar(255)	NO			
SQLContenido	varchar(2048)	NO			
DBVersion	decimal(8,2)	NO		0.00	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de device</summary>

```
Field	Type	Null	Key	Default	Extra
DeviceUUID	varchar(64)	NO	PRI		
ProgramID	varchar(32)	NO	PRI		
DeviceNo	int(10) unsigned	NO	MUL	NULL	auto_increment
ActiveType	tinyint(4)	NO		0	
ExpireDateValue	int(11) unsigned	NO		0	
SoftRegInfo	varchar(1024)	NO			
DeviceName	varchar(64)	NO			
DeviceAlias	varchar(64)	NO			
AlmacenID	smallint(5) unsigned	NO		1	
DBServer	tinyint(1)	NO		0	
DeviceIP	varchar(60)	NO			
AuthCode	varchar(60)	NO			
Actived	tinyint(1)	NO		0	
ActiveCode	varchar(1024)	NO			
SystemInfo	varchar(512)	YES		NULL	
Comments	varchar(1024)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de devolucion</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
CobrarTipo	tinyint(3) unsigned	NO		0	
Efectivo	decimal(14,4)	NO		0.0000	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
CobroTotal	decimal(14,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
CajonID	smallint(5) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
ClienteIVAClase	tinyint(2) unsigned	NO		0	
ClienteReglaIVA	tinyint(2) unsigned	NO		0	
UsarClienteReglaIVA	tinyint(1)	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
CocheNo	varchar(40)	NO			
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
PreFormaDePagoNo	int(10) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
AbonoTotal	decimal(14,4)	NO		0.0000	
Cobrado	tinyint(1)	NO		-1	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de devolucionarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de devolucionproveedor</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
PagoTotal	decimal(14,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de devolucionproveedorarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de dibujo</summary>

```
Field	Type	Null	Key	Default	Extra
DibujoID	bigint(20) unsigned	NO	PRI	NULL	auto_increment
Dibujo	longblob	YES		NULL	
```

</details>

<details><summary>Esquema de documentclouded</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO		0	
SubTiendaID	varchar(16)	NO	PRI		
DocumentoTipo	varchar(40)	NO	PRI		
DocumentoNoEnSubTienda	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
SubTiendaDB	tinyint(1)	NO		0	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de documentlog</summary>

```
Field	Type	Null	Key	Default	Extra
LogID	bigint(20) unsigned	NO	MUL	NULL	
SubLogID	bigint(20) unsigned	NO	PRI	NULL	auto_increment
LogTime	datetime	YES		NULL	
LogUser	varchar(80)	NO			
LogKey	varchar(80)	NO			
Content	longtext	YES		NULL	
```

</details>

<details><summary>Esquema de documentocobro</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoTipo	varchar(40)	NO	MUL		
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
CobrarTipo	tinyint(3) unsigned	NO		0	
CobroDocNo	varchar(40)	NO			
Importe	decimal(14,4)	NO		0.0000	
Reembolso	decimal(14,4)	NO		0.0000	
FormaDePago	enum('Efectivo','Tarjeta','Cheque','Transferencia','Pendiente','Vale','Cupon','Descuento','Otro','ValeSalida','DescuentoCliente','Multi')	NO		Efectivo	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
Bloqueado	tinyint(1)	NO		0	
DeviceUUID	varchar(64)	NO			
ValorDevuelto	varchar(5120)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de documentointercambio</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	NULL	auto_increment
SubTiendaID	varchar(16)	NO			
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
DBVersion	decimal(8,2)	NO		0.00	
DocCount	int(10) unsigned	NO		0	
DocLista	varchar(4096)	NO			
LineaTotal	bigint(20) unsigned	NO		0	
ContenidoXML	longtext	YES		NULL	
BinaryID	bigint(20) unsigned	NO		0	
ContenidoFilePath	varchar(255)	NO			
ContenidoMD5	varchar(40)	NO			
ZipFormato	enum('NONE','7Z','BZ2','ZIP')	NO		NONE	
Resultado	varchar(4096)	NO			
DeviceUUID	varchar(64)	NO			
```

</details>

<details><summary>Esquema de documentomensaje</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoTipo	varchar(40)	NO	MUL		
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ClienteLoginID	bigint(12)	NO		0	
OperadorID	smallint(5) unsigned	NO		0	
ProgressStatus	tinyint(3)	NO		0	
CreateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	
Observacion	varchar(2048)	YES			
```

</details>

<details><summary>Esquema de documentono</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoTipo	varchar(40)	NO	PRI		
ID	int(10) unsigned	NO	PRI	0	
No	bigint(18) unsigned	NO		0	
Especial	smallint(5) unsigned	NO		0	
```

</details>

<details><summary>Esquema de documentosincobrado</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoTipo	varchar(40)	NO	PRI		
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
Total	decimal(14,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
CobroTotal	decimal(14,4)	NO		0.0000	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
Bloqueado	tinyint(1)	NO		0	
DeviceUUID	varchar(64)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de documenttocloud</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoTipo	varchar(40)	NO	PRI		
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
LoteNo	bigint(20) unsigned	NO		0	
SubTiendaDB	tinyint(1)	NO		-1	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
DocumentoIntercambioNo	bigint(18)	NO		0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
```

</details>

<details><summary>Esquema de documenttosubtienda</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoTipo	varchar(40)	NO	PRI		
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
LoteNo	bigint(20) unsigned	NO		0	
SubTiendaID	varchar(16)	NO	PRI		
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
DocumentoNoEnSubTienda	bigint(18) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO	PRI	0	
```

</details>

<details><summary>Esquema de emailsent</summary>

```
Field	Type	Null	Key	Default	Extra
ID	bigint(20) unsigned	NO	PRI	NULL	auto_increment
DocCatalog	varchar(40)	NO	MUL		
DocID	varchar(40)	NO	MUL		
DocFormat	tinyint(2) unsigned	NO		0	
SenderCatalog	tinyint(2) unsigned	NO		0	
SenderID	bigint(12)	NO		0	
Sender	varchar(60)	NO			
EmailAddress	varchar(255)	NO			
CreateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	
Sent	tinyint(1)	NO		0	
Content	longtext	YES		NULL	
Comentario	varchar(1024)	YES		NULL	
```

</details>

<details><summary>Esquema de empaque</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
UsarFechaStock	tinyint(1)	NO		0	
FechaStock	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
FechaAlbaranProveedor	date	YES		NULL	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
CaseNumber	varchar(40)	NO			
ShipDate	date	YES		NULL	
ForecastDate	date	YES		NULL	
ActualDate	date	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de empaquearticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
CaseNumber	varchar(40)	NO			
PedidoProveedorNo	bigint(18) unsigned	NO		0	
PedidoProveedorOrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de empleadoclase</summary>

```
Field	Type	Null	Key	Default	Extra
ClaseID	smallint(5) unsigned	NO	PRI	1	
PadreID	smallint(5) unsigned	NO		0	
NombreES	varchar(60)	NO			
NombreCN	varchar(60)	NO			
PoderesLogin	varchar(60)	NO			
PoderesUsar	varchar(60)	NO			
PoderesCloud	varchar(60)	NO			
PadreGrupo	varchar(1024)	NO		0	
ReglaTicketPrecio	tinyint(2) unsigned	NO		0	
TicketPrecioUsado	tinyint(2) unsigned	NO		1	
PresupuestoPrecioUsado	tinyint(2) unsigned	NO		1	
PedidoPrecioUsado	tinyint(2) unsigned	NO		1	
AlbaranPrecioUsado	tinyint(2) unsigned	NO		1	
FacturaPrecioUsado	tinyint(2) unsigned	NO		1	
ExtraPrecioUsado	tinyint(2) unsigned	NO		1	
AbonoPrecioUsado	tinyint(2) unsigned	NO		1	
SoloSubTienda	tinyint(1)	NO		0	
SubTiendaLista	varchar(1024)	NO			
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de empleadotodo</summary>

```
Field	Type	Null	Key	Default	Extra
SubTiendaID	varchar(16)	NO	PRI		
EmpleadoID	smallint(5) unsigned	NO	PRI	0	
Nombre	varchar(18)	NO			
```

</details>

<details><summary>Esquema de etiqueta</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de etiquetaarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de extra</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
ClienteIVAClase	tinyint(2) unsigned	NO		0	
ClienteReglaIVA	tinyint(2) unsigned	NO		0	
UsarClienteReglaIVA	tinyint(1)	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
CobrarTipo	tinyint(3) unsigned	NO		0	
Efectivo	decimal(14,4)	NO		0.0000	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
CocheNo	varchar(40)	NO			
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
Cobrado	tinyint(1)	NO		-1	
CobroTotal	decimal(14,4)	NO		0.0000	
AbonoTotal	decimal(14,4)	NO		0.0000	
CajonID	smallint(5) unsigned	NO		0	
DescuentoUsarRegla	smallint(5) unsigned	NO		0	
FormaDePago	enum('Efectivo','Tarjeta','Cheque','Transferencia','Pendiente','Vale','Cupon','Descuento','Otro','ValeSalida','DescuentoCliente','Multi')	NO		Efectivo	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
PreFormaDePagoNo	int(10) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de extraarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de extradiariolista</summary>

```
Field	Type	Null	Key	Default	Extra
Fecha	date	NO	PRI	NULL	
DiarioListaNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de extraivatotal</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
Fecha	date	YES		NULL	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
BaseImponible	decimal(14,4)	NO		0.0000	
ImporteIVA	decimal(12,4)	NO		0.0000	
ImporteREQ	decimal(12,4)	NO		0.0000	
SubTotal	decimal(14,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de facturaarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de facturadiariolista</summary>

```
Field	Type	Null	Key	Default	Extra
Fecha	date	NO	PRI	NULL	
DiarioListaNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de facturaivatotal</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
Fecha	date	YES		NULL	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
BaseImponible	decimal(14,4)	NO		0.0000	
ImporteIVA	decimal(12,4)	NO		0.0000	
ImporteREQ	decimal(12,4)	NO		0.0000	
SubTotal	decimal(14,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de facturaproveedor</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
PagoTotal	decimal(14,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de facturaproveedorarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de facturaproveedorivatotal</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
Fecha	date	YES		NULL	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
BaseImponible	decimal(14,4)	NO		0.0000	
ImporteIVA	decimal(12,4)	NO		0.0000	
ImporteREQ	decimal(12,4)	NO		0.0000	
SubTotal	decimal(14,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de gananciacambio</summary>

```
Field	Type	Null	Key	Default	Extra
Fecha	date	YES		NULL	
Total	decimal(16,4)	NO		0.0000	
CuentaTipo	enum('Ticket','Albaran')	YES		Ticket	
```

</details>

<details><summary>Esquema de gananciadiariototal</summary>

```
Field	Type	Null	Key	Default	Extra
Fecha	date	NO	PRI	NULL	
Ticket	decimal(16,4)	NO		0.0000	
TicketGanancia	decimal(16,4)	NO		0.0000	
Albaran	decimal(16,4)	NO		0.0000	
AlbaranGanancia	decimal(16,4)	NO		0.0000	
Devolucion	decimal(16,4)	NO		0.0000	
DevolucionGanancia	decimal(16,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de impresoraservidor</summary>

```
Field	Type	Null	Key	Default	Extra
ID	varchar(180)	NO	PRI		
PapelTipo	smallint(6) unsigned	NO		0	
```

</details>

<details><summary>Esquema de informeespecial</summary>

```
Field	Type	Null	Key	Default	Extra
ID	varchar(10)	NO	PRI		
Nombre	varchar(80)	NO	UNI		
Familia	varchar(60)	NO			
PaisID	smallint(5) unsigned	NO		0	
InformeRPT	longtext	YES		NULL	
ContenidoMD5	varchar(40)	NO			
Tipo	smallint(5) unsigned	NO		0	
InformeProcesadorID	varchar(20)	NO			
InformeVersion	varchar(20)	NO			
Extra	tinyint(1)	NO		0	
TiempoActualizado	varchar(20)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de inventarioarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de inventariodoc</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoTipo	varchar(40)	NO	PRI		
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
InventarioID	bigint(20) unsigned	NO	MUL	NULL	auto_increment
Total	decimal(14,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
LineaTotal	bigint(20) unsigned	NO		0	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
```

</details>

<details><summary>Esquema de inventariodocstock</summary>

```
Field	Type	Null	Key	Default	Extra
InventarioID	bigint(20) unsigned	NO	MUL	0	
ID	bigint(20) unsigned	NO	PRI	NULL	auto_increment
ArticuloID	varchar(20)	NO			
CodigoBarra	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
Descuento	decimal(5,2)	NO		0.00	
PrecioCoste	decimal(12,4)	NO		0.0000	
CantidadPorUnidad	decimal(12,4)	NO		1.0000	
CantidadPorUnidad2	decimal(12,4)	NO		1.0000	
SitioEnAlmacen	varchar(60)	NO			
SitioEnEstante	varchar(60)	NO			
ClaseID	smallint(5) unsigned	NO		1	
EmpresaID	bigint(12) unsigned	NO		0	
DibujoID	bigint(20) unsigned	NO		0	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
EmpleadoID	smallint(5) unsigned	NO		0	
Lote	bigint(20) unsigned	NO		0	
Stock	tinyint(1)	NO		0	
```

</details>

<details><summary>Esquema de ivatipo</summary>

```
Field	Type	Null	Key	Default	Extra
IVAID	smallint(5) unsigned	NO	PRI	0	
Nombre	varchar(30)	NO			
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
IVA1	decimal(6,3)	NO		0.000	
REQ1	decimal(6,3)	NO		0.000	
IVA2	decimal(6,3)	NO		0.000	
REQ2	decimal(6,3)	NO		0.000	
IVA3	decimal(6,3)	NO		0.000	
REQ3	decimal(6,3)	NO		0.000	
IVA4	decimal(6,3)	NO		0.000	
REQ4	decimal(6,3)	NO		0.000	
IVA5	decimal(6,3)	NO		0.000	
REQ5	decimal(6,3)	NO		0.000	
IVA6	decimal(6,3)	NO		0.000	
REQ6	decimal(6,3)	NO		0.000	
IVA7	decimal(6,3)	NO		0.000	
REQ7	decimal(6,3)	NO		0.000	
IVA8	decimal(6,3)	NO		0.000	
REQ8	decimal(6,3)	NO		0.000	
IVA9	decimal(6,3)	NO		0.000	
REQ9	decimal(6,3)	NO		0.000	
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de labeltemplate</summary>

```
Field	Type	Null	Key	Default	Extra
ID	smallint(5) unsigned	NO	PRI	NULL	auto_increment
Title	varchar(80)	NO			
Family	tinyint(3) unsigned	NO		0	
CommandSet	tinyint(3) unsigned	NO		0	
TemplateSQL	varchar(2048)	NO			
TemplateMD5	varchar(40)	NO			
LabelTemplate	mediumtext	YES		NULL	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de log</summary>

```
Field	Type	Null	Key	Default	Extra
LogID	bigint(20) unsigned	NO	PRI	NULL	auto_increment
LogTime	datetime	YES	MUL	NULL	
ProgramName	varchar(80)	NO			
DBVersion	decimal(8,2)	NO		0.00	
UserID	smallint(5) unsigned	NO		0	
LogType	varchar(40)	NO			
DeviceIP	varchar(60)	NO			
Content	longtext	YES		NULL	
```

</details>

<details><summary>Esquema de opcion</summary>

```
Field	Type	Null	Key	Default	Extra
ID	varchar(80)	NO	PRI		
IntegerValor	bigint(20)	YES		NULL	
DecimalValor	decimal(16,4)	YES		NULL	
VarCharValor	varchar(1024)	YES		NULL	
TextValor	longtext	YES		NULL	
DateTimeValor	datetime	YES		NULL	
Publico	tinyint(1)	NO		0	
```

</details>

<details><summary>Esquema de ordenadorejecutando</summary>

```
Field	Type	Null	Key	Default	Extra
MySQLID	bigint(4)	NO	PRI	0	
ProgramaID	enum('BohaoMarket','BohaoMarketMan','BohaoMarketPriAdv','BohaoMarketPDA')	NO		BohaoMarket	
MysqlIDUser	varchar(160)	NO			
DeviceUUID	varchar(64)	NO			
OrdenadorNombre	varchar(16)	NO			
EmpleadoNombre	varchar(18)	NO			
LoginTiempo	datetime	YES		NULL	
EmpresaIDPorDescuento	bigint(12) unsigned	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de otrosincobrado</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
Fecha	date	YES		NULL	
Total	decimal(14,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
CobroTotal	decimal(14,4)	NO		0.0000	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de otrosinpagado</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
Fecha	date	YES		NULL	
Total	decimal(14,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
PagoTotal	decimal(14,4)	NO		0.0000	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de pagoforma</summary>

```
Field	Type	Null	Key	Default	Extra
PagoFormaID	smallint(5) unsigned	NO	PRI	0	
Nombre	varchar(30)	NO			
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de pedido</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
ClienteIVAClase	tinyint(2) unsigned	NO		0	
ClienteReglaIVA	tinyint(2) unsigned	NO		0	
UsarClienteReglaIVA	tinyint(1)	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
UsarFechaStock	tinyint(1)	NO		0	
FechaStock	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
FechaAlbaran	date	YES		NULL	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de pedidoarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de pedidocliente</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
ClienteIVAClase	tinyint(2) unsigned	NO		0	
ClienteReglaIVA	tinyint(2) unsigned	NO		0	
UsarClienteReglaIVA	tinyint(1)	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
UsarFechaStock	tinyint(1)	NO		0	
FechaStock	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
FechaAlbaran	date	YES		NULL	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
ClienteLoginID	bigint(12)	NO		0	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
PdfIP	varchar(60)	NO			
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de pedidoclientearticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de pedidoclienteivatotal</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
Fecha	date	YES		NULL	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
BaseImponible	decimal(14,4)	NO		0.0000	
ImporteIVA	decimal(12,4)	NO		0.0000	
ImporteREQ	decimal(12,4)	NO		0.0000	
SubTotal	decimal(14,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de pedidoproveedor</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
UsarFechaStock	tinyint(1)	NO		0	
FechaStock	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
FechaAlbaranProveedor	date	YES		NULL	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de pedidoproveedorarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
EmpaqueCantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de pedidotableta</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
ClienteIVAClase	tinyint(2) unsigned	NO		0	
ClienteReglaIVA	tinyint(2) unsigned	NO		0	
UsarClienteReglaIVA	tinyint(1)	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
UsarFechaStock	tinyint(1)	NO		0	
FechaStock	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
FechaAlbaran	date	YES		NULL	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de pedidotabletaarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de pedidotemp</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
ClienteIVAClase	tinyint(2) unsigned	NO		0	
ClienteReglaIVA	tinyint(2) unsigned	NO		0	
UsarClienteReglaIVA	tinyint(1)	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
UsarFechaStock	tinyint(1)	NO		0	
FechaStock	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
FechaAlbaran	date	YES		NULL	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
ClienteLoginID	bigint(12)	NO		0	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de pedidotemparticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de pos5a</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
VeriFactuUUID	bigint(20) unsigned	NO		0	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
CobrarTipo	tinyint(3) unsigned	NO		0	
Efectivo	decimal(14,4)	NO		0.0000	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
DescuentoUsarRegla	smallint(5) unsigned	NO		0	
Ganancias	decimal(12,4)	NO		0.0000	
CobroTotal	decimal(14,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
CajonID	smallint(5) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
ClienteIVAClase	tinyint(2) unsigned	NO		0	
ClienteReglaIVA	tinyint(2) unsigned	NO		0	
UsarClienteReglaIVA	tinyint(1)	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
CocheNo	varchar(40)	NO			
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
PreFormaDePagoNo	int(10) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
AbonoTotal	decimal(14,4)	NO		0.0000	
Cobrado	tinyint(1)	NO		-1	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de pos5aarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de pos5acobro</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
CobrarTipo	tinyint(3) unsigned	NO		0	
CobroDocNo	varchar(40)	NO			
Importe	decimal(14,4)	NO		0.0000	
Reembolso	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
Bloqueado	tinyint(1)	NO		0	
DeviceUUID	varchar(64)	NO			
ValorDevuelto	varchar(5120)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de pos5aivatotal</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
Fecha	date	YES		NULL	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
BaseImponible	decimal(14,4)	NO		0.0000	
ImporteIVA	decimal(12,4)	NO		0.0000	
ImporteREQ	decimal(12,4)	NO		0.0000	
SubTotal	decimal(14,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de pos5asincobrado</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
Total	decimal(14,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
CobroTotal	decimal(14,4)	NO		0.0000	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
Bloqueado	tinyint(1)	NO		0	
DeviceUUID	varchar(64)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de preformadepago</summary>

```
Field	Type	Null	Key	Default	Extra
PreFormaDePagoNo	int(10) unsigned	NO	PRI	0	
CobrarTipo	tinyint(3) unsigned	NO		0	
FormaDePago	varchar(250)	NO			
ClienteBancoInfoIncluido	tinyint(1)	NO		0	
Vencimientos	date	YES		NULL	
Total	decimal(14,4)	NO		0.0000	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de presupuesto</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
ClienteIVAClase	tinyint(2) unsigned	NO		0	
ClienteReglaIVA	tinyint(2) unsigned	NO		0	
UsarClienteReglaIVA	tinyint(1)	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
UsarFechaStock	tinyint(1)	NO		0	
FechaStock	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
FechaAlbaran	date	YES		NULL	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de presupuestoarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de presupuestoproveedor</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
UsarFechaStock	tinyint(1)	NO		0	
FechaStock	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
FechaAlbaranProveedor	date	YES		NULL	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de presupuestoproveedorarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de proforma</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
ClienteIVAClase	tinyint(2) unsigned	NO		0	
ClienteReglaIVA	tinyint(2) unsigned	NO		0	
UsarClienteReglaIVA	tinyint(1)	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
CobrarTipo	tinyint(3) unsigned	NO		0	
Efectivo	decimal(14,4)	NO		0.0000	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
CocheNo	varchar(40)	NO			
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
Cobrado	tinyint(1)	NO		-1	
CobroTotal	decimal(14,4)	NO		0.0000	
AbonoTotal	decimal(14,4)	NO		0.0000	
CajonID	smallint(5) unsigned	NO		0	
DescuentoUsarRegla	smallint(5) unsigned	NO		0	
FormaDePago	enum('Efectivo','Tarjeta','Cheque','Transferencia','Pendiente','Vale','Cupon','Descuento','Otro','ValeSalida','DescuentoCliente','Multi')	NO		Efectivo	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
PreFormaDePagoNo	int(10) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de proformaarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de prop</summary>

```
Field	Type	Null	Key	Default	Extra
PropID	smallint(5) unsigned	NO	PRI	0	
Nombre	varchar(80)	NO			
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de propdeta</summary>

```
Field	Type	Null	Key	Default	Extra
PropID	smallint(5) unsigned	NO	PRI	0	
PropDetaID	varchar(4)	NO	PRI		
Nombre	varchar(80)	NO			
Bloqueado	tinyint(1)	NO		0	
```

</details>

<details><summary>Esquema de proveedorclase</summary>

```
Field	Type	Null	Key	Default	Extra
ClaseID	smallint(5) unsigned	NO	PRI	1	
PadreID	smallint(5) unsigned	NO		0	
NombreES	varchar(60)	NO			
NombreCN	varchar(60)	NO			
IVAClase	tinyint(2) unsigned	NO		0	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2)	NO		-1	
FacturaPorcentaje	decimal(5,2)	NO		100.00	
FacturaDescuento	decimal(5,2)	NO		0.00	
NecesitaFactura	tinyint(1)	NO		0	
AutoEmailDocumento	tinyint(1)	NO		0	
Descuento	decimal(5,2)	NO		0.00	
MaxSobregiro	decimal(18,4)	NO		0.0000	
SerSocio	tinyint(1)	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
ChinoProhibido	tinyint(1)	NO		0	
Extrajero	tinyint(1)	NO		0	
Idioma	tinyint(3)	NO		0	
IdiomaSerie	tinyint(3)	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		0	
ImprimirArticuloOrden	smallint(5) unsigned	NO		0	
Privado	tinyint(1)	NO		0	
PadreGrupo	varchar(1024)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de proveedordiariototal</summary>

```
Field	Type	Null	Key	Default	Extra
Fecha	date	NO	PRI	NULL	
EmpresaID	bigint(12) unsigned	NO	MUL	0	
Vez	int(10) unsigned	NO		0	
Total	decimal(16,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de proveedorextra</summary>

```
Field	Type	Null	Key	Default	Extra
EmpresaID	bigint(12) unsigned	NO	PRI	0	
TiempoUltimoUsar	datetime	YES		NULL	
ConsultaParcial	varchar(1024)	NO			
Signo	tinyint(1)	NO		-1	
TiempoSigno	datetime	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
CreateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	
```

</details>

<details><summary>Esquema de proveedorlogin</summary>

```
Field	Type	Null	Key	Default	Extra
EmpresaID	bigint(12) unsigned	NO	PRI	0	
Nombre	varchar(18)	NO	PRI		
LoginID	int(10) unsigned	NO	UNI	NULL	auto_increment
Contrasena	varchar(40)	NO			
SucursalID	smallint(5) unsigned	NO		0	
Idioma	tinyint(3)	NO		0	
IdiomaSerie	tinyint(3)	NO		0	
Telefono	varchar(40)	NO			
Email	varchar(60)	NO			
Web	varchar(60)	NO			
IM	varchar(40)	NO			
LastLoginTime	datetime	YES		NULL	
LastLoginInfo	varchar(200)	NO			
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de proveedorsucursal</summary>

```
Field	Type	Null	Key	Default	Extra
EmpresaID	bigint(12) unsigned	NO	PRI	0	
SucursalID	smallint(5) unsigned	NO	PRI	0	
NombreES	varchar(60)	NO			
NombreCN	varchar(60)	NO			
Domicilio	varchar(120)	NO			
CodigoPostal	varchar(20)	NO			
Poblacion	varchar(60)	NO			
Provincia	varchar(60)	NO			
Pais	varchar(60)	NO			
CountryID	varchar(2)	NO			
PersonaContacto	varchar(60)	NO			
Telefono	varchar(40)	NO			
Telefono2	varchar(40)	NO			
Fax	varchar(40)	NO			
Email	varchar(60)	NO			
Web	varchar(60)	NO			
IM	varchar(40)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de punto</summary>

```
Field	Type	Null	Key	Default	Extra
EmpresaID	bigint(12) unsigned	NO	PRI	0	
FechaInicio	date	YES		NULL	
Total	decimal(16,4)	NO		0.0000	
Vez	int(10) unsigned	NO		0	
Saldo	decimal(16,4)	NO		0.0000	
Descuento	decimal(16,4)	NO		0.0000	
Cupon	decimal(16,4)	NO		0.0000	
Vale	decimal(16,4)	NO		0.0000	
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
ServidorActualizar	tinyint(1)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de puntoentrada</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	NULL	auto_increment
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
Total	decimal(16,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
ServidorActualizar	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de puntosalida</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	NULL	auto_increment
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
Total	decimal(16,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
ServidorActualizar	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de redsysdevolucion</summary>

```
Field	Type	Null	Key	Default	Extra
ID	bigint(20) unsigned	NO	PRI	NULL	auto_increment
DocumentoNo	bigint(20) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
Importe	decimal(14,4)	NO		0.0000	
EmpleadoID	smallint(5) unsigned	NO		0	
RtsOriginal	varchar(60)	NO			
ValorDevuelto	varchar(5120)	NO			
Observacion	varchar(5120)	NO			
```

</details>

<details><summary>Esquema de reglacupon</summary>

```
Field	Type	Null	Key	Default	Extra
ID	smallint(5) unsigned	NO	PRI	0	
Nombre	varchar(80)	NO			
Importe	decimal(14,4)	NO		0.0000	
MiniImporte	decimal(14,4)	NO		0.0000	
FechaInicio	date	YES		NULL	
FechaCaducada	date	YES		NULL	
Activado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de report</summary>

```
Field	Type	Null	Key	Default	Extra
ReportID	int(10) unsigned	NO	PRI	NULL	auto_increment
Title	varchar(80)	NO			
Family	smallint(5) unsigned	NO		0	
Parameter	varchar(512)	NO			
ReportMD5	varchar(40)	NO	MUL		
ReportFile	longtext	YES		NULL	
DBVersion	decimal(8,2)	NO		0.00	
Country	smallint(5)	NO		0	
Comments	varchar(1024)	YES		NULL	
```

</details>

<details><summary>Esquema de server_setting</summary>

```
Field	Type	Null	Key	Default	Extra
id	int(11)	NO	PRI	NULL	auto_increment
setting_key	varchar(50)	NO	UNI	NULL	
setting_value	varchar(255)	NO		NULL	
show_value	varchar(255)	NO		NULL	
description	varchar(2048)	NO		NULL	
```

</details>

<details><summary>Esquema de stockajuste</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de stockajustearticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de stockcambio</summary>

```
Field	Type	Null	Key	Default	Extra
AlmacenID	smallint(5) unsigned	NO		1	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Cantidad	decimal(12,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de stockcambiocloud</summary>

```
Field	Type	Null	Key	Default	Extra
AlmacenID	smallint(5) unsigned	NO		1	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Cantidad	decimal(12,4)	NO		0.0000	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	
```

</details>

<details><summary>Esquema de stockentrada</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de stockentradaarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de stockextra</summary>

```
Field	Type	Null	Key	Default	Extra
AlmacenID	smallint(5) unsigned	NO	PRI	1	
ArticuloID	varchar(20)	NO	PRI		
Stock	decimal(18,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de stockextracambio</summary>

```
Field	Type	Null	Key	Default	Extra
AlmacenID	smallint(5) unsigned	NO		1	
ArticuloID	varchar(20)	NO			
Cantidad	decimal(12,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de stocksalida</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de stocksalidaarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de subtienda</summary>

```
Field	Type	Null	Key	Default	Extra
SubTiendaID	varchar(16)	NO	PRI		
NombreES	varchar(60)	NO			
NombreCN	varchar(60)	NO			
CIF	varchar(60)	NO			
NumeroIVA	varchar(30)	NO			
Domicilio	varchar(120)	NO			
CodigoPostal	varchar(20)	NO			
Poblacion	varchar(60)	NO			
Provincia	varchar(60)	NO			
Pais	varchar(60)	NO			
CountryID	varchar(2)	NO			
PersonaContacto	varchar(60)	NO			
Telefono	varchar(40)	NO			
Telefono2	varchar(40)	NO			
Fax	varchar(40)	NO			
Email	varchar(60)	NO			
Web	varchar(60)	NO			
IM	varchar(40)	NO			
DeviceUUID	varchar(64)	NO			
DBBasicSync	enum('FromCloudNoClient','FromCloud','ToCloudNoClient','ToCloud','None')	NO		FromCloudNoClient	
AlmacenID	smallint(5) unsigned	NO		1	
AlmacenMovimiento	enum('None','Related','All')	NO		None	
StockUpdate	enum('None','Cloud2Sub','Sub2Cloud','All')	NO		None	
ImportGoodsPic	tinyint(1)	NO		0	
RegID	int(10) unsigned	NO		0	
Users	smallint(5) unsigned	NO		0	
Actived	tinyint(1)	NO		0	
AuthCode	varchar(60)	NO			
DBName	varchar(60)	NO			
SystemInfo	varchar(512)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de tablapropiedad</summary>

```
Field	Type	Null	Key	Default	Extra
TablaNombre	varchar(100)	NO	PRI		
Basico	tinyint(1)	NO		0	
Publico	tinyint(1)	NO		0	
Mysql2Sqlite	tinyint(1)	NO		0	
Client2Cloud	tinyint(1)	NO		0	
Local4Cloud	tinyint(1)	NO		0	
ContenidoMD5	varchar(40)	NO			
TiempoActualizar	datetime	YES		NULL	
```

</details>

<details><summary>Esquema de tempvalue</summary>

```
Field	Type	Null	Key	Default	Extra
ID	varchar(80)	NO	PRI		
IntegerValue	bigint(20)	YES		NULL	
DecimalValue	decimal(16,4)	YES		NULL	
VarCharValue	varchar(100)	YES		NULL	
TextValue	longtext	YES		NULL	
DateTimeValue	datetime	YES		NULL	
```

</details>

<details><summary>Esquema de ticketcambio</summary>

```
Field	Type	Null	Key	Default	Extra
Fecha	date	YES		NULL	
Total	decimal(16,4)	NO		0.0000	
CobrarTipo	tinyint(3) unsigned	NO		0	
```

</details>

<details><summary>Esquema de ticketcobro</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
CobrarTipo	tinyint(3) unsigned	NO		0	
CobroDocNo	varchar(40)	NO			
Importe	decimal(14,4)	NO		0.0000	
Reembolso	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
Bloqueado	tinyint(1)	NO		0	
DeviceUUID	varchar(64)	NO			
ValorDevuelto	varchar(5120)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de ticketcolgando</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	NULL	auto_increment
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoTipoOriginal	varchar(40)	NO			
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
CobrarTipo	tinyint(3) unsigned	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
ClienteNombre	varchar(255)	NO			
CobroIntentado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
OperadorID	smallint(5) unsigned	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
CocheNo	varchar(40)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
ColgarNota	varchar(60)	NO			
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de ticketcolgandoarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de ticketdiariototal</summary>

```
Field	Type	Null	Key	Default	Extra
Fecha	date	NO	PRI	NULL	
Total	decimal(16,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Efectivo	decimal(16,4)	NO		0.0000	
Tarjeta	decimal(16,4)	NO		0.0000	
Cheque	decimal(16,4)	NO		0.0000	
Transferencia	decimal(16,4)	NO		0.0000	
Vale	decimal(16,4)	NO		0.0000	
Descuento	decimal(16,4)	NO		0.0000	
ValeSalida	decimal(16,4)	NO		0.0000	
DescuentoCliente	decimal(16,4)	NO		0.0000	
Otro	decimal(16,4)	NO		0.0000	
Pendiente	decimal(16,4)	NO		0.0000	
GenTiendasCadenaDatos	tinyint(1)	NO		0	
```

</details>

<details><summary>Esquema de ticketextra</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
ClienteIVAClase	tinyint(2) unsigned	NO		0	
ClienteReglaIVA	tinyint(2) unsigned	NO		0	
UsarClienteReglaIVA	tinyint(1)	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
CobrarTipo	tinyint(3) unsigned	NO		0	
Efectivo	decimal(14,4)	NO		0.0000	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
CocheNo	varchar(40)	NO			
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
PreFormaDePagoNo	int(10) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de ticketextraarticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de ticketextradiariolista</summary>

```
Field	Type	Null	Key	Default	Extra
Fecha	date	NO	PRI	NULL	
DiarioListaNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de ticketextraivatotal</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
Fecha	date	YES		NULL	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
BaseImponible	decimal(14,4)	NO		0.0000	
ImporteIVA	decimal(12,4)	NO		0.0000	
ImporteREQ	decimal(12,4)	NO		0.0000	
SubTotal	decimal(14,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de ticketivatotal</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
Fecha	date	YES		NULL	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
BaseImponible	decimal(14,4)	NO		0.0000	
ImporteIVA	decimal(12,4)	NO		0.0000	
ImporteREQ	decimal(12,4)	NO		0.0000	
SubTotal	decimal(14,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de ticketoferta</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
Fecha	date	YES	MUL	NULL	
Total	decimal(14,4)	NO		0.0000	
Punto	decimal(14,4)	NO		0.0000	
Descuento	decimal(14,4)	NO		0.0000	
DescuentoCliente	decimal(14,4)	NO		0.0000	
Cupon	decimal(14,4)	NO		0.0000	
CuponNo	bigint(18) unsigned	NO		0	
Vale	decimal(14,4)	NO		0.0000	
ValeNo	bigint(18) unsigned	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de ticketsincobrado</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
Total	decimal(14,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
CobroTotal	decimal(14,4)	NO		0.0000	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
Bloqueado	tinyint(1)	NO		0	
DeviceUUID	varchar(64)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de transporte</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
Ganancias	decimal(12,4)	NO		0.0000	
PagoTotal	decimal(14,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de transportearticulo</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	MUL	0	
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de transportemodo</summary>

```
Field	Type	Null	Key	Default	Extra
TransporteModoID	smallint(5) unsigned	NO	PRI	0	
Nombre	varchar(60)	NO			
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de transportista</summary>

```
Field	Type	Null	Key	Default	Extra
TransportistaID	smallint(5) unsigned	NO	PRI	0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
Nombre	varchar(60)	NO			
CIF	varchar(60)	NO			
Domicilio	varchar(120)	NO			
CodigoPostal	varchar(20)	NO			
Poblacion	varchar(60)	NO			
Provincia	varchar(60)	NO			
Telefono	varchar(20)	NO			
Telefono2	varchar(20)	NO			
Fax	varchar(20)	NO			
Email	varchar(60)	NO			
Web	varchar(60)	NO			
IM	varchar(40)	NO			
CocheNo	varchar(40)	NO			
Bloqueado	tinyint(1)	NO		0	
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de vale</summary>

```
Field	Type	Null	Key	Default	Extra
DocumentoNo	bigint(18) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(18) unsigned	NO		0	
DocumentoNoOriginal	bigint(18) unsigned	NO		0	
Importe	decimal(14,4)	NO		0.0000	
Fecha	date	YES		NULL	
CobrarTipo	tinyint(3) unsigned	NO		0	
FormaDePago	enum('Efectivo','Tarjeta','Cheque','Transferencia','Pendiente','Vale','Cupon','Descuento','Otro','ValeSalida','DescuentoCliente','Multi')	NO		Efectivo	
Localizador	varchar(16)	NO			
Origen	enum('Precobro','Devolucion','Restante','Descuento','Otro')	NO		Otro	
EmpresaID	bigint(12) unsigned	NO		0	
Caducado	tinyint(1)	NO		0	
FechaCaducada	date	YES		NULL	
CreadorID	smallint(5) unsigned	NO		0	
TiempoCreado	datetime	YES		NULL	
TiendasCadenaIDCreado	smallint(5) unsigned	NO		0	
Usado	tinyint(1)	NO		0	
UsadorID	smallint(5) unsigned	NO		0	
TiempoUsado	datetime	YES		NULL	
TiendasCadenaIDUsado	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(18) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(18) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(18)	NO		0	
Bloqueado	tinyint(1)	NO		0	
DeviceUUID	varchar(64)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de verifactu</summary>

```
Field	Type	Null	Key	Default	Extra
VeriFactuUUID	bigint(20) unsigned	NO	UNI	NULL	auto_increment
VeriFactuNIF	varchar(20)	NO	PRI		
VeriFactuID	varchar(20)	NO	PRI		
Categoria	varchar(8)	NO	PRI	s	
DocumentoNo	bigint(20) unsigned	NO	PRI	0	
DocumentoNoEnServidor	bigint(20) unsigned	NO		0	
DocumentoNoOriginal	bigint(20) unsigned	NO		0	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
EmpresaNIF	varchar(20)	NO			
EmpresaNombreRazon	varchar(120)	NO			
EmpresaCountryID	varchar(2)	NO			
ClienteIVAClase	tinyint(2) unsigned	NO		0	
ClienteReglaIVA	tinyint(2) unsigned	NO		0	
UsarClienteReglaIVA	tinyint(1)	NO		0	
Descuento	decimal(5,2)	NO		0.00	
Descuento2	decimal(5,2)	NO		0.00	
DescuentoDirecto	decimal(10,4)	NO		0.0000	
Total	decimal(14,4)	NO		0.0000	
DescuentoTotal	decimal(10,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
CobrarTipo	tinyint(3) unsigned	NO		0	
Efectivo	decimal(14,4)	NO		0.0000	
Ganancias	decimal(12,4)	NO		0.0000	
CantidadTotal	decimal(12,4)	NO		0.0000	
PaqueteTotal	decimal(12,4)	NO		0.0000	
CajaTotal	decimal(12,4)	NO		0.0000	
VolumenPesoTotal	decimal(12,4)	NO		0.0000	
LineaTotal	int(10) unsigned	NO		0	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
FechaOriginal	datetime	YES		NULL	
TiempoUltimoEditar	datetime	YES		NULL	
TiempoUltimoActualizar	datetime	YES		NULL	
DocumentoOrigenTipo	varchar(40)	NO			
DocumentoOrigenNo	bigint(20) unsigned	NO		0	
DocumentoDestinoTipo	varchar(40)	NO			
DocumentoDestinoNo	bigint(20) unsigned	NO		0	
ReglaIVA	tinyint(2) unsigned	NO		0	
IVASerie	tinyint(2) unsigned	NO		0	
PrecioUsado	tinyint(2) unsigned	NO		1	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
CocheNo	varchar(40)	NO			
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
AlmacenID	smallint(5) unsigned	NO		1	
Cobrado	tinyint(1)	NO		-1	
CobroTotal	decimal(14,4)	NO		0.0000	
AbonoTotal	decimal(14,4)	NO		0.0000	
CajonID	smallint(5) unsigned	NO		0	
DescuentoUsarRegla	smallint(5) unsigned	NO		0	
DocumentoAdjuntoSimbolo	varchar(60)	NO			
PreFormaDePagoNo	int(10) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
DeviceUUID	varchar(64)	NO			
DocumentoHash	varchar(255)	NO			
InfoGenHash	varchar(1024)	NO			
SubTiendaID	varchar(16)	NO			
DocumentoIntercambioNo	bigint(20)	NO		0	
Bloqueado	tinyint(1)	NO		0	
Anulado	tinyint(1)	NO		0	
Modificando	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
ProgressID	tinyint(3) unsigned	NO		0	
ProgressStatus	tinyint(3) unsigned	NO		0	
LogID	bigint(20) unsigned	NO		0	
HayAdjunto	tinyint(1)	NO		0	
Imprimido	tinyint(1)	NO		0	
QRInfo	varchar(1024)	NO			
DescripcionOperacion	varchar(1024)	NO			
CambioTipo	tinyint(4)	NO		0	
FacturaCambioNo	bigint(20) unsigned	NO		0	
FacturaObservacion	varchar(5120)	NO			
RectTipo	smallint(5) unsigned	NO		0	
TipoRectificativa	varchar(40)	NO			
RectificacionVeriFactuUUID	bigint(20) unsigned	NO		0	
Observacion	varchar(2048)	YES		NULL	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de verifactu_articulo</summary>

```
Field	Type	Null	Key	Default	Extra
VeriFactuUUID	bigint(20) unsigned	NO	MUL	0	
VeriFactuIDNIF	varchar(40)	NO			
ArticuloID	varchar(20)	NO			
PropCount	smallint(5) unsigned	NO		0	
PropID1	varchar(4)	NO			
PropID2	varchar(4)	NO			
Propiedad	varchar(160)	NO			
SerialNo	varchar(4096)	NO			
CodigoBarra	varchar(20)	NO			
CodigoBarraBalanza	tinyint(1)	NO		0	
NombreES	varchar(255)	NO			
NombreCN	varchar(80)	NO			
Precio	decimal(12,4)	NO		0.0000	
Cantidad	decimal(12,4)	NO		0.0000	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
Descuento	decimal(5,2)	NO		0.00	
DescuentoCambioProhibido	tinyint(1)	NO		0	
PrecioCoste	decimal(12,4)	NO		0.0000	
PrecioAgente	decimal(12,4)	NO		0.0000	
Comentario	varchar(1024)	YES		NULL	
NecesitaSerialNo	tinyint(1)	NO		0	
Temporal	tinyint(1)	NO		0	
OrdenNo	int(10) unsigned	NO		0	
```

</details>

<details><summary>Esquema de verifactu_backup</summary>

```
Field	Type	Null	Key	Default	Extra
VeriFactuUUID	bigint(20) unsigned	NO	PRI	0	
VeriFactuIDNIF	varchar(40)	NO			
InvoiceID	varchar(50)	NO			
CreatedTime	datetime	NO		CURRENT_TIMESTAMP	
BackupStatus	tinyint(4)	NO		0	
RetryCount	int(11)	YES		0	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de verifactu_blockchain</summary>

```
Field	Type	Null	Key	Default	Extra
CurrentID	bigint(20) unsigned	NO		0	
CurrentTimeStamp	datetime	YES		NULL	
Huella	char(100)	NO			
NumeroInstalacion	varchar(100)	NO			
VeriFactuID	varchar(20)	NO			
FechaExpedicionFactura	date	YES		NULL	
IDEmisorFactura	varchar(20)	NO	PRI		
NombreRazonEmisor	varchar(200)	NO			
NumSerieFactura	varchar(60)	NO	PRI		
HashText	text	YES		NULL	
IsErrorChain	tinyint(4)	NO		0	
```

</details>

<details><summary>Esquema de verifactu_blockchain_prod</summary>

```
Field	Type	Null	Key	Default	Extra
CurrentID	bigint(20) unsigned	NO		0	
CurrentTimeStamp	datetime	YES		NULL	
Huella	char(100)	NO			
NumeroInstalacion	varchar(100)	NO			
VeriFactuID	varchar(20)	NO			
FechaExpedicionFactura	date	YES		NULL	
IDEmisorFactura	varchar(20)	NO	PRI		
NombreRazonEmisor	varchar(200)	NO			
NumSerieFactura	varchar(60)	NO	PRI		
HashText	text	YES		NULL	
IsErrorChain	tinyint(4)	NO		0	
```

</details>

<details><summary>Esquema de verifactu_blockchain_test</summary>

```
Field	Type	Null	Key	Default	Extra
CurrentID	bigint(20) unsigned	NO		0	
CurrentTimeStamp	datetime	YES		NULL	
Huella	char(100)	NO			
NumeroInstalacion	varchar(100)	NO			
VeriFactuID	varchar(20)	NO			
FechaExpedicionFactura	date	YES		NULL	
IDEmisorFactura	varchar(20)	NO	PRI		
NombreRazonEmisor	varchar(200)	NO			
NumSerieFactura	varchar(60)	NO	PRI		
HashText	text	YES		NULL	
IsErrorChain	tinyint(4)	NO		0	
```

</details>

<details><summary>Esquema de verifactu_cobro</summary>

```
Field	Type	Null	Key	Default	Extra
VeriFactuUUID	bigint(20) unsigned	NO	MUL	0	
VeriFactuIDNIF	varchar(40)	NO			
Categoria	varchar(8)	NO		s	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
CobroDocNo	varchar(40)	NO			
Importe	decimal(14,4)	NO		0.0000	
Reembolso	decimal(14,4)	NO		0.0000	
CobrarTipo	tinyint(3) unsigned	NO		0	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
OrdenadorNombre	varchar(16)	NO			
Bloqueado	tinyint(1)	NO		0	
DeviceUUID	varchar(64)	NO			
ValorDevuelto	varchar(5120)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de verifactu_cola</summary>

```
Field	Type	Null	Key	Default	Extra
id	bigint(20)	NO	PRI	NULL	auto_increment
accion	tinyint(4)	NO		0	
tipo	varchar(50)	NO			
verifactu_uuid	bigint(20)	NO		0	
verifactu_nif	varchar(20)	NO			
verifactu_id	varchar(20)	NO			
estado	enum('pendiente','exito','pendiente_cancel','exito_cancel','pendiente_retry','exito_retry','procesando','error','otro')	NO		pendiente	
mensaje_error	text	YES		NULL	
intentos	tinyint(4)	NO		0	
insert_timestamp	timestamp	NO		CURRENT_TIMESTAMP	
procesado_timestamp	timestamp	YES		NULL	
```

</details>

<details><summary>Esquema de verifactu_cola_prod</summary>

```
Field	Type	Null	Key	Default	Extra
id	bigint(20)	NO	PRI	NULL	auto_increment
accion	tinyint(4)	NO		0	
tipo	varchar(50)	NO			
verifactu_uuid	bigint(20)	NO		0	
verifactu_nif	varchar(20)	NO			
verifactu_id	varchar(20)	NO			
estado	enum('pendiente','exito','pendiente_cancel','exito_cancel','pendiente_retry','exito_retry','procesando','error','otro')	NO		pendiente	
mensaje_error	text	YES		NULL	
intentos	tinyint(4)	NO		0	
insert_timestamp	timestamp	NO		CURRENT_TIMESTAMP	
procesado_timestamp	timestamp	YES		NULL	
```

</details>

<details><summary>Esquema de verifactu_cola_test</summary>

```
Field	Type	Null	Key	Default	Extra
id	bigint(20)	NO	PRI	NULL	auto_increment
accion	tinyint(4)	NO		0	
tipo	varchar(50)	NO			
verifactu_uuid	bigint(20)	NO		0	
verifactu_nif	varchar(20)	NO			
verifactu_id	varchar(20)	NO			
estado	enum('pendiente','exito','pendiente_cancel','exito_cancel','pendiente_retry','exito_retry','procesando','error','otro')	NO		pendiente	
mensaje_error	text	YES		NULL	
intentos	tinyint(4)	NO		0	
insert_timestamp	timestamp	NO		CURRENT_TIMESTAMP	
procesado_timestamp	timestamp	YES		NULL	
```

</details>

<details><summary>Esquema de verifactu_error</summary>

```
Field	Type	Null	Key	Default	Extra
ErrorID	int(11)	NO	PRI	NULL	auto_increment
InvoiceID	varchar(60)	NO			
Huella	varchar(80)	NO			
Status	varchar(60)	NO			
ErrorCode	varchar(60)	NO			
ErrorDescription	text	YES		NULL	
ResponseXML	text	YES		NULL	
IsProcessed	tinyint(1)	YES		0	
CreateAt	datetime	YES		CURRENT_TIMESTAMP	
```

</details>

<details><summary>Esquema de verifactu_estado</summary>

```
Field	Type	Null	Key	Default	Extra
VeriFactuUUID	bigint(20) unsigned	NO	PRI	0	
Anulado	tinyint(1)	NO		0	
Modificado	tinyint(1)	NO		0	
EmailMandado	tinyint(1)	NO		0	
Respaldado	tinyint(1)	NO		0	
Bloqueado	tinyint(1)	NO		0	
UpdateTimeStamp	timestamp	NO		CURRENT_TIMESTAMP	on update CURRENT_TIMESTAMP
```

</details>

<details><summary>Esquema de verifactu_iva_total</summary>

```
Field	Type	Null	Key	Default	Extra
VeriFactuUUID	bigint(20) unsigned	NO	MUL	0	
VeriFactuIDNIF	varchar(40)	NO			
Categoria	varchar(8)	NO		s	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
IVA	decimal(6,3)	NO		0.000	
REQ	decimal(6,3)	NO		0.000	
BaseImponible	decimal(14,4)	NO		0.0000	
ImporteIVA	decimal(12,4)	NO		0.0000	
ImporteREQ	decimal(12,4)	NO		0.0000	
SubTotal	decimal(14,4)	NO		0.0000	
```

</details>

<details><summary>Esquema de verifactu_respuesta</summary>

```
Field	Type	Null	Key	Default	Extra
id	int(11)	NO	PRI	NULL	auto_increment
csv	varchar(32)	NO			
nif_presentador	varchar(20)	NO			
timestamp_presentacion	datetime	YES		NULL	
nombre_razon	varchar(200)	NO			
nif_emisor	varchar(20)	NO			
tiempo_espera_envio	int(11)	NO		0	
estado_envio	varchar(20)	NO			
id_emisor_factura	varchar(20)	NO			
id_verifactu	varchar(20)	NO			
num_serie_factura	varchar(50)	NO			
fecha_expedicion_factura	date	YES		NULL	
tipo_operacion	varchar(20)	NO			
ref_externa	varchar(100)	NO			
estado_registro	varchar(20)	NO			
created_at	timestamp	NO		CURRENT_TIMESTAMP	
```

</details>

<details><summary>Esquema de verifactu_sin_cobrado</summary>

```
Field	Type	Null	Key	Default	Extra
VeriFactuUUID	bigint(20) unsigned	NO	PRI	0	
VeriFactuIDNIF	varchar(40)	NO			
Categoria	varchar(8)	NO		s	
Fecha	date	YES	MUL	NULL	
FechaEntrada	datetime	NO		CURRENT_TIMESTAMP	
Total	decimal(14,4)	NO		0.0000	
DescuentoExtra	decimal(5,2)	NO		0.00	
CobroTotal	decimal(14,4)	NO		0.0000	
EmpresaID	bigint(12) unsigned	NO		0	
SucursalID	smallint(5) unsigned	NO		0	
AgenteID	smallint(5) unsigned	NO		0	
TransportistaID	smallint(5) unsigned	NO		0	
TransporteModoID	smallint(5) unsigned	NO		0	
EnvioGasto	decimal(14,4)	NO		0.0000	
OperadorID	smallint(5) unsigned	NO		0	
VerificadorID	smallint(5) unsigned	NO		0	
Bloqueado	tinyint(1)	NO		0	
DeviceUUID	varchar(64)	NO			
Observacion	varchar(2048)	YES		NULL	
```

</details>

<details><summary>Esquema de verifactu_ultima</summary>

```
Field	Type	Null	Key	Default	Extra
id_emisor_factura	varchar(80)	NO	PRI		
id_verifactu	varchar(20)	NO	PRI		
num_serie_factura	varchar(80)	NO			
fecha_exp_factura	varchar(80)	NO			
huella	varchar(80)	NO			
```

</details>

<details><summary>Esquema de verifactu_ultima_prod</summary>

```
Field	Type	Null	Key	Default	Extra
id_emisor_factura	varchar(80)	NO	PRI		
id_verifactu	varchar(20)	NO	PRI		
num_serie_factura	varchar(80)	NO			
fecha_exp_factura	varchar(80)	NO			
huella	varchar(80)	NO			
```

</details>

<details><summary>Esquema de verifactu_ultima_test</summary>

```
Field	Type	Null	Key	Default	Extra
id_emisor_factura	varchar(80)	NO	PRI		
id_verifactu	varchar(20)	NO	PRI		
num_serie_factura	varchar(80)	NO			
fecha_exp_factura	varchar(80)	NO			
huella	varchar(80)	NO			
```

</details>

<details><summary>Esquema de warn</summary>

```
Field	Type	Null	Key	Default	Extra
WarnID	bigint(20) unsigned	NO	PRI	NULL	auto_increment
WarnTime	datetime	YES	MUL	NULL	
ProgramName	varchar(80)	NO			
DBVersion	decimal(8,2)	NO		0.00	
UserID	varchar(40)	NO			
WarnType	varchar(40)	NO			
WarnUrl	varchar(255)	NO			
DeviceIP	varchar(60)	NO			
Content	longtext	YES		NULL	
```

</details>

