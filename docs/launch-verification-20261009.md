# Revisión del 9 de octubre de 2026

Estado: correcciones locales verificadas; sin despliegue ni escrituras en Cloudflare de producción. El usuario pidió aclarar primero el despliegue y el efecto de su cuenta gratuita.

## Correcciones y pruebas

Los cambios preparados del B2B incorporan stock por lotes y Options en la importación ZIP. Se añadieron en esta sesión dos correcciones de verificación: rutas Git con separadores POSIX en el comprobador de migraciones de Windows y cobertura del nuevo endpoint en la matriz de permisos REST.

- Bridge con MySQL 8 actual: 45 pruebas correctas, ninguna omitida.
- MySQL demo v6.22: 6 pruebas correctas; repetición, concurrencia, rollback y protección del documento.
- Ruff Bridge/tests/tools correcto.
- B2B: primera selección de 8 archivos, 93 correctas y una discrepancia entre 37 endpoints esperados y 38 documentados. Se corrigió la matriz de permisos; las 7 pruebas de ese archivo pasaron al repetirlas. La prueba adicional de 5000 variantes y 200 lotes REST también pasó. En total 95 pruebas distintas correctas de esta selección y escala, tras la corrección.
- El intento inicial de toda la suite web se detuvo al no completar; no se certifica la suite completa.
- `pnpm check`: 32 tareas correctas y comprobación de migraciones correcta después de corregir rutas Windows.
- Compilación de producción del cliente y Worker: correcta.
- Imágenes del catálogo B2B: 8 pruebas correctas; subida y protección de imágenes verificadas por la suite local. Total seleccionado B2B: 103 pruebas distintas correctas.
- Ejecutable Windows recompilado correctamente en `dist/release-20261009/NexofluxBohaoSync`.
- Prueba del ejecutable con carpeta demo nueva y automático desactivado: portada, JavaScript y estado HTTP 200. Paquete `dist/NexofluxBohaoSync-release-20261009.zip`, SHA-256 `bb98bcde5eee9c69bf3b9907578415c993a7824ad16d6254075436f86a4e10ce`.
- Recorrido HTTP local real: MySQL → ZIP → preview/process B2B → adopción del Bridge → ciclo. 23 filas, 3 productos, 2 clientes, 14 operaciones completadas, ninguna pendiente o bloqueada; cero PUT de catálogo/clientes sin cambios. El dato fiscal de la demo modificado por el ensayo se restauró al finalizar.

La base usada es exclusivamente `127.0.0.1:3337 / bohao_sync_demo`, con MySQL 8.0.43 y carpeta `.scratch/mysql-data`. No se inició el MySQL nativo de Bohao ni se escribió en su base comercial.

## Cloudflare y el plan gratuito

Se identificó por consulta autenticada de solo lectura el Worker existente, conectado a la D1 europea y al bucket R2 de producción. Sus bindings y configuración se guardaron privadamente en `.scratch`; no incluir secretos/configuración privada en entregables públicos.

La API de suscripciones devolvió HTTP 403. `workers/account-settings` devolvió `default_usage_model=standard`, lo que no basta para certificar el plan contratado. No se ha cambiado plan ni comprado ningún servicio.

La implementación actual de importación procesa hasta 100 registros por petición y declara su dependencia del límite de 1000 consultas D1 por invocación. Stock batch acepta hasta 25 variantes con varias operaciones D1 por variante. Workers Free tiene un límite de CPU de 10 ms y D1 limita las consultas por invocación a 50, frente a 1000 con Workers Paid. Reducir el tamaño de ZIP por sí solo no demuestra que se cumplan todos esos límites: descompresión, validación, hashes, lectura y escritura también consumen recursos.

Referencias oficiales verificadas: https://developers.cloudflare.com/workers/platform/limits/ y https://developers.cloudflare.com/d1/platform/limits/.

Antes de publicar hay que confirmar el plan **Workers**, distinto del plan del dominio/zona, y elegir una Organization de pruebas autorizada. La prueba de escala en D1 local no mide ni aplica los límites de CPU del plan Free en producción. No se ejecutará una actualización de pago sin autorización.

## Pendiente

- Publicar los cambios del B2B con los requisitos de despliegue del proyecto y verificar el contrato vivo y las operaciones autenticadas.
- Prueba aislada en Cloudflare: ZIP, repetición de importación, cambios de precio/producto/cliente, imágenes, stock, confirmación de pedido y recuperación tras corte.
- Verificar el pedido y su albarán parcial/final dentro del programa Bohao nativo y medir frescura del stock con volumen real.
- Verificación visual del flujo de importación: se cargó la página local en navegador, pero el intento de navegación a login falló por conexión. El recorrido de importación comprobado aquí es HTTP, no una aceptación visual completa.

No se afirma que todas las funcionalidades o la operación productiva estén aceptadas.
