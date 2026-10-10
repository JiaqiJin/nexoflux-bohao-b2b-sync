const $ = (selector) => document.querySelector(selector);
const messages = {
  zh: {
    pageTitle: "Nexoflux · Bohao 同步", brandHome: "Nexoflux 首页", brandSub: "Bohao 同步", localConnection: "本地连接", mainNav: "主导航",
    navDashboard: "概览", navOrders: "订单", navErrors: "问题", navSettings: "设置", localService: "本地服务", localData: "数据在本机同步。",
    modeAuto: "自动同步已开启", modePaused: "自动同步已暂停", dashEyebrow: "全部集中在一处", dashTitle: "业务，已连接。", dashSubtitle: "本地商品目录和线上订单，无需重复录入。",
    syncNow: "立即同步", syncing: "同步中…", toggleOn: "暂停自动同步", toggleOff: "开启自动同步",
    connectTitle: "开始连接你的 Bohao", connectDetail: "开始前请先配置连接并检查数据。", connectReady: "同步已准备就绪",
    lastCycle: "上次周期：{date}", needsAttention: " · 有操作需要关注", setupConnection: "配置连接",
    initialTitle: "文件方式首次导入", initialHelp: "1. 从 Bohao 生成并下载数据包。2. 在 B2B 中进入「集成」→「导入」，用平台模式的目录完成全部数据包的导入。3. 切换为外部模式，然后在这里检查导入结果。完成前自动同步保持暂停。",
    initialPrepare: "生成 ZIP 数据包", initialAdopt: "检查 B2B 导入", initialNone: "没有文件方式的首次导入。",
    initialPrivacy: "数据包包含商业和客户数据，但不含密码。库存和图片会在导入后的同步中发布。",
    init_preparing: "正在生成数据包…", init_awaiting_import: "请在 B2B 中导入全部数据包，然后在这里检查结果。", init_checking: "正在检查已导入的记录…",
    init_ready: "导入已通过检查。立即同步即可发布最新库存和图片。", init_failed: "无法生成首次导入数据。",
    initialSummary: " · {products} 个商品 · {customers} 位客户", initialSkipped: " · {n} 条记录未导出（原因如下）", skippedItem: "{kind} {id}：{reason}", skippedMore: "另有 {n} 条未显示",
    downloadPackage: "下载 {file}（{n} 条记录）",
    mDone: "已完成操作", mDoneHelp: "已保存，可恢复", mPending: "待处理操作", mPendingHelp: "断网时会保留", mBlocked: "需要关注", mBlockedHelp: "附有解决说明",
    syncScope: "同步范围", dProducts: "商品和价格", dCustomers: "客户", dCustomersNote: "Bohao → B2B · 有订单时新建", dOrders: "已确认订单",
    dShipments: "关联出库", dShipmentsNote: "Bohao 出库单 → B2B", dStock: "可用库存", dStockNote: "库存 − 线上预留",
    syncHelp: "不兼容的记录会显示在「问题」中，不会被自动修正或悄悄丢弃。", activity: "最近活动", firstSyncEvent: "首次同步后会显示在这里。", neverSynced: "尚未同步",
    ordersEyebrow: "从线上到柜台", ordersTitle: "订单", ordersSubtitle: "导入已确认的订单，并查看对应的 Bohao 单号。", refreshOrders: "刷新订单",
    thOrder: "订单", thCustomer: "客户", thB2BStatus: "B2B 状态", thBohao: "Bohao", thAmount: "预估金额", thAction: "操作",
    ordersConfigure: "配置 B2B 连接后即可查看订单。", prevPage: "上一页", nextPage: "下一页", ordersPage: "第 {n} 页", noOrders: "此组织中没有订单。",
    orderImport: "立即导入", orderUpdate: "更新", orderNotImported: "未导入", estimated: "（预估）", orderQueued: "订单已加入导入队列。请在活动和问题中查看。",
    st_pending: "待处理", st_confirmed: "已确认", st_partially_shipped: "部分发货", st_shipped: "已发货", st_completed: "已完成", st_cancelled: "已取消",
    errorsEyebrow: "不丢失工作", errorsTitle: "问题", errorsSubtitle: "请按提示的原因处理，然后重试该操作。", retryPending: "重试待处理项", noErrors: "没有待处理的问题。",
    errorItem: "操作 {id} · {kind}", attempts: "{n} 次尝试 · {state}", needsReview: "需要检查", retryWaiting: "等待重试",
    settingsEyebrow: "初始设置", settingsTitle: "连接你的系统。", settingsSubtitle: "保存连接，并在同步前进行检查。", legend1: "1 · 本地网络中的 Bohao",
    mysqlHost: "MySQL 服务器", port: "端口", database: "数据库", mysqlUser: "MySQL 用户", password: "密码", passwordPlaceholder: "留空则保留已配置的密码",
    warehouses: "线上销售仓库", warehousesHelp: "只发布这些仓库的库存。", legend2: "2 · 你的 B2B 平台", b2bUrl: "B2B 地址", orgId: "Organization 标识符",
    apiKeyHelp: "请使用具备目录、客户、库存、订单和变更权限的组织密钥。B2B 目录必须处于外部模式。", priceColumn: "发布价格",
    priceHelp: "所选 Bohao 价格原样发布，B2B 将其视为不含税净价。导入订单时 Bridge 按 Bohao 商品类别的 IVA 计算订单税额并写入 Bohao；目录价格不变。",
    opt_PrecioMayor: "批发价", opt_PrecioDetalle: "零售价", opt_PrecioInternet: "网络价", opt_PrecioSocio: "会员价", opt_PrecioEspecial: "特价", opt_PrecioAmigo: "朋友价", opt_PrecioDomicilio: "送货价", opt_PrecioOferta: "促销价",
    syncOptions: "同步选项", interval: "间隔（秒）", safetyStock: "库存安全余量（件）", pilotArticles: "试点商品（可选）", pilotPlaceholder: "留空表示全部；用逗号分隔编码",
    localCa: "本地 CA 证书（可选）", localCaPlaceholder: "仅用于本地开发的 HTTPS", b2bBlockHelp: "若某商品超过五分钟未收到库存，B2B 会阻止该商品的新订单。",
    saveConfig: "保存配置", preflight: "检查连接和数据", preflightTitle: "数据检查", preflightDone: "检查完成，未修改任何商业数据。",
    pf_articulo: "商品", pf_cliente: "客户", pf_stock: "库存余额", pf_pedidocliente: "Bohao 订单", pf_pedidoclientearticulo: "订单行",
    pf_fractional_stock: "小数数量库存余额", pf_variants: "带属性的商品", pf_b2b: "B2B 连接", pf_bohao_schema: "检测到的 Bohao 版本",
    notifyOffline: "无法连接本地服务，请确认服务已启动。", apiFallback: "无法完成操作", syncStarted: "同步已开始。可以在这里查看进度。",
    prefSaved: "同步偏好已保存。", retryReady: "待处理操作已准备重试。", configSaved: "配置已保存。现在请检查连接。",
    initPrepareMsg: "正在生成首次导入数据。自动同步已暂停。", initAdoptMsg: "正在检查导入结果，通过后再继续同步。",
    footerBrand: "Nexoflux Bohao 同步", footerVersion: "支持 Bohao 当前版本 v6.22 · v0.1.0",
  },
  es: {
    pageTitle: "Nexoflux · Bohao Sync", brandHome: "Nexoflux inicio", brandSub: "BOHAO SYNC", localConnection: "TU CONEXIÓN LOCAL", mainNav: "Navegación principal",
    navDashboard: "Resumen", navOrders: "Pedidos", navErrors: "Incidencias", navSettings: "Configuración", localService: "Servicio local", localData: "Los datos se sincronizan desde este PC.",
    modeAuto: "Automático activo", modePaused: "Automático pausado", dashEyebrow: "TODO EN UN MISMO LUGAR", dashTitle: "Tu negocio, conectado.", dashSubtitle: "Catálogo local y pedidos online, sin trabajo duplicado.",
    syncNow: "Sincronizar ahora", syncing: "Sincronizando…", toggleOn: "Pausar automático", toggleOff: "Activar automático",
    connectTitle: "Vamos a conectar tu Bohao", connectDetail: "Configura las conexiones y comprueba los datos antes de empezar.", connectReady: "La sincronización está preparada",
    lastCycle: "Último ciclo: {date}", needsAttention: " · Hay operaciones que necesitan atención", setupConnection: "Configurar conexión",
    initialTitle: "Carga inicial por archivo", initialHelp: "1. Genera y descarga los paquetes de Bohao. 2. En B2B, abre Integración → Importar y completa todos los paquetes con el catálogo en modo plataforma. 3. Cambia a modo externo y comprueba la importación aquí. El automático queda pausado hasta terminar.",
    initialPrepare: "Generar paquetes ZIP", initialAdopt: "Comprobar importación B2B", initialNone: "Sin carga inicial por archivo.",
    initialPrivacy: "Los paquetes contienen datos comerciales y de clientes. No incluyen contraseñas. El stock fresco y las imágenes se publican al sincronizar después de la importación.",
    init_preparing: "Generando paquetes…", init_awaiting_import: "Importa todos los paquetes en B2B y comprueba el resultado aquí.", init_checking: "Comprobando los registros importados…",
    init_ready: "Importación comprobada. Sincroniza ahora para publicar stock fresco e imágenes.", init_failed: "No se pudo generar la carga inicial.",
    initialSummary: " · {products} productos · {customers} clientes", initialSkipped: " · {n} registros no exportados (consulta el motivo)", skippedItem: "{kind} {id}: {reason}", skippedMore: "Hay {n} registros omitidos más",
    downloadPackage: "Descargar {file} ({n} registros)",
    mDone: "Operaciones completadas", mDoneHelp: "Guardadas y recuperables", mPending: "Operaciones pendientes", mPendingHelp: "Se conservan si se corta Internet", mBlocked: "Necesitan atención", mBlockedHelp: "Con una explicación para resolverlas",
    syncScope: "Qué se sincroniza", dProducts: "Productos y precios", dCustomers: "Clientes", dCustomersNote: "Bohao → B2B · altas con pedidos", dOrders: "Pedidos confirmados",
    dShipments: "Expediciones vinculadas", dShipmentsNote: "Albaranes Bohao → B2B", dStock: "Stock disponible", dStockNote: "Existencias − reservas online",
    syncHelp: "Los registros incompatibles aparecen en Incidencias. No se corrigen ni se descartan en silencio.", activity: "Actividad reciente", firstSyncEvent: "Tu primera sincronización aparecerá aquí.", neverSynced: "Todavía no se ha sincronizado",
    ordersEyebrow: "DEL ONLINE AL MOSTRADOR", ordersTitle: "Pedidos", ordersSubtitle: "Importa los pedidos confirmados y consulta su referencia Bohao.", refreshOrders: "Actualizar pedidos",
    thOrder: "Pedido", thCustomer: "Cliente", thB2BStatus: "Estado B2B", thBohao: "Bohao", thAmount: "Importe estimado", thAction: "Acción",
    ordersConfigure: "Configura la conexión B2B para consultar tus pedidos.", prevPage: "Anterior", nextPage: "Siguiente", ordersPage: "Página {n}", noOrders: "No hay pedidos en esta organización.",
    orderImport: "Importar ahora", orderUpdate: "Actualizar", orderNotImported: "Sin importar", estimated: " estimado", orderQueued: "Pedido añadido a la importación. Consulta Actividad e Incidencias.",
    st_pending: "Pendiente", st_confirmed: "Confirmado", st_partially_shipped: "Enviado parcialmente", st_shipped: "Enviado", st_completed: "Completado", st_cancelled: "Cancelado",
    errorsEyebrow: "SIN PERDER TRABAJO", errorsTitle: "Incidencias", errorsSubtitle: "Resuelve el motivo indicado y vuelve a intentar la operación.", retryPending: "Reintentar pendientes", noErrors: "No hay incidencias pendientes.",
    errorItem: "Operación {id} · {kind}", attempts: "{n} intentos · {state}", needsReview: "Necesita revisión", retryWaiting: "Reintento pendiente",
    settingsEyebrow: "CONFIGURACIÓN INICIAL", settingsTitle: "Conecta tus sistemas.", settingsSubtitle: "Guarda la conexión y haz una comprobación antes de sincronizar.", legend1: "1 · Bohao en tu red local",
    mysqlHost: "Servidor MySQL", port: "Puerto", database: "Base de datos", mysqlUser: "Usuario MySQL", password: "Contraseña", passwordPlaceholder: "Se conserva la contraseña configurada si lo dejas vacío",
    warehouses: "Almacenes para venta online", warehousesHelp: "Solo se publicará el stock de estos almacenes.", legend2: "2 · Tu plataforma B2B", b2bUrl: "Dirección del B2B", orgId: "Identificador de Organization",
    apiKeyHelp: "Usa una clave de tu organización con permisos para catálogo, clientes, stock, pedidos y cambios. El catálogo B2B debe estar en modo externo.", priceColumn: "Precio que publicarás",
    priceHelp: "El precio seleccionado se copia de Bohao sin cambiarlo y B2B lo trata como neto, sin impuestos. Al importar el pedido, Bridge calcula el IVA según la categoría nativa de Bohao y lo escribe en el pedido; el precio del catálogo no cambia.",
    opt_PrecioMayor: "Mayorista", opt_PrecioDetalle: "Detalle", opt_PrecioInternet: "Internet", opt_PrecioSocio: "Socio", opt_PrecioEspecial: "Especial", opt_PrecioAmigo: "Amigo", opt_PrecioDomicilio: "Domicilio", opt_PrecioOferta: "Oferta",
    syncOptions: "Opciones de sincronización", interval: "Intervalo (segundos)", safetyStock: "Margen de stock (unidades)", pilotArticles: "Artículos de un piloto (opcional)", pilotPlaceholder: "Vacío para todos · códigos separados por comas",
    localCa: "Certificado CA local (opcional)", localCaPlaceholder: "Solo para HTTPS de desarrollo local", b2bBlockHelp: "El B2B bloquea nuevos pedidos de un artículo si pasan cinco minutos sin recibir su stock.",
    saveConfig: "Guardar configuración", preflight: "Comprobar conexiones y datos", preflightTitle: "Comprobación de datos", preflightDone: "Comprobación completada sin modificar datos comerciales.",
    pf_articulo: "Artículos", pf_cliente: "Clientes", pf_stock: "Saldos de stock", pf_pedidocliente: "Pedidos Bohao", pf_pedidoclientearticulo: "Líneas de pedido",
    pf_fractional_stock: "Saldos con cantidades decimales", pf_variants: "Artículos con propiedades", pf_b2b: "Conexión B2B", pf_bohao_schema: "Versión de Bohao detectada",
    notifyOffline: "No hay conexión con el servicio local. Comprueba que está iniciado.", apiFallback: "No se pudo completar la operación", syncStarted: "Sincronización iniciada. Puedes consultar el progreso aquí.",
    prefSaved: "Preferencia de sincronización guardada.", retryReady: "Operaciones pendientes preparadas para reintentar.", configSaved: "Configuración guardada. Ahora comprueba las conexiones.",
    initPrepareMsg: "Generando carga inicial. El automático queda pausado.", initAdoptMsg: "Comprobando la importación antes de continuar la sincronización.",
    footerBrand: "Nexoflux Bohao Sync", footerVersion: "Bohao actual y v6.22 · v0.1.0",
  },
};
let lang = localStorage.getItem("bohao-sync-lang") === "es" ? "es" : "zh";
const t = (key, values = {}) => Object.entries(values).reduce((text, [name, value]) => text.replaceAll(`{${name}}`, value), messages[lang][key] ?? messages.es[key] ?? key);
const label = (prefix, key) => (messages.es[`${prefix}${key}`] ? t(`${prefix}${key}`) : key);
const locale = () => (lang === "zh" ? "zh-CN" : "es-ES");
let csrf = "", status = {}, currentView = "dashboard", orderCursors = [null], orderPage = 0, nextOrderCursor = null;
const formatDate = (timestamp) => timestamp ? new Date(timestamp * 1000).toLocaleString(locale()) : t("neverSynced");
function node(tag, text, className) { const el = document.createElement(tag); if (text !== undefined) el.textContent = text; if (className) el.className = className; return el; }
function notify(message, error = false) { const el = $("#notice"); el.textContent = message; el.className = error ? "error" : ""; el.hidden = false; }
async function api(path, body) { const response = await fetch(`/api/${path}`, body === undefined ? {} : { method: "POST", headers: { "Content-Type": "application/json", "X-Bridge-CSRF": csrf }, body: JSON.stringify(body) }); const value = await response.json(); if (!response.ok) throw new Error(typeof value.detail === "string" ? value.detail : t("apiFallback")); return value; }
function applyStatic() {
  document.documentElement.lang = locale();
  document.title = t("pageTitle");
  document.querySelectorAll("[data-i18n]").forEach(el => { el.textContent = t(el.dataset.i18n); });
  document.querySelectorAll("[data-i18n-placeholder]").forEach(el => { el.placeholder = t(el.dataset.i18nPlaceholder); });
  document.querySelectorAll("[data-i18n-label]").forEach(el => { el.setAttribute("aria-label", t(el.dataset.i18nLabel)); });
  $("#lang").textContent = lang === "zh" ? "Español" : "中文";
  $("#order-page").textContent = t("ordersPage", { n: orderPage + 1 });
}
function view(name) { currentView = name; document.querySelectorAll(".view").forEach(el => { el.hidden = el.id !== name; }); document.querySelectorAll(".nav").forEach(el => el.classList.toggle("active", el.dataset.view === name)); if (name === "orders") loadOrders(); }
async function refresh() {
  try { status = await api("status"); csrf = status.csrf; $("#mode").textContent = status.enabled ? t("modeAuto") : t("modePaused"); $("#toggle").textContent = status.enabled ? t("toggleOn") : t("toggleOff");
    $("#done").textContent = status.counts.done || 0; $("#pending").textContent = status.counts.pending || 0; $("#blocked").textContent = status.counts.blocked || 0; $("#error-badge").textContent = status.errors.length ? `· ${status.errors.length}` : "";
    const initial = status.initial_load;
    $("#initial-prepare").disabled = status.running;
    $("#initial-adopt").disabled = status.running || !initial?.packages?.length;
    $("#initial-status").textContent = initial ? label("init_", initial.status) + (initial.products !== undefined ? t("initialSummary", { products: initial.products, customers: initial.customers }) : "") + (initial.error ? ` · ${initial.error}` : "") : t("initialNone");
    const packages = $("#initial-packages"); const skippedWasOpen = packages.querySelector(".initial-skipped")?.open ?? false; packages.replaceChildren();
    if (initial?.skippedCount) {
      const details = node("details", undefined, "initial-skipped");
      details.open = skippedWasOpen;
      details.append(node("summary", t("initialSkipped", { n: initial.skippedCount })));
      const list = node("ul");
      for (const item of initial.skipped || []) {
        const kind = item.kind === "product" ? t("dProducts") : t("dCustomers");
        list.append(node("li", t("skippedItem", { kind, id: item.sourceId, reason: item.reason })));
      }
      const hidden = initial.skippedCount - (initial.skipped || []).length;
      if (hidden > 0) list.append(node("li", t("skippedMore", { n: hidden })));
      details.append(list); packages.append(details);
    }
    for (const part of initial?.packages || []) { const link = node("a", t("downloadPackage", { file: part.filename, n: part.records })); link.href = `/api/initial/download/${encodeURIComponent(part.filename)}`; link.download = part.filename; const row = node("p"); row.append(link); packages.append(row); }
    $("#sync").disabled = status.running || Boolean(initial && initial.status !== "ready"); $("#sync").textContent = status.running ? t("syncing") : `${t("syncNow")} ↗`;
    $("#connection-title").textContent = status.running ? status.progress : status.last_sync ? t("connectReady") : t("connectTitle");
    $("#connection-detail").textContent = status.last_sync ? t("lastCycle", { date: formatDate(status.last_sync) }) + (status.errors.length ? t("needsAttention") : "") : t("connectDetail");
    const events = $("#events"); events.replaceChildren(); if (!status.events.length) events.append(node("p", t("firstSyncEvent"), "empty")); for (const item of status.events) { const el = node("div", undefined, `event ${item.level}`); el.append(node("span", item.level === "error" ? "!" : "✓")); const content = node("div"); content.append(node("p", item.message), node("time", formatDate(item.created_at))); el.append(content); events.append(el); }
    const errors = $("#error-list"); errors.replaceChildren(); if (!status.errors.length) errors.append(node("p", t("noErrors"), "empty")); for (const item of status.errors) { const el = node("article", undefined, "error-item"); el.append(node("h3", t("errorItem", { id: item.id, kind: item.kind })), node("p", item.error), node("small", t("attempts", { n: item.attempts, state: item.state === "blocked" ? t("needsReview") : t("retryWaiting") }))); errors.append(el); }
  } catch (error) { notify(t("notifyOffline"), true); }
}
async function loadSettings() { const config = await api("settings"); for (const [key, value] of Object.entries(config)) { const input = $("#config-form").elements.namedItem(key); if (!input) continue; if (input.type === "checkbox") input.checked = value; else input.value = Array.isArray(value) ? value.join(",") : value; } }
async function loadOrders() { try { const page = await api("orders" + (orderCursors[orderPage] ? "?cursor=" + encodeURIComponent(orderCursors[orderPage]) : "")); const orders = page.items; nextOrderCursor = page.nextCursor; $("#previous-orders").disabled = orderPage === 0; $("#next-orders").disabled = !nextOrderCursor; $("#order-page").textContent = t("ordersPage", { n: orderPage + 1 }); const rows = $("#order-rows"); rows.replaceChildren(); $("#order-empty").hidden = orders.length > 0; $("#order-empty").textContent = t("noOrders"); for (const order of orders) { const row = node("tr"); for (const value of [order.number, order.customer, label("st_", order.status), order.bohao_document || t("orderNotImported"), (order.totalCents / 100).toLocaleString(locale(), {style:"currency",currency:"EUR"}) + (order.netOnly ? "" : t("estimated"))]) row.append(node("td", value)); const cell = node("td"); if (["confirmed", "partially_shipped"].includes(order.status)) { const button = node("button", order.bohao_document ? t("orderUpdate") : t("orderImport"), "secondary"); button.addEventListener("click", () => action(button, () => api(`orders/${encodeURIComponent(order.id)}/import`, {}), t("orderQueued"))); cell.append(button); } else cell.textContent = "—"; row.append(cell); rows.append(row); } } catch(error) { $("#order-empty").hidden = false; $("#order-empty").textContent = error.message; } }
async function action(button, operation, message) { button.disabled = true; try { await operation(); if (message) notify(message); await refresh(); } catch(error) { notify(error.message, true); } finally { button.disabled = false; } }
document.querySelectorAll("[data-view]").forEach(el => el.addEventListener("click", () => view(el.dataset.view)));
$("#setup").addEventListener("click", () => view("settings"));
$("#sync").addEventListener("click", event => action(event.currentTarget, () => api("sync", {}), t("syncStarted")));
$("#toggle").addEventListener("click", event => action(event.currentTarget, () => api("automation", {enabled: !status.enabled}), t("prefSaved")));
$("#retry").addEventListener("click", event => action(event.currentTarget, () => api("retry", {}), t("retryReady")));
$("#refresh-orders").addEventListener("click", event => action(event.currentTarget, loadOrders));
$("#config-form").addEventListener("submit", async event => { event.preventDefault(); const body = Object.fromEntries(new FormData(event.currentTarget)); for (const field of ["mysql_port", "interval_seconds", "safety_stock"]) body[field] = Number(body[field]); body.warehouse_ids = body.warehouse_ids.split(",").map(v => Number(v.trim())).filter(v => Number.isInteger(v) && v > 0); body.article_ids = body.article_ids.split(",").map(v => v.trim()).filter(Boolean); await action(event.submitter, () => api("settings", body), t("configSaved")); });
$("#preflight").addEventListener("click", event => action(event.currentTarget, async () => { const report = await api("preflight", {}); const el = $("#preflight-result"); el.replaceChildren(node("h2", t("preflightTitle"))); for (const [key,value] of Object.entries(report)) el.append(node("p", `${label("pf_", key)}: ${value}`)); el.hidden = false; }, t("preflightDone")));
$("#previous-orders").addEventListener("click", () => { if (orderPage > 0) { orderPage--; loadOrders(); } });
$("#next-orders").addEventListener("click", () => { if (nextOrderCursor) { orderCursors[++orderPage] = nextOrderCursor; loadOrders(); } });
$("#initial-prepare").addEventListener("click", event => action(event.currentTarget, () => api("initial/prepare", {}), t("initPrepareMsg")));
$("#initial-adopt").addEventListener("click", event => action(event.currentTarget, () => api("initial/adopt", {}), t("initAdoptMsg")));
$("#lang").addEventListener("click", () => { lang = lang === "zh" ? "es" : "zh"; localStorage.setItem("bohao-sync-lang", lang); applyStatic(); refresh(); if (currentView === "orders") loadOrders(); });
applyStatic();
Promise.all([refresh(), loadSettings()]).catch(error => notify(error.message, true));
setInterval(refresh, 3000);
