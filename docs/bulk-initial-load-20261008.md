# Bohao: carga inicial por ZIP y continuidad del Bridge

Implementado y comprobado el 8 de octubre de 2026. El Bridge lee Bohao local; no instala un menú dentro de la aplicación Bohao.

## Uso

1. Actualiza primero el B2B con los cambios de importación de opciones y el endpoint de stock por lotes. Instala después `NexofluxBohaoSync-release-20261008-bulk.zip`.
2. Configura la conexión, Organization y la tarifa de Bohao que publicarás. Conserva la carpeta de datos y su `installation_id`. Comprueba conexiones. Para una primera carga, usa una Organization vacía o concilia previamente las identidades ya existentes.
3. En Resumen, pulsa **Generar paquetes ZIP**. El automático queda pausado. La exportación solo lee tablas comerciales: no inicializa ni escribe MySQL.
4. Descarga todos los paquetes. Contienen CSV de categorías, productos, opciones, variantes, unidades base y packs, precios (el mismo importe que en Bohao, sin sumar ni restar impuestos) y clientes. B2B interpreta los precios y pedidos como netos, sin impuestos. No son un CSV plano arbitrario: el ZIP incluye el manifiesto y las identidades que utilizará el Bridge.
5. En B2B, selecciona la misma Organization y catálogo **plataforma**, abre Integración → Importar, previsualiza cada ZIP y completa todos los registros. Resuelve los errores y reintenta. No invites compradores como parte de esta operación: esa es una acción independiente.
6. Cambia el catálogo B2B a **externo**. Vuelve al Bridge y pulsa **Comprobar importación B2B**. Comprueba los resultados de todos los paquetes y sus SHA-256; después lee el catálogo por páginas y adopta sus identidades. Un archivo incompleto o distinto impide continuar.
7. Pulsa **Sincronizar ahora** para publicar imágenes y existencias actuales. Revisa Incidencias y activa automático cuando la primera sincronización termine correctamente.

## Qué ocurre después

Bohao es la fuente de productos, precios y clientes. El Bridge vuelve a leerlos periódicamente y compara sus huellas locales: los registros sin cambios no generan escrituras de catálogo/cliente en B2B. No es una suscripción instantánea a eventos MySQL; hay lecturas periódicas de todos los registros seleccionados. Cambios posteriores a la exportación se publican en el siguiente ciclo.

El stock se renueva incluso sin cambios de ficha o precio, porque las ventas del POS pueden cambiarlo independientemente. No se importa un stock antiguo dentro del ZIP. Las imágenes también se envían después por su flujo habitual. Los pedidos **confirmados** del B2B se incorporan a Bohao con vínculo persistente para evitar duplicados; los borradores no se importan. En pedidos net-only, el Bridge toma el tipo de IVA de la categoría nativa del artículo, calcula los importes del pedido y escribe las líneas, el total y el resumen fiscal cuando el esquema lo permite. Esto no recalcula el precio del catálogo. Los envíos vinculados se concilian con las reservas online.

La carga grande se divide automáticamente con un máximo de 45.000 filas y unos 8 MB de contenido CSV por paquete. Nunca separa un producto de sus variantes/unidades/precios; las categorías se repiten para que cada parte tenga sus dependencias. La plataforma valida e importa por tramos: subir un ZIP evita miles de llamadas REST públicas desde el PC, pero no elimina el trabajo de validación y escritura en D1.

## Identidades y errores

No borres ni sustituyas la carpeta de datos al actualizar el ejecutable. Contiene secuencias de stock, vínculos, cursores y huellas de imágenes. Reiniciar una instalación existente con una carpeta vacía y el mismo identificador puede producir conflictos de stock o de imágenes. Cada instalación/Organization necesita su carpeta correcta.

Un cliente ya existente con el mismo país y número fiscal pero otra identidad externa se rechaza (`CUSTOMER_TAX_ID_TAKEN`): debe conciliarse antes de la carga, no duplicarse ni cambiarse su NIF real. Las reglas comerciales/fiscales que no tienen mapeo verificado detienen la generación con diagnóstico. Los ZIP contienen datos comerciales y de clientes: guárdalos en un lugar privado; no incluyen contraseñas ni la clave API.

## Evidencia local

- Bridge: 44 pruebas de la suite completa con MySQL demo, más la prueba añadida de protección de automático/descargas (4 pruebas de consola, todas correctas): 45 pruebas distintas en total.
- B2B: 47 pruebas de importación POS, stock externo y claves API correctas; comprobación TypeScript de API y lint de los archivos API modificados correctos.
- Exportación de 10.000 productos: sin pérdidas ni identidades duplicadas; partición conservando relaciones, Unicode, comillas, saltos de línea, variantes, packs y precios idénticos a Bohao.
- Repetición de importación en D1 local: las variantes y unidades conservan sus UUID, sin duplicados; se importan opciones y los precios base/pack correctos.
- MySQL 8 demo → ZIP → API real del B2B local → comprobación del Bridge: 23 registros importados, 3 productos y 2 clientes adoptados. Ciclo posterior: 14 operaciones terminadas, cero pendientes/bloqueadas, cero PUT de catálogo/clientes sin cambios; continuaron imágenes y stock.
- Cambio real de `PrecioMayor` en MySQL demo: el Bridge actualizó el precio B2B conservando el UUID del producto. Se restauró el precio original en MySQL y B2B al terminar.
- Ejecutable Windows recompilado: arrancó en un puerto de prueba, recuperó `initial_load.status=ready` y mantuvo el automático pausado. Instalador ZIP SHA-256: consultar `NexofluxBohaoSync-release-20261008-bulk.zip.sha256` junto al paquete.
- Navegador real: generación por botón, enlaces ZIP, comprobación, estado aceptado y consola sin errores. Evidencia: `.scratch/bulk-verified.jpg`, prueba de tráfico `.scratch/bulk-fresh-proof.json`.
- Se comprobaron también los rechazos de importación pendiente, resultados incompletos, huellas distintas y conflictos con un NIF demo ya existente. Los valores comerciales de MySQL modificados temporalmente por el ensayo se restauraron.

Estas pruebas no equivalen a importar 10.000 productos en Cloudflare de producción ni a aceptar el flujo en la interfaz nativa de Bohao. Antes del lanzamiento falta la prueba del cliente con sus datos reales, volumen real, precio/stock comprobados y un pedido visible y preparable dentro de Bohao. No se desplegó producción en esta sesión.
