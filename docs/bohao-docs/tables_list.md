# Listado Completo de Tablas: bohaosupermarket3

A continuación se listan todas las tablas encontradas en la base de datos de Bohao.

Inventario contrastado con la instalación local el 10 de octubre de 2026: 190 tablas. El conjunto puede variar entre versiones e instalaciones.

## Tablas Principales (Core)
- **articulo**: Información de productos (nombres, precios, categorías).
- **ticket** / **ticketarticulo**: Datos de ventas y líneas de ticket.
- **cliente**: Información de clientes (CIF, teléfono, direcciones).
- **stock**: Cantidades disponibles por almacén.
- **proveedor**: Datos de proveedores.
- **empleado**: Listado de personal y permisos.

## Listado Total de Tablas
| Tabla | Tabla | Tabla |
|-------|-------|-------|
| abono | abonoarticulo | abonodiariolista |
| abonoivatotal | abonoproveedor | abonoproveedorarticulo |
| abonoproveedorivatotal | adjunto | adjuntotemp |
| agente | agenteclase | albaran |
| albaranarticulo | albaranivatotal | albaranproveedor |
| albaranproveedorarticulo | almacen | almacencloud |
| almacenmovimiento | almacenmovimientoarticulo | archivoconfiguracion |
| articulo | articuloclase | articuloclaseorden |
| articulocodigobarra | articulodibujo | articuloeliminado |
| articuloextra | articuloorden | articuloprecioconsulta |
| articulopreciocoste | articuloprop | articulotiempoultimousar |
| bartender | binaryfile | cajon |
| cajonimpexp | cliente | clienteclase |
| clientediariototal | clienteextra | clientelogin |
| clientesucursal | cobro | codigobarrabalanza |
| consultatipo | cupon | currencyrate |
| dbsql | device | devolucion |
| devolucionarticulo | devolucionproveedor | devolucionproveedorarticulo |
| dibujo | documentclouded | documentlog |
| documentocobro | documentointercambio | documentomensaje |
| documentono | documentosincobrado | documenttocloud |
| documenttosubtienda | emailsent | empaque |
| empaquearticulo | empleado | empleadoclase |
| empleadotodo | etiqueta | etiquetaarticulo |
| extra | extraarticulo | extradiariolista |
| extraivatotal | factura | facturaarticulo |
| facturadiariolista | facturaivatotal | facturaproveedor |
| facturaproveedorarticulo | facturaproveedorivatotal | gananciacambio |
| gananciadiariototal | impresoraservidor | informeespecial |
| inventario | inventarioarticulo | inventariodoc |
| inventariodocstock | ivatipo | labeltemplate |
| log | opcion | ordenadorejecutando |
| otrosincobrado | otrosinpagado | pago |
| pagoforma | pedido | pedidoarticulo |
| pedidocliente | pedidoclientearticulo | pedidoclienteivatotal |
| pedidoproveedor | pedidoproveedorarticulo | pedidotableta |
| pedidotabletaarticulo | pedidotemp | pedidotemparticulo |
| pos5a | pos5aarticulo | pos5acobro |
| pos5aivatotal | pos5asincobrado | preformadepago |
| presupuesto | presupuestoarticulo | presupuestoproveedor |
| presupuestoproveedorarticulo | proforma | proformaarticulo |
| prop | propdeta | proveedor |
| proveedorclase | proveedordiariototal | proveedorextra |
| proveedorlogin | proveedorsucursal | punto |
| puntoentrada | puntosalida | redsysdevolucion |
| reglacupon | report | server_setting |
| stock | stockajuste | stockajustearticulo |
| stockcambio | stockcambiocloud | stockentrada |
| stockentradaarticulo | stockextra | stockextracambio |
| stocksalida | stocksalidaarticulo | subtienda |
| tablapropiedad | tempvalue | ticket |
| ticketarticulo | ticketcambio | ticketcobro |
| ticketcolgando | ticketcolgandoarticulo | ticketdiariototal |
| ticketextra | ticketextraarticulo | ticketextradiariolista |
| ticketextraivatotal | ticketivatotal | ticketoferta |
| ticketsincobrado | transporte | transportearticulo |
| transportemodo | transportista | vale |
| verifactu | verifactu_articulo | verifactu_backup |
| verifactu_blockchain | verifactu_blockchain_prod | verifactu_blockchain_test |
| verifactu_cobro | verifactu_cola | verifactu_cola_prod |
| verifactu_cola_test | verifactu_error | verifactu_estado |
| verifactu_iva_total | verifactu_respuesta | verifactu_sin_cobrado |
| verifactu_ultima | verifactu_ultima_prod | verifactu_ultima_test |
| warn |  |  |

*Nota: Las tablas `verifactu_...` corresponden al sistema de cumplimiento fiscal Verifactu (España).*
