# Validación local de Bohao y B2B, 10 de octubre de 2026

## Alcance y seguridad

Se conectó con PyMySQL a `127.0.0.1:3306/bohaosupermarket3`. Las consultas a producción fueron de solo lectura: inspección del esquema, conteos, búsqueda de referencias rotas, CIF ausentes y privilegios. La carga inicial también se ejecutó en modo de lectura y escribió únicamente en un directorio temporal local, eliminado después de cada intento. No se modificaron documentos, existencias, clientes, artículos, categorías ni permisos de MySQL.

## Resultado de la base activa

| Comprobación | Resultado |
|---|---:|
| Esquema detectado | Actual |
| Artículos | 2.047 |
| Clientes | 59 |
| Registros de stock | 69 |
| Pedidos y líneas de pedido | 0 |
| Stock con cantidades fraccionarias | 0 |
| Artículos sin categoría correspondiente | 2 |
| Clientes sin CIF / identificador fiscal | 5 |
| Tablas `nexoflux_sync_*` existentes | 0 |
| Privilegio `CREATE` para el usuario conectado | No |

Los artículos con categoría inexistente son `21C3992E-3` y `24E23111-1` (`ClaseID = 0`). Los clientes sin identificador fiscal son `1`, `10043`, `10044`, `10047` y `10048`. La exportación completa se detiene primero en el artículo `21C3992E-3`; al limitarla a un artículo con categoría válida, se detiene en el cliente `1`.

No se deben inventar categorías fiscales ni identificadores fiscales para forzar una carga. Corrige la categoría de esos artículos y completa el dato fiscal de esos clientes en Bohao, o define una regla aprobada por el negocio antes de publicar esos registros.

**Corrección posterior de la carga inicial:** ahora un artículo o cliente individual con datos no válidos se omite del ZIP con su tipo, ID y motivo en el informe de la carga; los registros válidos continúan. El informe es visible en la consola y queda acotado a 100 ejemplos, con el total completo. Si no queda ningún producto ni cliente exportable, se cancela la generación y se limpian sus archivos. Esta mejora evita que cinco CIF ausentes bloqueen miles de productos, pero no corrige los registros fuente: durante el ciclo normal siguen apareciendo como operaciones bloqueadas hasta que se reparen en Bohao.

## Escrituras y pedidos

`Bohao.initialize()` necesita crear cuatro tablas auxiliares y falla sin `CREATE`. Se verificó que siguen ausentes y que el usuario no tiene ese privilegio. La escritura de pedidos y la inicialización de esas tablas no se pudieron validar contra esta base; tampoco hay pedidos reales que permitan probar una repetición. El usuario `Admin/1111` es del programa de mantenimiento, no una cuenta MySQL y no concede esos permisos.

Las credenciales del ejemplo `docs/bohao-docs/flask-server-complete.py` ahora se leen de variables de entorno; no se guardan en el código. `docs/bohao-docs/bohao_db_info.md` distingue la cuenta de mantenimiento de la de MySQL y refleja el host, puerto y versión observados en este equipo.

## Compatibilidad v6.22

El dump entregado está en [`bohao-v622-schema.sql`](bohao-v622-schema.sql). El Bridge detecta la versión por las columnas y trata `pedidoclienteivatotal` como opcional, porque esa tabla no está presente en v6.22. La tabla de resumen solo se escribe en el esquema actual cuando existe. Las pruebas MySQL de ambos esquemas están en `tests/test_mysql.py`; en esta sesión se verificó la compatibilidad de la suite general del Bridge, pero las seis pruebas que escriben en MySQL se omitieron: no había un servidor demo aislado escuchando en el puerto 3337. No se intentaron escrituras contra la producción para sustituir esas pruebas.

La BBDD activa corresponde al esquema actual, no a v6.22. No se configuró URL, Organization ni API key del B2B en el Bridge local, por lo que no se hicieron llamadas a una Organization de producción.

## Corrección y pruebas de esta sesión

`bridge/initial_load.py` cerraba la transacción SQLite, pero no cerraba explícitamente la conexión ni borraba una generación incompleta al fallar el mapeo. Ahora cierra el handle en éxito y excepción y elimina las ZIP y `handoff.db` de una exportación fallida. Las regresiones cubren tanto artículo sin categoría como cliente sin identificador fiscal.

Verificación ejecutada:

- Bridge, tras la corrección de exportación parcial: **43 pasadas, 6 omitidas**, una advertencia deprecada de Starlette/httpx.
- Ruff en `bridge`, `tests` y `tools`: **sin hallazgos**.
- Producción Bohao: conexión e inspección de solo lectura; dos intentos de exportación fallaron en los datos identificados y dejaron **cero generaciones temporales**.

El siguiente paso para validar escrituras es conceder al usuario dedicado del Bridge permisos limitados para crear y mantener las cuatro tablas auxiliares y escribir únicamente los documentos de pedidos asociados. Después, prueba pedido, repetición y visualización dentro del programa nativo Bohao en un entorno aislado antes de habilitar producción.

## Revisión adicional de precios e IVA

La revisión del código confirma el contrato esperado: el importe de la tarifa seleccionada en Bohao se copia sin cambios al catálogo B2B, y el B2B lo interpreta como precio neto sin impuestos. Por tanto, un precio de `1,0000 €` llega como `1,0000 €`; no se suma ni se descuenta IVA durante la publicación. El antiguo ajuste `prices_include_tax` no tenía efecto en la exportación y se eliminó para no sugerir que el Bridge convierte precios brutos.

Al importar un pedido net-only, el **Bridge** (no el servidor B2B) lee el tipo de IVA de la categoría del artículo en Bohao, calcula los importes a partir del neto confirmado y los escribe en el encabezado y en las líneas del pedido nativo; también escribe `pedidoclienteivatotal` cuando existe. Ejemplo de código con tarifa neta de `1,00 €` e IVA del `21 %`: base `1,00 €`, IVA `0,21 €`, total `1,21 €`. El precio del catálogo no se altera. Esto prepara el pedido para Bohao; todavía falta verificar en la aplicación nativa que Bohao lo muestra y lo procesa como espera el negocio.

Límites detectados en el importador net-only: solo admite clientes españoles sin perfil fiscal especial; los tipos de IVA de línea admitidos son 4 %, 10 % y 21 %; el recargo se fija en cero. Aunque la exportación de categorías puede representar IVA exento, el importador de pedidos actualmente rechaza el 0 %. No debe considerarse validado el flujo para exentos, otros tipos, clientes extranjeros, regímenes especiales o recargo de equivalencia hasta acordar e implementar esas reglas. v6.22 conserva IVA por línea y total de cabecera, pero no tiene la tabla opcional de resumen.

## Prueba real adicional, solo lectura

La contraseña de MySQL no estaba guardada en la configuración local. La captura proporcionada por el usuario permitió recuperar una cuenta local y establecer una conexión PyMySQL de solo lectura a `127.0.0.1:3306/bohaosupermarket3`. La contraseña se mantuvo en memoria y no se guardó en archivos. No se conectó al B2B de producción ni se hicieron escrituras MySQL.

Resultados revalidados: MySQL `5.7.44`, esquema `Actual`, 2.047 artículos, 59 clientes, 69 filas de stock, cero pedidos y líneas, cero tablas `nexoflux_sync_*` y sin permisos `CREATE`, `ALTER` ni `DROP`. `SHOW GRANTS` también revela `SELECT, INSERT, UPDATE, DELETE` sobre toda la base `bohaosupermarket3`, no solo sobre las tablas de sincronización. Las tres tablas de pedidos inspeccionadas son InnoDB y `pedidoclienteivatotal` existe. `tables_list.md` quedó actualizado contra las 190 tablas activas; `table_definitions.md` incorporó la tabla `abono` que faltaba y se corrigió el nombre `ivatipo`.

Se encontraron de nuevo los artículos `21C3992E-3` y `24E23111-1` con categoría inexistente, y los clientes `1`, `10043`, `10044`, `10047` y `10048` sin CIF/identificador fiscal. La exportación completa real se bloqueó en el primer artículo y dejó cero generaciones temporales. Una segunda exportación real restringida al artículo válido `01479A18-0` se bloqueó al llegar al cliente `1` y también dejó cero generaciones temporales.

Ese artículo tiene `PrecioMayor=1,0000` y su categoría tiene IVA `21,000`. El mapeo real de catálogo produjo `unitPrice=10000` (1,0000 € en unidades B2B de 1/10.000 €). Con la tasa nativa consultada, el cálculo del pedido dio base `100` céntimos, IVA `21` céntimos y total `121` céntimos. Esto comprueba con datos reales el mapeo de precio y la tasa, pero **no** crea ni importa un pedido en producción.

## Revisión del contenido de `docs/bohao-docs`

- `bohao_db_info.md`, `db-relationships.md` y las definiciones de `pedidocliente`, `pedidoclientearticulo` y `pedidoclienteivatotal` concuerdan en los campos necesarios para el flujo de pedidos. La fórmula de la especificación del TPV (`Precio × cantidad × (1 + IVA/100)`) respalda que `Precio` es la base antes del IVA. El inventario de tablas ahora refleja la base activa; la estructura incluye las tablas compartidas con el dump v6.22 y está marcada como dependiente de la instalación.
- `api-specification.md`, `flask-server-complete.py`, `mobile_app_guide.md` y `backend_bridge_setup.md` describen una API PDA/TPV antigua, **no** la API B2B ni el Bridge actual. Se corrigieron las referencias a MySQL 8.0 para reflejar que la versión depende de la instalación, se alineó la ruta de búsqueda de artículos con el servidor y se aclaró que la especificación incluye endpoints planificados. Una comparación de rutas todavía encuentra 16 combinaciones método/ruta documentadas que no están en el servidor incluido; verifica esas rutas contra el backend que realmente ejecuta Bohao antes de usarlas. `/api/proveedores` ya estaba marcado como pendiente.
- El servidor PDA se mantiene limitado a una red local aislada: usa CORS `*`, HTTP sin TLS, tokens en memoria y carece de rate limiting. Se quitó el modo debug y ahora el ejemplo inicia con Waitress; también se dejó de devolver el error SQL detallado al cliente. Su sintaxis compila, pero no pudo comprobarse el arranque en esta instalación porque el entorno `.venv` del Bridge no tiene Flask instalado. No se usó ni desplegó esa API en esta prueba.
- `pda-app-architecture.md` distingue correctamente el estado real de la arquitectura objetivo y documenta módulos/stubs aún incompletos; no es evidencia de que el Bridge B2B esté instalado dentro de Bohao.

La cuenta visible en la captura se usó solo en memoria para las consultas anteriores y no se escribió en archivos. Como tiene escritura y borrado en toda la base, no la uses como cuenta permanente del Bridge: conviene rotar su contraseña y crear una cuenta dedicada con permisos limitados a las tablas que realmente necesita el Bridge. No se probaron escrituras de pedido con esta cuenta.
