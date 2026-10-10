# Revisión desde el HEAD anterior

Referencia B2B aprobada: `a694cd86478945dd119b7dff590b8d638a2f3c1f`. Cambios todavía sin commit: comparación del árbol de trabajo y nuevos archivos. Bridge nuevo revisado completo. Dos revisiones independientes mediante skill code-review, después de verificación del B2B en navegador.

## Standards

Cuatro hallazgos materiales: el hash completo REST rompía reimportaciones tras acuse/vínculo; expediciones normales generaban conflictos permanentes; los resúmenes IVA escapaban al hash y a comprobación InnoDB; trabajos transitorios completados crecían indefinidamente. Se respeta el aislamiento Organization de ADR 0001 y las aserciones atómicas de ADR 0003. No se identificaron otras infracciones documentadas duras.

Correcciones: proyección comercial explícita, actualización de progreso sin reescribir documento nativo, hash/resumen fiscal transaccional, y compactación de trabajos transitorios terminados conservando inbox de pedidos.

## Spec

Cinco errores concretos: cambios de cliente A→B→A se perdían por deduplicación histórica; categorías privadas no desactivaban productos; parciales bloqueaban cambios posteriores; perfiles fiscales especiales se inventaban como domésticos; recorte por falta de stock rompía la suma del ledger al cancelar. Sin expansión material de alcance.

Correcciones: nuevas identidades de trabajo con cache de contenido aplicado, privacidad de categoría y antecesores en cache/producto, progreso preservado, bloqueo de fiscalidad no verificada y movimientos de corrección adicionales para que ledger y disponible coincidan. Regresiones añadidas para reimportación, IVA local, progreso y conciliación de stock.

Persisten requisitos parciales de tarifas especiales, sucursales, lotes, agentes y anulación REST de expediciones; quedan explícitos en coverage.md. La aceptación nativa “el documento aparece y opera correctamente en Bohao” necesita ejecutarse en el programa real de las dos versiones.

Resumen por eje: Standards 4 hallazgos técnicos corregidos; Spec 5 errores técnicos corregidos y 2 requisitos parciales documentados. Mayor pendiente Standards: comprobación operativa del servicio; mayor pendiente Spec: aceptación nativa Bohao y mapeos comerciales adicionales.

Segunda revisión: Spec sin nuevos errores materiales. Standards encontró un documento local eliminado que podía aceptarse en progreso; se añadió comprobación de existencia transaccional en replay/progreso y regresión MySQL en ambos esquemas.
