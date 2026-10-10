# Nexoflux Bohao Sync

Bridge independiente en Python para Windows, con consola local y cola persistente. No importa código ni llama endpoints de `nexoflux-bohao-backend`. Compatible con las estructuras de Bohao actual y v6.22 suministradas.

## Ejecutar

```powershell
cd E:\company\nexoflux-b2-bohao-sync
.\setup.ps1 -Development
.\start.ps1
```

Todo Python se instala en `.venv`. Consola: **http://127.0.0.1:8765**. Los datos normales se guardan en `%LOCALAPPDATA%\NexofluxBohaoSync`, separados del código. Para abrir la última demo revisada (segundo pase del 8 de octubre):

```powershell
.\start.ps1 -DataDir E:\company\nexoflux-b2-bohao-sync\.scratch\retest-e2e
```

La demo necesita el MySQL aislado de este PC en puerto 3337 y el B2B local. La configuración de demo no es la conexión de producción. Sus secretos están cifrados y excluidos de Git.

## Instalar en el ordenador del cliente

La instalación de desarrollo anterior sirve para trabajar en este repositorio. Para el ordenador del cliente, descarga el ZIP de la última versión desde [Releases](https://github.com/JiaqiJin/nexoflux-bohao-b2b-sync/releases), extrae el ZIP completo y ejecuta `install-client.bat` una sola vez con la cuenta de Windows que utilizará la aplicación. El BAT invoca PowerShell con una política de ejecución temporal para este proceso, de modo que no hace falta cambiar la política global del equipo. Instala la aplicación en `%LOCALAPPDATA%\Programs\NexofluxBohaoSync`, conserva configuración y credenciales en `%LOCALAPPDATA%\NexofluxBohaoSync`, crea accesos directos con el icono de la app en el escritorio y el menú Inicio, y configura el inicio con Windows. Al iniciar sesión, el servidor se inicia en segundo plano sin abrir el navegador; el usuario puede abrir la consola haciendo clic en el acceso directo. Si GitHub no está disponible, inicia la última versión instalada.

Para publicar una actualización, sube el cambio al repositorio y crea y sube una etiqueta de versión como `v0.1.4`. GitHub Actions compila el ejecutable y publica el ZIP en Releases. Un monitor en segundo plano comprueba nuevas versiones cada hora. Cuando encuentra una, espera a que termine el ciclo de sincronización, reinicia la app de forma controlada e instala la versión nueva; los datos del cliente permanecen en su carpeta local. El usuario puede abrirla desde el escritorio o el menú Inicio, sin escribir una IP.

La actualización automática requiere instalar este paquete de cliente una vez y tener acceso a `github.com` y `api.github.com`. Si una instalación anterior usaba `install-autostart.ps1`, vuelve a ejecutar la instalación de cliente desde el ZIP de Releases para activar también el actualizador.

## Configurar y utilizar

1. En **Configuración**, introduce MySQL, BBDD, usuario, almacenes, URL HTTPS del B2B, Organization ID y Organization API Key. Selecciona la columna de precio de Bohao que publicarás.
2. El catálogo de esa Organization debe estar en **modo externo**. La clave necesita `products:read/write`, `customers:read/write`, `stock:read/write`, `orders:read/write`, `shipments:write` y `changes:read`.
3. **Guardar configuración → Comprobar conexiones y datos** muestra el esquema detectado: Actual o v6.22. No hay que instalar un backend distinto por versión.
4. **Sincronizar ahora** publica categorías, productos, unidades, precios, clientes y stock compatible. **Pedidos** permite consultar todas las páginas e importar/actualizar confirmados. El automático también recoge pedidos nuevos.
5. **Incidencias** explica los registros que requieren intervención. Corrige el dato o conflicto y pulsa **Reintentar pendientes**. La importación repetida conserva el documento, sin duplicarlo.
6. **Activar automático** guarda la preferencia para próximos arranques.

Una carpeta de datos vincula una instalación MySQL con una Organization. No cambies esa carpeta entre BBDD: para otra instalación utiliza otra carpeta, otro puerto local y su Organization. El soporte de dos esquemas permite conectar cualquiera de ellos; no mezcla el stock de dos instalaciones en una misma identidad.

## Apagar el PC y volver a arrancar

Al apagar Windows se detiene la sincronización. Configuración, identidad, cursor y operaciones pendientes quedan guardados. Al abrir el bridge vuelve a leer los pedidos y las existencias actuales. Un proceso terminado abruptamente libera su lease al siguiente arranque; las transacciones SQL pendientes se revierten y los reintentos usan el mismo vínculo de documento.

Para arrancar al iniciar sesión, sin permisos de administrador:

```powershell
.\install-autostart.ps1
# Para quitar únicamente el inicio automático:
.\remove-autostart.ps1
```

Cerrar la pestaña del navegador no detiene el motor. Cerrar el proceso sí lo detiene. El B2B impide enviar nuevos pedidos de variantes cuyo stock local lleva más de cinco minutos sin actualizarse. Esto deja un margen máximo de cinco minutos, no una detección instantánea de apagado.

Para funcionar antes de iniciar sesión, existe `install-service.ps1` (PowerShell como administrador), tras `build.ps1`. El servicio usa `%PROGRAMDATA%\NexofluxBohaoSync`; requiere configurar allí su conexión. No ejecutes el servicio y el inicio por usuario en el mismo puerto. El servicio Windows está implementado, pero su instalación no se ha verificado en esta sesión sin elevación.

## Compatibilidad y permisos

Se comprueban columnas y motores antes de escribir. v6.22 no incluye `pedidoclienteivatotal`: se conservan IVA/recargo en líneas, total en cabecera y desglose completo en las revisiones auxiliares. En el esquema actual se escribe también el resumen IVA. No se altera ni actualiza el esquema nativo.

La primera sincronización crea únicamente cuatro tablas `nexoflux_sync_*` en MySQL: vínculos de cliente/pedido, secuencia y revisiones. Necesita `CREATE` para esa preparación y `SELECT/INSERT/UPDATE/DELETE` sobre esas tablas y los documentos afectados. Una vez creadas, no ejecuta `CREATE` en cada ciclo. Pedidos, sus líneas, resumen IVA si existe, stock y albaranes deben ser InnoDB. Nunca publica la contraseña MySQL ni abre MySQL a Internet.

No escribe stock físico al importar pedidos. El disponible online se concilia con existencias locales, reservas y expediciones reflejadas. Los artículos privados/bloqueados o dentro de categorías privadas/bloqueadas no se publican como activos.

## Alcance comprobado

Para miles de artículos, utiliza la nueva [carga inicial por ZIP y continuidad del Bridge](docs/bulk-initial-load-20261008.md): exportar → importar todos los paquetes en B2B → comprobar y adoptar → sincronizar stock/imágenes → activar automático. Se comprobó la exportación de 10.000 productos y el recorrido completo en MySQL/D1 demo; la aceptación del cliente en producción sigue pendiente.

Consulta la [segunda revisión del 8 de octubre](docs/production-review-20261008.md): stock por lotes implementado, renovación durante la carga inicial, pruebas de 5000 variantes en D1 local y aceptación de producción pendiente. Primero actualiza el B2B con el nuevo endpoint y después instala el bridge. La [revisión anterior](docs/sync-readiness-20261008.md) documenta el estado previo a esta ampliación.

Consulta [cobertura](docs/coverage.md), [validación](docs/validation.md), [revisión](docs/review.md) y la [validación de la instalación local del 10 de octubre](docs/production-validation-20261010.md). La sincronización comercial principal está implementada; los datos sin equivalencia fiscal o comercial demostrada requieren reglas adicionales y aparecen documentados. No se afirma que todas las tablas nativas de Bohao tengan un equivalente B2B ni que el programa esté libre de cualquier error.

El precio seleccionado se copia de Bohao al catálogo B2B sin modificar su valor y se trata como precio neto, sin impuestos, en B2B. Al importar un pedido, el Bridge consulta el IVA nativo de la categoría Bohao, calcula sus importes y los escribe en el pedido de Bohao; Bohao/ERP conserva la responsabilidad de validar el documento, preparar la expedición y emitir la factura. La escritura y recuperación se probaron en dos MySQL demo. Falta verificar en el propio programa Bohao que el pedido se muestra, se prepara y genera albarán correctamente en ambas versiones; las pruebas SQL no sustituyen esa comprobación nativa.

## Pruebas y ejecutable

```powershell
.\.venv\Scripts\python.exe -m pytest -q
# Pruebas de escritura exclusivamente en las BBDD demo del bridge:
$env:BOHAO_DEMO_TESTS='1'
$env:BOHAO_TEST_PORT='3337'
$env:BOHAO_TEST_DATABASE='bohao_sync_demo' # o bohao_v622_demo
$env:BOHAO_TEST_USER='root'
$env:BOHAO_TEST_PASSWORD=''
.\.venv\Scripts\python.exe -m pytest -q
.\build.ps1
```

Distribuye toda la carpeta `dist\NexofluxBohaoSync`, no únicamente el `.exe`. Conserva la carpeta de datos al actualizar y respalda MySQL y SQLite antes de reemplazar una instalación.
