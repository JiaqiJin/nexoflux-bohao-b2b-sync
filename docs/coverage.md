# Cobertura de datos y decisiones

Fecha: 2026-10-06. Ambos esquemas: actual y v6.22. Esta matriz concreta el alcance de “todos los datos” y evita aparentar equivalencias inexistentes.

| Datos | Estado y autoridad |
| --- | --- |
| Categorías | Bohao → B2B, jerarquía, identidad estable, nombres duplicados distinguibles, privacidad heredada. |
| Productos | Nombre ES/ZH, categoría, descripción disponible, actividad. Marca y lotTracked online conservados. Bajas físicas requieren revisión; no se borran pedidos históricos. |
| Variantes | Cero, una o dos propiedades; combinaciones exactas. Reglas de cantidad y unidades fraccionarias se bloquean con diagnóstico. |
| Unidades y barcodes | Unidad base y pack entero; barcodes de artículos sin propiedades. No se atribuye un barcode general a varias variantes distintas. |
| Precios | Una columna Bohao elegida → tarifa base B2B, con conversión IVA opcional y precisión monetaria. Coste no se publica. Tarifas adicionales y precios particulares requieren mapeo adicional. |
| Imágenes | Imagen principal DibujoID PNG/JPEG, deduplicada por contenido. Galerías múltiples y formatos nativos adicionales no se replican. |
| Clientes | Identidad fiscal, ES/ZH, idioma ES, dirección principal, contacto, descuento simple, crédito y actividad Bohao → B2B. Datos online adicionales se conservan. Nuevas altas B2B se incorporan al importar su pedido y se vinculan por External Id. |
| Fiscalidad del cliente | Perfil doméstico español estándar. Clientes extranjeros, códigos nativos fiscales especiales y descuentos compuestos se bloquean hasta verificar su significado. No se inventa un perfil por defecto para esos casos. El perfil ya existente en B2B se conserva. |
| Sucursales y direcciones múltiples | Direcciones existentes B2B se conservan; clientesucursal no se sincroniza aún. Dirección congelada del pedido se conserva en Observacion y payload completo. |
| Pedidos confirmados | B2B → cabecera/líneas Bohao, unidades base, precios congelados, descuentos, IVA/recargo, total, referencia, notas y entrega solicitada. No afecta al stock físico. |
| Reintentos y revisiones | Vínculo y documento atómicos en MySQL. Misma versión comercial idempotente aunque cambie el acuse o External Id del cliente. Cambios comerciales locales y resúmenes IVA modificados generan conflicto. Revisiones completas conservadas. |
| Cancelación | Anula el documento importado antes de expediciones si no hay edición local conflictiva. Una cancelación con preparación o expediciones requiere revisión. |
| Expedición y cierre | Albaranes de pedidos importados → Shipment B2B; parciales exactos e idempotentes. Progreso remoto actualiza vínculo/historial sin reescribir documento preparado. Cierre B2B queda en historial; no se inventan códigos nativos ProgressStatus. |
| Anulación de albarán | Detectada. Anular Shipment en la UI B2B y reintentar; REST aún no ofrece su anulación. Albaranes editados tras publicar requieren conciliación. |
| Stock | Saldo físico de almacenes seleccionados, margen, reservas y expediciones leídos coherentemente. Capturas monotónicas y frescas; protección contra doble descuento y ledger conciliado. Máximo 2000 referencias de expedición por captura por límite API actual. |
| Stock por lote y caducidad | Bloqueado para catálogo externo administrado por este bridge; no hay equivalente de stock por lote demostrado en Bohao. |
| Agentes, representantes y comisiones | Pertenencia y cálculo conservados en B2B. No se crean usuarios desde empleados Bohao; el vínculo de agentes requiere ampliación. |
| Pedidos nativos Bohao e histórico | Conservados en Bohao. El REST B2B no crea pedidos operativos; no se transforman en reservas nuevas. |
| Facturas, cobros, POS, proveedores y compras | Conservados en Bohao; B2B no dispone de equivalente completo. |
| Users, permisos, Billing y API Keys | Conservados en sus sistemas. No se copian contraseñas ni permisos de usuario. |

No mezclar dos instalaciones en una carpeta de estado. Una Organization con expediciones anteriores debe conciliar su corte inicial: el B2B rechaza la captura inicial si faltan referencias de expediciones ya reflejadas en físico. El modo piloto permite limitar artículos antes de publicar todo el catálogo compatible.
