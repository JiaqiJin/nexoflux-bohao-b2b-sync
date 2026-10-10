# Arquitectura de la App PDA Bohao

Arquitectura Android para la app PDA SUNMI conectada a Bohao via Flask REST API.

---

## Estado Actual

Este documento mezcla arquitectura objetivo e implementacion historica. Para decisiones de produccion, confiar primero en el codigo actual del repo.

Correcciones importantes respecto al estado real:
- Los ViewModels principales inyectan `BohaoApi` directamente; `di/RepositoryModule.kt` sigue siendo un stub y el patron Repository no esta implantado de forma general.
- La navegacion activa incluye 10 modulos en Home y 13 rutas principales (`login`, `home`, `product_consult`, `label_print`, `product_edit`, `inventory`, `receiving`, `quick_sale`, `settings`, `product_list`, `goods_verification`, `stock_transfer`, `customer_bill`).
- La impresion no esta operativa en este repo: `PrinterManager` contiene stubs y requiere integrar el SDK/AAR SUNMI (`printerx`) para etiquetas y tickets.
- La URL del backend y el idioma se guardan en `SharedPreferences`; no hay capa de configuracion central con repository.

---

## Patrón General: MVVM + Repository (objetivo / parcialmente implementado)

```
┌─────────────┐     ┌──────────────┐     ┌──────────────┐     ┌────────────┐
│  Compose     │────▶│  ViewModel   │────▶│  Repository  │────▶│  Retrofit  │
│  Screen      │     │  (StateFlow) │     │              │     │  API       │
│              │◀────│              │◀────│              │◀────│            │
└─────────────┘     └──────────────┘     └──────┬───────┘     └────────────┘
                                                 │
                                                 ▼
                                          ┌──────────────┐
                                          │  Room DB     │
                                          │  (cache)     │
                                          └──────────────┘
```

### Capas

| Capa | Responsabilidad | Librerías |
|------|----------------|-----------|
| **UI** | Pantallas, scanner, printer, navegación | Jetpack Compose + Material 3 |
| **ViewModel** | Estado UI, lógica de presentación, coroutine scope | ViewModel + StateFlow |
| **Repository** | Objetivo arquitectonico; actualmente poco usado en la app principal | Kotlin coroutines |
| **Network** | Retrofit interfaces, interceptors, DTOs | Retrofit + OkHttp + Gson |
| **Local** | Room entities, DAOs, migraciones | Room |
| **Hardware** | Scanner BroadcastReceiver, printerx SDK, TMSApi | SUNMI SDKs |

---

## Pantallas y Navegación

```
┌──────────┐
│  Login   │ POST /api/auth/login
└────┬─────┘
     ▼
┌──────────┐
│  Home    │ Menu principal con 10 modulos
└──┬───┬───┬───┬───┬──┬──┘
   │   │   │   │   │  │
   ▼   ▼   ▼   ▼   ▼  ▼
  ┌──┐┌──┐┌──┐┌──┐┌──┐┌──┐┌──────┐
  │P1││P2││P3││P4││P5││P6││P7    │
  └──┘└──┘└──┘└──┘└──┘└──┘└──────┘
  Pre  Stk Inv Rec Etiq Mod Quick
                             Sale
```

| Ruta | Pantalla | Workflow | Estado real |
|---|---|---|---|
| `product_consult` | `ProductConsultScreen` | Scan/entrada manual → detalle de producto | Implementado |
| `product_list` | `ProductListScreen` | Busqueda/catalogo | Implementado |
| `product_edit` | `ProductEditScreen` | Alta/edicion de producto | Implementado |
| `inventory` | `InventoryScreen` | Crear doc → scan → cerrar | Implementado con limites conocidos en cierre |
| `receiving` | `ReceivingScreen` | Crear doc → scan → editar → cerrar | Implementado |
| `label_print` | `LabelPrintScreen` | Scan → preparar etiqueta → intentar imprimir | UI implementada, impresion no operativa sin SDK |
| `quick_sale` | `QuickSaleScreen` | Ticket → scan → pago → impresion | Implementado con limites conocidos en multipago/borrado/impresion |
| `settings` | `SettingsScreen` | Idioma, URL, conexion, logout | Implementado |
| `goods_verification` | `GoodsVerificationScreen` | Verificar albaran pendiente | Implementado |
| `stock_transfer` | `StockTransferScreen` | Traspaso entre almacenes | Implementado |
| `customer_bill` | `CustomerBillScreen` | Consulta de clientes/facturas | Implementado |

### Navigation (Jetpack Navigation Compose)

```kotlin
// NavGraph.kt
@Composable
fun NavGraph(navController: NavHostController) {
    NavHost(navController, startDestination = "login") {
        composable("login") { LoginScreen(navController) }
        composable("home") { HomeScreen(navController) }
        composable("product_consult?barcode={barcode}") { ProductConsultScreen(navController) }
        composable("product_list") { ProductListScreen(...) }
        composable("inventory") { InventoryScreen(navController) }
        composable("receiving") { ReceivingScreen(navController) }
        composable("label_print") { LabelPrintScreen(navController) }
        composable("product_edit?barcode={barcode}") { ProductEditScreen(navController) }
        composable("quick_sale") { QuickSaleScreen(navController) }
        composable("settings") { SettingsScreen(...) }
        composable("goods_verification") { GoodsVerificationScreen(navController) }
        composable("stock_transfer") { StockTransferScreen(navController) }
        composable("customer_bill") { CustomerBillScreen(navController) }
    }
}
```

---

## Estructura de Paquetes

```
com.example.nexofluxpda/
├── di/                         # Hilt modules
│   ├── NetworkModule.kt        # Retrofit, OkHttp, Gson
│   ├── DatabaseModule.kt       # Room database, DAOs
│   └── RepositoryModule.kt     # Stub; sin bindings activos
├── data/
│   ├── api/                    # Retrofit interfaces
│   │   ├── BohaoApi.kt         # Todos los endpoints
│   │   └── dto/                # Request/Response data classes
│   │       ├── AuthDto.kt
│   │       ├── ArticuloDto.kt
│   │       ├── TicketDto.kt
│   │       └── StockDto.kt
│   ├── local/                  # Room
│   │   ├── BohaoDatabase.kt
│   │   ├── entity/             # Room entities
│   │   └── dao/                # DAOs
│   ├── repository/             # No es la via principal usada por la app actual
│   └── model/                  # Domain models
├── ui/
│   ├── login/                  # LoginScreen + LoginViewModel
│   ├── home/                   # HomeScreen
│   ├── productconsult/
│   ├── productlist/
│   ├── inventory/
│   ├── receiving/
│   ├── quicksale/
│   ├── labelprint/
│   ├── goodsverification/
│   ├── stocktransfer/
│   ├── customerbill/
│   └── settings/
├── hardware/                   # SUNMI-specific
│   ├── ScannerManager.kt       # BroadcastReceiver setup/teardown
│   ├── PrinterManager.kt       # printerx init, receipt/label helpers
│   └── DeviceManager.kt        # TMSApi wrapper
├── sync/                       # Offline sync
│   ├── NetworkMonitor.kt
│   ├── SyncWorker.kt
│   └── SyncScheduler.kt
└── BohaoPdaApp.kt              # Application class (Hilt + TMSApi)
```

---

## Repository Pattern — Ejemplo (objetivo, no representativo del flujo principal actual)

```kotlin
class ArticuloRepository @Inject constructor(
    private val api: BohaoApi,
    private val articuloDao: ArticuloDao,
    private val networkMonitor: NetworkMonitor
) {
    fun getArticuloByBarcode(barcode: String): Flow<Resource<Articulo>> = flow {
        emit(Resource.Loading)
        if (networkMonitor.isServerReachable.value) {
            try {
                val response = api.getArticuloByBarcode(barcode)
                if (response.isSuccessful) {
                    val articulo = response.body()!!.data
                    articuloDao.insert(articulo.toEntity())
                    emit(Resource.Success(articulo))
                } else {
                    emit(Resource.Error("Producto no encontrado"))
                }
            } catch (e: Exception) {
                val cached = articuloDao.getByBarcode(barcode)
                if (cached != null) emit(Resource.Success(cached.toDomain()))
                else emit(Resource.Error(e.message ?: "Sin conexión"))
            }
        } else {
            val cached = articuloDao.getByBarcode(barcode)
            if (cached != null) emit(Resource.Success(cached.toDomain()))
            else emit(Resource.Error("Sin conexión y sin datos en caché"))
        }
    }
}

sealed class Resource<out T> {
    object Loading : Resource<Nothing>()
    data class Success<T>(val data: T) : Resource<T>()
    data class Error(val message: String) : Resource<Nothing>()
}
```

---

## ViewModel — Ejemplo (historico / conceptual)

```kotlin
@HiltViewModel
class PriceCheckViewModel @Inject constructor(
    private val repository: ArticuloRepository
) : ViewModel() {

    private val _uiState = MutableStateFlow<PriceCheckState>(PriceCheckState.Idle)
    val uiState: StateFlow<PriceCheckState> = _uiState.asStateFlow()

    fun onBarcodeScanned(barcode: String) {
        viewModelScope.launch {
            repository.getArticuloByBarcode(barcode).collect { resource ->
                _uiState.value = when (resource) {
                    is Resource.Loading -> PriceCheckState.Loading
                    is Resource.Success -> PriceCheckState.Found(resource.data)
                    is Resource.Error -> PriceCheckState.Error(resource.message)
                }
            }
        }
    }
}

sealed class PriceCheckState {
    object Idle : PriceCheckState()
    object Loading : PriceCheckState()
    data class Found(val articulo: Articulo) : PriceCheckState()
    data class Error(val message: String) : PriceCheckState()
}
```

---

## Scanner Manager (centralizado)

```kotlin
@Singleton
class ScannerManager @Inject constructor() {
    private var listener: ((String) -> Unit)? = null
    private val receiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            val barcode = intent.getStringExtra("data") ?: return
            if (barcode.isNotEmpty()) listener?.invoke(barcode)
        }
    }

    fun startListening(activity: Activity, onBarcode: (String) -> Unit) {
        listener = onBarcode
        activity.registerReceiver(receiver, IntentFilter("com.sunmi.scanner.ACTION_DATA_CODE_RECEIVED"))
    }

    fun stopListening(activity: Activity) {
        listener = null
        try { activity.unregisterReceiver(receiver) } catch (_: Exception) {}
    }
}
```

---

## Printer Manager (centralizado)

```kotlin
@Singleton
class PrinterManager @Inject constructor(
    @ApplicationContext private val context: Context
) {
    private var printer: Printer? = null

    fun init() {
        PrinterSdk.getInstance().getPrinter(context, object : PrinterListen {
            override fun onDefPrinter(p: Printer) { printer = p }
            override fun onPrinters(printers: List<Printer>) {}
        })
    }

    fun destroy() {
        PrinterSdk.getInstance().destroy()
        printer = null
    }

    fun getPrinter(): Printer? = printer

    fun printReceipt(header: String, lines: List<ReceiptLine>, total: Double, qrData: String?) {
        val p = printer ?: return
        p.lineApi().initLine(BaseStyle.getStyle().setAlign(Align.CENTER))
        p.lineApi().printText("$header\n", TextStyle.getStyle().setTextSize(30).enableBold(true))
        p.lineApi().printDividingLine(DividingLine.DOTTED, 2)
        for (line in lines) {
            p.lineApi().printTexts(
                arrayOf(line.name, "x${line.qty}", "%.2f€".format(line.total)),
                intArrayOf(3, 1, 1),
                arrayOf(
                    TextStyle.getStyle().setAlign(Align.LEFT),
                    TextStyle.getStyle().setAlign(Align.CENTER),
                    TextStyle.getStyle().setAlign(Align.RIGHT)
                )
            )
        }
        p.lineApi().printDividingLine(DividingLine.SOLID, 2)
        p.lineApi().printTexts(
            arrayOf("TOTAL", "%.2f €".format(total)),
            intArrayOf(3, 2),
            arrayOf(
                TextStyle.getStyle().setAlign(Align.LEFT).setTextSize(28).enableBold(true),
                TextStyle.getStyle().setAlign(Align.RIGHT).setTextSize(28).enableBold(true)
            )
        )
        qrData?.let {
            p.lineApi().printQrCode(it, QrStyle.getStyle().setDot(6).setErrorLevel(ErrorLevel.L).setAlign(Align.CENTER))
        }
        p.lineApi().autoOut()
    }

    fun printLabel(nombre: String, precio: Double, barcode: String) {
        val p = printer ?: return
        p.canvasApi().initCanvas(BaseStyle.getStyle().setWidth(384).setHeight(240))
        p.canvasApi().renderArea(AreaStyle.getStyle().setStyle(Shape.BOX).setPosX(0).setPosY(0).setWidth(384).setHeight(240))
        p.canvasApi().renderText(nombre, TextStyle.getStyle().setPosX(192).setPosY(10).setAlign(Align.CENTER).setTextSize(26).enableBold(true))
        p.canvasApi().renderText("%.2f €".format(precio), TextStyle.getStyle().setPosX(192).setPosY(55).setAlign(Align.CENTER).setTextSize(40).enableBold(true))
        p.canvasApi().renderBarCode(barcode, BarcodeStyle.getStyle().setSymbology(Symbology.EAN13).setPosX(42).setPosY(130).setWidth(300).setHeight(85).setReadable(HumanReadable.POS_ONE))
        p.canvasApi().printCanvas(1, object : PrintResult() {
            override fun onResult(resultCode: Int, message: String) {}
        })
    }
}

data class ReceiptLine(val name: String, val qty: Int, val total: Double)
```

---

## Dependency Injection (Hilt)

```kotlin
@Module
@InstallIn(SingletonComponent::class)
object NetworkModule {
    @Provides @Singleton
    fun provideOkHttp(authTokenProvider: AuthTokenProvider): OkHttpClient =
        OkHttpClient.Builder()
            .addInterceptor { chain ->
                val request = chain.request().newBuilder()
                authTokenProvider.getToken()?.let { request.addHeader("X-Auth-Token", it) }
                chain.proceed(request.build())
            }
            .connectTimeout(5, TimeUnit.SECONDS)
            .readTimeout(10, TimeUnit.SECONDS)
            .build()

    @Provides @Singleton
    fun provideRetrofit(client: OkHttpClient): Retrofit =
        Retrofit.Builder()
            .baseUrl("http://192.168.1.139:5000/")
            .client(client)
            .addConverterFactory(GsonConverterFactory.create())
            .build()

    @Provides @Singleton
    fun provideApi(retrofit: Retrofit): BohaoApi = retrofit.create(BohaoApi::class.java)
}
```

---

## Configuración Build (Kotlin DSL)

```kotlin
// app/build.gradle.kts
plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
    alias(libs.plugins.kotlin.compose)
    alias(libs.plugins.hilt)
    alias(libs.plugins.ksp)
}

android {
    namespace = "com.example.nexofluxpda"
    compileSdk = 35

    defaultConfig {
        applicationId = "com.example.nexofluxpda"
        minSdk = 24
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildFeatures {
        compose = true
    }
}

dependencies {
    // Compose BOM
    val composeBom = platform("androidx.compose:compose-bom:2024.12.01")
    implementation(composeBom)
    implementation("androidx.compose.material3:material3")
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.ui:ui-tooling-preview")
    implementation("androidx.activity:activity-compose:1.10.1")
    implementation("androidx.lifecycle:lifecycle-viewmodel-compose:2.9.0")
    implementation("androidx.lifecycle:lifecycle-runtime-compose:2.9.0")
    implementation("androidx.navigation:navigation-compose:2.9.0")

    // Network
    implementation("com.squareup.retrofit2:retrofit:2.9.0")
    implementation("com.squareup.retrofit2:converter-gson:2.9.0")
    implementation("com.squareup.okhttp3:okhttp:4.12.0")

    // Room
    implementation("androidx.room:room-runtime:2.6.1")
    implementation("androidx.room:room-ktx:2.6.1")
    ksp("androidx.room:room-compiler:2.6.1")

    // Hilt
    implementation("com.google.dagger:hilt-android:2.55")
    ksp("com.google.dagger:hilt-compiler:2.55")
    implementation("androidx.hilt:hilt-navigation-compose:1.2.0")

    // Coroutines
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.9.0")

    // Security
    implementation("androidx.security:security-crypto:1.1.0-alpha06")

    // SUNMI Printer
    // implementation("com.sunmi:printerx:1.0.17")

    // WorkManager (sync)
    implementation("androidx.work:work-runtime-ktx:2.9.1")

    // SUNMI TMSApi (place in libs/)
    implementation(files("libs/SUNMI_CUSTOMER_API_v1.x.x_release.aar"))
}
```

---

## Application Class

```kotlin
@HiltAndroidApp
class BohaoPdaApp : Application() {
    companion object {
        lateinit var sTmsApi: TMSApi
    }

    override fun onCreate() {
        super.onCreate()
        sTmsApi = TMSApi()
        connectTmsService()
    }

    private fun connectTmsService() {
        sTmsApi.connect(this, object : TMSServiceConnection() {
            override fun onServiceConnected() { /* APIs ready */ }
            override fun onServiceDisconnected() { /* Reconnect with backoff */ }
        })
    }

    override fun onTerminate() {
        sTmsApi.disconnect()
        super.onTerminate()
    }
}
```
