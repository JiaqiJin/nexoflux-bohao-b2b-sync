# Validación realizada

Fecha: 2026-10-06. Windows local. Datos demo; sin despliegue del B2B ni modificación del esquema nativo original.

## Bases de datos

MySQL 8 aislado en `127.0.0.1:3337`, con dos BBDD InnoDB:

- `bohao_sync_demo`: copia de estructura de la instalación actual del PC y muestra de tres artículos/un cliente.
- `bohao_v622_demo`: CREATE permitidos del archivo suministrado `E:/company/nexoflux-bohao-backend/bohao_v622_schema.sql`, con muestra de columnas compartidas. Los DROP del dump no se ejecutan.

El mismo pedido B2B `PED-2026-0001`, creado y confirmado desde navegador, se importó y repitió en ambas:

| Esquema | Documento demo | Líneas | Unidades | IVA | Total |
| --- | --- | --- | --- | --- | --- |
| Actual | 900000000022 | 1 | 2 | 21 % | 2,4200 € |
| v6.22 | 900000000016 | 1 | 2 | 21 % | 2,4200 € |

La repetición devuelve el mismo documento. La importación no modifica el stock físico.

## Pruebas automatizadas

- Python: **19 pruebas pasadas**, incluidas seis integraciones MySQL sobre el esquema actual.
- Las **seis integraciones MySQL** pasaron también sobre v6.22.
- B2B: **65 pruebas pasadas en seis archivos**, para snapshots, stock, creación/revisión de pedidos y API pública de pedidos/clientes/stock.
- TypeScript API/web, oxlint API/web, ruff bridge/tests/tools y comprobación de formato de los últimos cambios: pasados.
- Build PyInstaller completo. Ejecutable iniciado en puerto temporal: UI y JS HTTP 200, cabeceras de protección presentes; un segundo proceso con la misma carpeta se cierra sin competir. Proceso temporal detenido después.

Regresiones específicas: acuse y vínculo posterior no rompen replay; progreso de expedición no reescribe documento; edición local del resumen IVA protegida; documento nativo eliminado detectado antes de acuse o progreso; cliente A→B→A; imagen cambiada con respuesta perdida sin duplicar ni borrar imagen online; recuperación de lease de proceso muerto; cola/cursor sobreviven a recrear State; compactación conserva inbox de pedidos; cancelación con déficit mantiene saldo y suma del ledger iguales.

Avisos existentes del entorno: deprecación de httpx en TestClient/Starlette y sourcemaps ausentes de Stripe al ejecutar Vitest. No produjeron fallos.

## Navegador y reinicio

Con `/agent-browser`: configuración guardada, preflight, sincronización, importación manual, reimportación, referencia nativa, incidencias, automático y paginación visible. Vista escritorio y móvil inspeccionadas. Sin errores runtime en la consola del bridge.

B2B local mediante `pnpm dev:web` y URL portless: sesión demo, configuración de catálogo externo, pedido de dos unidades. Captura local envejecida de forma controlada → envío rechazado con mensaje español; nueva lectura bridge → envío y confirmación permitidos. Consola con mensajes de desarrollo Vite/React, sin errores runtime de estos flujos.

Preferencia automática activada desde UI, proceso reiniciado y lanzado con `pythonw` del venv: automático conservado, nuevo ciclo completado y cero incidencias pendientes. Inicio al iniciar sesión registrado en HKCU para **la carpeta demo verificada**. La demo exige que sus servicios MySQL/B2B locales estén en ejecución; el registro del bridge no inicia esos dos servicios de desarrollo.

## Lo que falta comprobar

- Operación del documento dentro del programa nativo Bohao de ambas versiones: visualizar, preparar, convertir a albarán y verificar cálculos/series. No se ha sustituido esta aceptación por las pruebas SQL.
- Instalar/iniciar/detener mediante el Service Control Manager de Windows con elevación; solo se verificó el ejecutable normal. La sesión no era administradora.
- Mapeos especiales de coverage.md antes de habilitar esos datos; carga de miles de artículos y límites de referencias de expedición.

Evidencias locales de esta sesión en `.scratch/`: `dual-order-validation.json`, `orders-final.png`, `b2b-stale-stock.png`, `bridge-mobile.png` y `build-final.log`. No contienen claves en las capturas; las configuraciones y credenciales de demo permanecen fuera de Git.
