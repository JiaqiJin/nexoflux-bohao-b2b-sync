# Bohao ↔ Nexoflux B2B 同步复核交接

**日期：** 2026-10-10  
**用途：** 供另一位 AI 或工程师继续独立审查连接、同步链路、数据阻塞、兼容性和测试边界。

> 本文和本次修改均不包含 MySQL 密码、API Key 或其他可用于登录的凭据。示例程序从环境变量读取 MySQL 凭据。

## 1. 涉及项目与连接边界

- Bohao Bridge 项目：`E:\company\nexoflux-b2-bohao-sync`
- B2B 项目：`E:\company\nexoflux-b2b`
- Bohao 文档和旧版结构：Bridge 项目的 `docs/`，重点是 `docs/bohao-v622-schema.sql` 与 `docs/bohao-docs/`。
- 本机正式 Bohao MySQL：`127.0.0.1:3306`，数据库 `bohaosupermarket3`。本机检查报告服务版本为 MySQL 5.7.44，检测到的是新版 Bohao schema。
- Bohao 维护程序账号不是 MySQL 账号，也不能代替 MySQL 授权。
- B2B URL、Organization ID 和 API Key 没有配置在 Bridge 当前数据目录中。本次没有向 Cloudflare/B2B 生产 Organization 发请求，也没有导入生产数据。

本次针对正式 Bohao 库只执行了 `SELECT`、`SHOW GRANTS`、`information_schema` 和 `SHOW COLUMNS` 等只读检查。初始包失败复现也只读取 MySQL；ZIP、SQLite handoff 数据库及 State 都放在本机临时目录，测试后删除。没有在正式库写入订单、商品、客户、库存、类别或 Bridge 辅助表。

## 2. 端到端同步链路

```text
Bohao MySQL
    │
    ├─ 连接检查 / schema 检查（Bohao.inspect）
    │
    ├─ 首次导出：类别 → 商品/变体/销售单位/价格 → 客户
    │       生成 CSV + ZIP 与本地 handoff.db
    │
    ├─ B2B 批量导入 ZIP
    │       通过 imports/{exportId}/results 校验每条记录的 fingerprint
    │
    ├─ Bridge adoption：读取 B2B 页数据并将一致资源记入本地 State
    │
    └─ 周期同步：目录/客户 upsert、库存快照批量发布、拉取已确认订单
            │
            └─ Bohao.initialize 创建四张 nexoflux_sync_* 辅助表
                 → 幂等导入订单头、订单行及可选 IVA 汇总
                 → 重放/修订由辅助表映射和 revision 记录保证
```

B2B API 按 net-only 价格约定工作；B2B 不负责 Bohao 的 IVA 计算或开票。订单导入本身不会直接扣减实物库存，库存可用量依靠本地库存、预留和已反映的出库/发货进行对账。用户之前提供的实测摘要记录：商品价格 `1.0000` 映射后仍为 `1.0000`；该检查只验证价格数字未变化，**没有验证 IVA 计算**。

首次导出需要类别可以解析，客户需有可用税务 ID。订单写入需要 Bridge 辅助表和对 Bohao 订单表的写权限。导出、adoption、周期同步不是一次单独的 MySQL 调用：还依赖已部署且带所需 REST/OpenAPI 功能的 B2B，以及正确的 Organization API Key。

## 3. 正式 Bohao 数据库的本次实测

只读 `inspect()` 与 SQL 检查结果：

| 项目 | 结果 |
|---|---:|
| schema | 新版 / `Actual` |
| 商品 | 2,047 |
| 客户 | 59 |
| 库存行 | 69 |
| Bohao 订单 / 订单行 | 0 / 0 |
| 小数库存数量 | 0 |
| 没有对应类别的商品 | 2 |
| 没有 CIF/税务标识的客户 | 5 |
| `nexoflux_sync_*` 辅助表 | 0 |
| 当前 MySQL 用户的 `CREATE` 权限 | 无 |

### 初始导出失败原因

1. 两个商品的 `ClaseID=0` 没有对应类别：`21C3992E-3`（`AAAA`）与 `24E23111-1`（`caja pos`）。全量导出在第一个商品处报“类别不存在”。本次未给它们自动编造一个类别或税务分类。
2. 把导出限制到一个类别有效的商品后，继续扫描客户时在客户 `EmpresaID=1` 处报缺少税务标识。全库缺少标识的客户编号为 `1、10043、10044、10047、10048`。

这两个是正式数据质量阻塞，并非相同的代码异常。B2B 客户 schema 要求 `idNumber` 非空；不可凭空生成客户税号。应在 Bohao 中修复相应类别与 CIF，或由业务/财税负责人批准明确的数据映射规则，然后重新导出。

### 正式库写入为什么未验证

`Bohao.initialize()` 会创建四张 `nexoflux_sync_*` 表。正式库查询确认这些表不存在，当前用户没有 `CREATE`，Bridge 初始化因此无法继续。现有正式订单数为零，也没有真实订单可用于检查重复导入、订单修订、Bohao 原生界面显示或转出库单。

因此，本次**没有**验证正式库订单写入、同步重放、发货/库存闭环，也没有尝试授予权限。下一轮如要验证写入，应使用专用 MySQL 用户、明确限定数据库与表权限，并优先在隔离的 Bohao demo 上执行，然后由 Bohao 原生程序核对文档和业务流程。

## 4. SQLite 导出清理问题及代码改动

之前的 `InitialLoad.prepare()` 使用 `with sqlite3.connect(...)`。SQLite 连接对象的 context manager 负责 commit/rollback，但不会在离开 `with` 时自动 `close()`。映射异常发生在导出中段时，handoff.db 可能仍被 Windows 锁住；失败生成目录也没有统一清理。

本次改动：

- 在 [bridge/initial_load.py](../bridge/initial_load.py) 增加显式 close 的 handoff DB context manager。
- 将生成过程拆成失败清理包装层；任意失败时删除该 generation 目录中的部分 ZIP 和 handoff.db。
- 成功时仍保留 ZIP 与 handoff.db，State 的 `initial_load` 只在完成后写入。
- 在 [tests/test_bulk_handoff.py](../tests/test_bulk_handoff.py) 增加两种异常回归：商品类别缺失、客户 CIF 缺失。测试确认失败目录已清空，且没有把未完成任务标为可 adoption。
- 使用正式库只读复现了这两处失败；两次临时目录都在异常后清除。

## 5. v6.22 兼容性

- 老结构来自 [`docs/bohao-v622-schema.sql`](bohao-v622-schema.sql)。本次静态检查确认 Bridge `inspect()` 所要求的 `articulo`、`cliente`、`stock`、`pedidocliente` 与 `pedidoclientearticulo` 核心列均存在。
- v6.22 dump 不包含 `pedidoclienteivatotal`；Bridge 将该表当作可选表，因此新结构可写 summary，旧结构则保留头/行及辅助 revision 中的数据。
- Bridge 当前包含两 schema 的 MySQL 集成测试（`tests/test_mysql.py`）。本次机器没有 demo MySQL 在 `3337` 端口监听，且 `MySQL80` 服务停止，所以运行全套 Bridge 时六个会写 MySQL 的测试被安全跳过。**本次未对 v6.22 执行真实 MySQL 写入测试。**
- 用户先前交接摘要和仓库既有验证记录曾报告：新版与 v6.22 隔离 demo 各有 6 项 MySQL 集成测试通过。本次未重跑这些历史结果，需与当前代码版本和 demo 快照再次核对。

## 6. B2B 项目检查

本次没有修改 B2B 项目源码。已查看 B2B 客户输入 schema：客户 `idNumber` 至少一个字符，印证没有税务 ID 的五个 Bohao 客户不能直接导入。也核对了 B2B net-only 决策文档，故不应把“商品价格原样传输”描述成 IVA 算法验证。

本次针对 Bridge 使用到的 B2B 路径执行五个 Vitest 文件：

- `pos-import.test.ts`
- `public-api-catalogue.test.ts`
- `public-api-stock-customers.test.ts`
- `catalogue-taxonomy.test.ts`
- `customer-tax-ids.test.ts`

结果：**5 个文件、54 项测试全部通过**。测试覆盖本地 D1/Workerd 环境，不代表 Cloudflare 生产 API 已连接或数据已经导入。

用户先前摘要记录：B2B 的重点测试 32 项通过；全量套件约 120 个测试文件曾运行超过 14 分钟后手动停止，故不算通过。本次也没有重跑全量 B2B 套件。

## 7. 本次验证命令与结果

在 Bridge 项目执行：

```powershell
.\.venv\Scripts\python.exe -m pytest -q
# 41 passed, 6 skipped, 1 Starlette/httpx deprecation warning

.\.venv\Scripts\ruff.exe check bridge tests
# All checks passed
```

在 B2B 项目执行：

```powershell
pnpm --filter web test -- test/pos-import.test.ts test/public-api-catalogue.test.ts test/public-api-stock-customers.test.ts test/catalogue-taxonomy.test.ts test/customer-tax-ids.test.ts
# 5 files passed, 54 tests passed
```

Bridge 集成测试的环境开关只允许 `bohao_sync_demo` 或 `bohao_v622_demo`，避免误把写测试指向正式库。本次没有为通过测试而改动这个保护。

## 8. 本次修改的文件

- `bridge/initial_load.py`：关闭 handoff SQLite 连接；导出失败清理半成品 generation。
- `tests/test_bulk_handoff.py`：异常清理回归测试。
- `docs/bohao-docs/flask-server-complete.py`：MySQL host/user/password/database 改为 `BOHAO_DB_*` 环境变量读取。
- `docs/bohao-docs/bohao_db_info.md`：说明维护账号与 MySQL 账号不同，更新本机观测到的地址/版本，去除密码明文配置方式。
- `docs/production-validation-20261010.md`：西语生产检查摘要。
- `README.md`：增加上述生产检查摘要的链接。
- `docs/handoff-zh-20261010.md`：本中文交接文档。

Bridge 工作目录开始时报告为 `main...origin/main [gone]`，且所有项目文件均显示为未跟踪文件；本次没有 commit。B2B 工作目录原先已有未跟踪的 `output/`，本次未修改 B2B 源码。

## 9. 建议另一位 AI 下一步复核

1. 核对 `InitialLoad` 包装层在 State 写入失败、磁盘删除失败等异常路径下的一致性；检查 Windows 上 ZIP/SQLite 句柄关闭顺序。
2. 从 Bohao 原生程序确认两件商品应归属的类别，并补齐五个客户税号；不可自动猜测。
3. 在隔离 v6.22 MySQL demo 上启动对应 schema，重新运行仅允许 demo 的 6 项订单集成测试；确认 v6.22 写入、重放、冲突与 summary 缺表行为。
4. 为正式接入配置专用 MySQL 用户及必要的受限权限；重新执行 preflight，然后在 demo 中用真实 B2B API 流程导入并让 Bohao 原生程序打开、确认、转出库单。
5. 配置正确的 B2B URL、Organization 和密钥后，验证 OpenAPI/stock batch 能力、首次包导入与 adoption、周期商品/客户/库存同步，再以真实测试订单验证订单导入和幂等重放。
6. 完成上述验证前，不把正式环境状态标为“同步全部正常”或“生产验收通过”。
