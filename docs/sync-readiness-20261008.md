# Bohao → B2B: carga inicial, sincronización y aceptación

> Estado histórico, anterior a la ampliación de stock por lotes. Consulta la [segunda revisión](production-review-20261008.md) para el código y las pruebas actuales.

Revisión del 8 de octubre de 2026 de `E:/company/nexoflux-b2b` y este bridge.

## Cómo funciona actualmente

1. Bohao conserva la autoridad del catálogo, precios seleccionados, clientes vinculados y stock físico.
2. La primera sincronización recorre todas las páginas de productos y clientes y los publica por su External Id. No requiere introducir cada artículo manualmente. `article_ids` vacío significa catálogo completo; una lista limita la instalación a un piloto.
3. Las siguientes lecturas comparan huellas del contenido. Productos y clientes sin cambios no se vuelven a escribir. El stock sí necesita una captura nueva, aunque la cantidad no cambie.
4. Los pedidos **confirmados** en el B2B se incorporan a Bohao, con documento vinculado y acuse de exportación. Un pedido pendiente de revisión todavía no se importa como pedido operativo. Los reintentos no crean otro documento.
5. Un cliente nuevo del B2B se da de alta o se vincula por identificación fiscal al importar su pedido. Esto no es una sincronización general de todas las altas y modificaciones de clientes B2B → Bohao antes de que pidan.
6. Los albaranes Bohao de los pedidos vinculados publican expediciones en el B2B. No se descuenta stock físico por insertar el pedido.
7. Activar automático conserva la preferencia para otros arranques. El inicio automático del bridge requiere que MySQL y el B2B estén disponibles; no inicia esos servicios de desarrollo.

## Correcciones aplicadas en esta revisión

- Cola: pedidos primero, stock después, clientes y catálogo a continuación. Se vuelve a seleccionar después de cada operación para publicar la captura de un artículo antes de continuar con otro.
- Consulta de pedidos durante ciclos largos, comprobada entre operaciones cada cinco segundos. No promete cinco segundos exactos: una petición o una operación de producto en curso puede durar más.
- Preparación inicial en transacciones SQLite de hasta 200 identidades, sin persistir miles de filas completas. Índice por entidad para evitar duplicados pendientes y mantener el orden de reintentos de la misma entidad.
- Interrupciones: conserva los pendientes y no marca la carga interrumpida como ciclo completado.
- Categorías: evita escrituras repetidas si contenido y versión no cambian; vuelve a vincular una categoría recreada.
- Productos: cambios de códigos de barras secundarios y del identificador B2B de su categoría invalidan la huella y se publican.

## Pruebas de esta sesión

| Comprobación | Resultado |
| --- | --- |
| Suite Python final, incluidas las 6 pruebas MySQL del esquema actual | 30 pasadas, sin pruebas omitidas |
| Archivo de carga inicial, incluida la regresión de barcodes | 6 pasadas |
| MySQL demo v6.22, puerto 3337 | 6 pasadas |
| B2B: external-stock | 6 pasadas |
| B2B: public-api-orders, public-api-stock-customers, public-api-catalogue | 31 pasadas |
| Ruff bridge/tests/tools | Pasado |
| Ejecutable actualizado | Compilado; arranque en puerto 8767, consola y JS HTTP 200; detenido después |

La cola se prueba con **5.000 identidades de producto**, reinicio y segunda lectura sin duplicados. La prueba del motor simula **1.000 productos y 1.000 capturas**, con un pedido que llega durante el procesamiento. Son pruebas de cola y planificación con B2B simulado; **no son una carga real de 5.000 productos a Cloudflare**.

Las escrituras MySQL se ejecutaron exclusivamente contra las dos bases demo permitidas. Las pruebas B2B usan su entorno de pruebas y peticiones REST autenticadas. El B2B de desarrollo arrancó, pero la clave de la demo guardada devuelve 401 `UNAUTHORIZED` y debe reemplazarse por una clave válida. Por tanto no se afirma una aceptación nueva del flujo completo con navegador y Bohao nativo.

El ejecutable está en `dist/release-20261008/NexofluxBohaoSync/NexofluxBohaoSync.exe`. Distribuir toda su carpeta. Se verificó el arranque con una carpeta de configuración nueva y automático desactivado; no se instaló en producción ni se sustituyó el proceso anterior. Los servicios de desarrollo iniciados para esta revisión se detuvieron al terminar.

## Bloqueo para miles de variantes

El B2B configura **300 peticiones por minuto por clave** en `packages/infra/alchemy.run.ts`. El bridge envía actualmente una captura por variante al endpoint `stock/external-snapshot`.

Para 5.000 variantes, solo sus capturas necesitan al menos `5000 / 300 = 16,7 minutos`, sin contar productos, imágenes, expediciones ni consulta de pedidos. El B2B bloquea nuevos pedidos si el stock físico lleva más de cinco minutos sin renovarse. La prioridad de la cola elimina esperas innecesarias, pero no elimina este límite de capacidad.

**No habilitar la venta de todo ese catálogo como si estuviera validado a escala.** Para admitirlo hace falta un endpoint de capturas por lotes, con límites de trabajo por petición, resultados individuales y los mismos controles de identidad, secuencia, conciliación, frescura y reintentos. Debe medirse la vuelta completa de stock con el volumen real, incluyendo variantes, para que quede por debajo de cinco minutos con margen. Esta ampliación no está implementada en esta revisión.

Para acelerar la carga inicial, el B2B tiene importación de archivos POS de hasta 50.000 filas, pero su REST público solo expone consulta de resultados. El bridge actual publica por upserts individuales; no está conectado a una API pública de carga masiva. La carga es automática y reanudable, pero no instantánea.

## Configuración y prueba operativa

1. Seleccionar la Organization B2B de pruebas, configurar catálogo externo y crear una Organization API Key con `products:read/write`, `customers:read/write`, `stock:read/write`, `orders:read/write`, `shipments:write`, `changes:read`.
2. Conectar un MySQL demo, elegir almacenes y columna de precio; verificar si esa columna incluye IVA. Pulsar **Comprobar conexiones y datos**.
3. Hacer un piloto con artículos que cubran producto simple, propiedades y pack. Pulsar **Sincronizar ahora** y resolver todas las incidencias. Revisar catálogo, barcodes, unidades, precios, clientes y stock.
4. Crear y confirmar un pedido B2B. Verificar en Bohao nativo cabecera, cliente, líneas, cantidades, precio, impuestos y serie. Repetir su importación y comprobar que existe un solo documento.
5. Preparar y convertir ese pedido en albarán dentro de Bohao. Comprobar expedición y disponible B2B, incluidos envíos parciales. Las pruebas SQL no sustituyen este paso.
6. Cambiar un precio, un barcode secundario, una cantidad física y un cliente en Bohao; comprobar su publicación. Crear un cliente B2B sin vínculo y confirmar su primer pedido; comprobar alta y vínculo en Bohao.
7. Desconectar temporalmente el bridge. Comprobar bloqueo de pedidos por stock envejecido y recuperación al reconectar, sin documentos ni expediciones duplicadas.
8. Completar el envío de stock por lotes y probar el volumen real antes de ampliar el piloto a miles de variantes. Después activar automático e instalar el inicio al entrar en Windows o verificar el servicio Windows con permisos correspondientes.

También quedan fuera del mapeo completo sucursales, todas las tarifas particulares y perfiles fiscales especiales; consultar `coverage.md`. Los cambios no se han desplegado en producción.
