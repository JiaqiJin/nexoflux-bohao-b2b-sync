# Segunda revisión de Bohao → B2B, 8 de octubre de 2026

## Decisión para el 9 de octubre

La carga inicial y el flujo comercial básico funcionan en la demo local. Se ha implementado el stock por lotes que faltaba en la revisión anterior. **La aceptación de producción sigue pendiente**: falta abrir y operar los documentos en Bohao nativo y medir el ciclo completo con la instalación, red y volumen reales. Ningún cambio de esta revisión se ha desplegado en producción.

## Qué se ha comprobado y corregido

- La carga inicial recorre automáticamente productos y clientes. `article_ids: []` publica todo el catálogo compatible; una lista limita los artículos del piloto. No hay que introducir miles de artículos a mano. La primera carga sigue publicando el catálogo por upserts individuales, con imágenes, unidades y precios; puede durar horas. La cola conserva el trabajo tras reinicios.
- Nuevo `PUT /api/v1/organizations/{organizationId}/stock/external-snapshots`: hasta 25 variantes y 2000 referencias de expedición por petición. Cada variante utiliza exactamente la conciliación transaccional del endpoint individual. Los resultados siguen el orden de entrada; una variante rechazada no revierte las aceptadas. Un fallo inesperado puede perder la respuesta después de aceptar parte del lote: se repiten las mismas secuencias y contenidos.
- El bridge conserva capturas pendientes, agrupa su envío, verifica la identidad de los resultados, separa incidencias y reintentos, y elimina capturas caducadas para volver a leer el saldo. No toma una repetición como una lectura física nueva.
- Renovación independiente del stock de productos ya publicados, incluso mientras sigue la carga inicial. Procesa grupos de lecturas locales y luego sus capturas. Prioriza pedidos, stock, lecturas físicas, clientes y catálogo. Una nueva vuelta se programa 60 segundos después de finalizar la anterior, evitando que una vuelta larga se encole sobre sí misma continuamente y bloquee la carga inicial.
- El cliente HTTP limita su envío a cuatro peticiones por segundo, dejando margen bajo las 300/minuto por clave. Otros procesos que compartan la misma clave pueden consumir ese margen.
- Preflight y comienzo del ciclo comprueban que la referencia OpenAPI incluye el nuevo endpoint. Un B2B anterior devuelve `STOCK_BATCH_API_REQUIRED`: primero hay que actualizar el B2B.
- `GET /api/status` incluye `stock_sweep`, con duración, cantidad de capturas generadas y hora de fin de la última vuelta prioritaria. Es diagnóstico de trabajo, no una certificación de que todas las variantes se aceptaron: revisar también `errors`, pendientes y el stock observado por el B2B.

## Pruebas de esta revisión

| Prueba | Resultado |
| --- | --- |
| Suite Python con MySQL actual en la demo | 37 pasadas, ninguna omitida |
| Integración MySQL v6.22 | 6 pasadas |
| REST stock, clientes, pedidos y catálogo B2B | 39 pasadas |
| Lote con 5000 variantes reales en D1 local | 1 pasada; 200 peticiones REST autenticadas; unos 60 segundos para el test completo |
| Contrato REST, claves, permisos y aislamiento | 24 pasadas |
| Ruff bridge/tests/tools; TypeScript API y web; lint API y archivos de pruebas; formato de archivos B2B modificados | Pasados |

La prueba de escala crea productos, variantes y unidades base en la D1 del entorno de pruebas y escribe sus 5000 capturas a través del REST real. Las claves de prueba rotan por el límite de 10/minuto de Vitest. **No mide la red de producción, ni 5000 lecturas de MySQL a través del bridge, ni imágenes, ni toda la carga inicial.** El B2B conserva las reservas y rechaza secuencias antiguas, otra instalación, evidencia de expedición inexistente y observaciones envejecidas. La ampliación requiere la capacidad de Workers Paid que ya requieren las operaciones grandes del proyecto; no se ha cambiado el plan de Cloudflare.

Se levantó además una demo B2B nueva y se creó una clave válida de pruebas, evitando la clave caducada de la demo anterior. Con el bridge Python y MySQL aislado `127.0.0.1:3337 / bohao_sync_demo` se verificó:

1. Preflight y publicación real por HTTP de tres productos, un cliente, precios y stock; cero incidencias.
2. Pedido pendiente: no crea documento operativo en Bohao. Al confirmarlo, documento `900000000068`, acuse B2B y repetición con un solo vínculo/documento.
3. Cliente nuevo B2B aprobado, sin External Id: al confirmar su primer pedido se crea/vincula el cliente Bohao `900000000000`, se publica su External Id y repetir el ciclo conserva un solo cliente.
4. Cambios de precio, nombre de cliente y stock físico en la demo: publicados en el B2B, conservando reservas online. Los valores de origen se restauraron y se sincronizó su restauración sin incidencias.

La segunda demo utiliza `.scratch/retest-e2e`, con automático desactivado. Sus secretos y sesiones están en `.scratch`, excluida de Git. No reutilizar esa configuración en producción.

Durante el arranque de las pruebas se seleccionó por error MySQL 5.7 para la carpeta demo de MySQL 8. El proceso falló y creó dos archivos de redo incompatibles. Esos archivos se conservaron en `.scratch/mysql57-failed-start`; MySQL 8.0.43 arrancó de nuevo correctamente y las pruebas de ambas bases demo pasaron. No se abrió ni modificó la base nativa de producción.

El ejecutable actualizado se compiló en `dist/release-20261008-batch/NexofluxBohaoSync`. Se inició en el puerto 8767 con la configuración de esta segunda demo: consola y JavaScript HTTP 200, preflight HTTP 200 y ciclo completo sin incidencias. El proceso de prueba se detuvo después; no se sustituyó el proceso anterior ni se instaló en producción. El ZIP de distribución incluye toda la carpeta y esta guía.

## Lo que aún exige aceptación operativa

- **Bohao nativo:** abrir el pedido importado, comprobar cliente, serie, unidades, precios, descuentos, IVA/recargo y total; prepararlo y convertirlo en albarán. Verificar que ese albarán se publica como Shipment, incluido envío parcial y repetición sin duplicación. Las pruebas SQL y simulaciones de albaranes no sustituyen este paso.
- **Volumen real:** medir la separación entre observaciones aceptadas de la misma variante durante la carga inicial y en automático. Debe quedar por debajo de cinco minutos con margen, incluyendo lecturas MySQL, categorías, catálogo, imágenes, pedidos, expediciones, otras claves y latencia real. Los lotes eliminan el mínimo anterior de 16,7 minutos impuesto por una petición por variante, pero no garantizan por sí solos toda la vuelta.
- **Caída y recuperación:** dejar envejecer las capturas y comprobar rechazo de un pedido; reconectar, publicar nuevas observaciones y comprobar recuperación sin documentos ni expediciones duplicados.
- **Clientes:** Bohao → B2B está implementado; las altas B2B entran en Bohao al importar su primer pedido. No existe sincronización bidireccional general de todos los cambios del cliente antes de que pida. Para eso hay que decidir autoridad por campo y resolver conflictos.
- **Cobertura comercial:** revisar `coverage.md`. Siguen pendientes sucursales, todas las tarifas particulares, perfiles fiscales especiales y lotes. No habilitar esos datos como si estuvieran mapeados.
- **Arranque:** verificar la carpeta de datos definitiva, automático, conexión tras reinicio de Windows y el método de inicio elegido. La instalación real del servicio Windows no se ha probado en esta revisión.

## Orden de instalación

1. Respaldar la base Bohao y la carpeta de datos/SQLite existente.
2. Actualizar el B2B con el endpoint por lotes y verificar su REST con una Organization de pruebas y clave válida. No hay migración de esquema nueva para este cambio.
3. Distribuir **toda** la carpeta `dist/release-20261008-batch/NexofluxBohaoSync`; conserva la carpeta de datos al reemplazar el bridge. Detener el proceso anterior antes de iniciar el nuevo.
4. Comprobar conexiones y datos. Ejecutar el piloto con artículo simple, propiedades y pack; resolver incidencias; hacer la aceptación nativa descrita arriba.
5. Ejecutar la carga completa con ventas cerradas durante su validación; medir la frescura real. Activar automático y habilitar ventas cuando el piloto y el volumen real estén aceptados.

Evidencias: logs `retest-*` en `.scratch` de ambos proyectos y JSON `retest-order-result.json`, `retest-new-customer-result.json`, `retest-mutation-result.json` de la demo. La configuración y los resultados detallados de clientes/pedidos son privados y no deben adjuntarse a un informe público.
