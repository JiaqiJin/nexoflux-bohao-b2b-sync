# Comprobación previa al lanzamiento del 9 de octubre de 2026

## Resultado: lanzamiento completo bloqueado

Comprobación de solo lectura contra `https://b2b.nexoflux.dev/api/v1/reference/openapi.json`: HTTP 200, 32 rutas. No contiene `/organizations/{organizationId}/stock/external-snapshots`; sí contiene el endpoint individual. El Bridge actual exige la ruta por lotes en preflight y al empezar cada ciclo. Con este contrato publicado producirá `STOCK_BATCH_API_REQUIRED` y no ejecutará el ciclo. Es necesario actualizar el B2B y volver a verificar el contrato y una petición autenticada en una Organization de pruebas.

No se han desplegado cambios ni modificado datos de producción en esta revisión. La URL comprobada es el dominio de producción definido en `packages/infra/alchemy.run.ts` del proyecto B2B; si el cliente usa otro dominio, necesita su propia comprobación.

## Pruebas repetidas en esta revisión

- Bridge: 39 correctas, 6 omitidas; Ruff correcto.
- Intento explícito de las 6 pruebas MySQL: 6 errores de preparación por conexión rechazada en `127.0.0.1:3337`. La demo está apagada; estos errores no demuestran un defecto en importación, pero tampoco validan hoy la escritura SQL.
- B2B local: 39 correctas en `public-api-orders`, `public-api-stock-customers`, `external-stock` y `public-api-catalogue`. Incluyen repetición de envíos, reservas, repetición de capturas y resultados parciales de lotes. No son pruebas contra producción.

## Flujo y tiempos

La secuencia ZIP → importar todos los paquetes en modo plataforma → modo externo → comprobar/adoptar → sincronizar imágenes/stock → activar automático coincide con la implementación. Usar la misma Organization y conservar la carpeta de datos. Para una primera carga, usar una Organization vacía o conciliar identidades existentes antes de importar.

El intervalo automático predeterminado es 60 segundos después del ciclo anterior. Durante el procesamiento de la cola, se consulta el feed de pedidos aproximadamente cada 5 segundos; ese plazo no incluye preparación inicial, latencia ni operaciones en curso. La renovación prioritaria de stock se programa 60 segundos después de la vuelta anterior. No hay garantía de propagación instantánea ni de latencia máxima con volumen real sin medirla.

## Duplicados y aceptación pendiente

La importación SQL vincula installation/Organization/order mediante clave primaria, utiliza transacciones, `FOR UPDATE`, secuencia bloqueada y reintentos tras deadlock o conflicto de clave. Las repeticiones reutilizan el documento existente. El catálogo utiliza External IDs persistentes y la carga ZIP adopta esas identidades. Estas protecciones dependen de conservar la identidad y los vínculos de la instalación.

Antes de habilitar ventas completas:

1. Actualizar B2B y comprobar contrato, clave, permisos, modo externo y resultados de importación ZIP en la Organization correcta.
2. Importar un pedido piloto, repetir sincronización y reiniciar el Bridge: un solo documento y un solo cliente vinculados.
3. Abrir y preparar ese pedido en Bohao nativo; comprobar unidades, precio, descuentos, IVA/recargo y total. Crear albarán parcial y final; verificar reservas y envíos sin duplicarlos ni descontar dos veces el stock.
4. Medir frescura de stock con el volumen real: observaciones aceptadas de cada variante por debajo de cinco minutos con margen. Verificar bloqueo al desconectar y recuperación al reconectar.
5. Verificar arranque automático en el PC definitivo, copia de seguridad y carpeta de datos persistente.

La revisión confirma un bloqueo de compatibilidad desplegada y pruebas locales favorables; no certifica ausencia de errores ni aceptación operativa de producción.
