# Guía de Conexión para App Móvil (Android/iOS)

Esta guía explica detalladamente cómo conectar un dispositivo móvil a la base de datos de Bohao a través de una red WiFi local.

## Arquitectura de Conexión
Un dispositivo móvil **NO** debe conectarse directamente a MySQL por razones de seguridad, rendimiento y compatibilidad de drivers. El esquema correcto es:

`[App Móvil] <--- WiFi ---> [API REST (PC Servidor)] <--- Local ---> [Base de Datos MySQL]`

### Paso 1: El Servidor API (El Puente)
En el PC donde está instalado Bohao, se ejecuta un pequeño programa (API) que "escucha" peticiones del móvil.
1. La App pide: "Dáme el precio del producto 12345".
2. La API recibe la petición, consulta a MySQL y obtiene el resultado.
3. La API responde al móvil en formato **JSON**.

### Paso 2: Configuración del Servidor
1. **IP Estática**: El PC de Bohao debe tener una IP fija en la red (ej: `192.168.1.139`).
2. **Firewall**: Hay que abrir el puerto de la API (ej: `5000`) para que el móvil pueda entrar.

### Paso 3: La Aplicación Móvil
La aplicación móvil usará librerías estándar (como `fetch` o `axios`) para llamar a la API:
```javascript
// Ejemplo de llamada desde el móvil
fetch('http://192.168.1.139:5000/api/articulo/12345')
  .then(response => response.json())
  .then(data => console.log("El precio es: " + data.precio));
```

## Ventajas de este método
- **Compatibilidad**: Funciona en Android, iOS y Web.
- **Seguridad**: Solo expones los datos que tú quieras a través de la API.
- **Velocidad**: JSON es mucho más ligero que una conexión de base de datos directa.

## Recursos Adicionales
- [Configuración Detallada del Backend Bridge](backend_bridge_setup.md): Instrucciones paso a paso para crear el servidor API en Python.
- [Especificación API Completa](api-specification.md): Todos los endpoints REST con schemas de request/response.
- [Relaciones de la Base de Datos](db-relationships.md): Diagrama ER y relaciones entre tablas.
- [Arquitectura de la App PDA](pda-app-architecture.md): Patrón MVVM, pantallas, y flujo de navegación.
- [Definición de Tablas](table_definitions.md): Estructura completa de la base de datos para consultas SQL.

## Configuración Retrofit (Android/Kotlin)

```kotlin
// BohaoApi.kt
interface BohaoApi {
    @GET("api/articulo/{barcode}")
    suspend fun getArticulo(@Path("barcode") barcode: String): Response<ApiResponse<Articulo>>

    @GET("api/articulo/search")
    suspend fun searchArticulos(@Query("q") query: String, @Query("limit") limit: Int = 50): Response<ApiResponse<List<Articulo>>>

    @GET("api/articulo/{id}/stock")
    suspend fun getStock(@Path("id") articuloId: String): Response<ApiResponse<List<StockInfo>>>

    @POST("api/auth/login")
    suspend fun login(@Body request: LoginRequest): Response<ApiResponse<LoginResponse>>

    @POST("api/ticket")
    suspend fun createTicket(@Body request: TicketRequest): Response<ApiResponse<TicketResponse>>

    @POST("api/ticket/{documentoNo}/line")
    suspend fun addTicketLine(@Path("documentoNo") docNo: Long, @Body line: TicketLineRequest): Response<ApiResponse<LineResponse>>

    @PUT("api/ticket/{documentoNo}/close")
    suspend fun closeTicket(@Path("documentoNo") docNo: Long, @Body request: CloseTicketRequest): Response<ApiResponse<ClosedTicketResponse>>

    @POST("api/pago")
    suspend fun createPago(@Body request: PagoRequest): Response<ApiResponse<PagoResponse>>
}

// RetrofitClient.kt
object RetrofitClient {
    private const val BASE_URL = "http://192.168.1.139:5000/"

    fun create(authToken: String? = null): BohaoApi {
        val client = OkHttpClient.Builder().apply {
            authToken?.let { token ->
                addInterceptor { chain ->
                    val request = chain.request().newBuilder()
                        .addHeader("X-Auth-Token", token)
                        .build()
                    chain.proceed(request)
                }
            }
        }.build()

        return Retrofit.Builder()
            .baseUrl(BASE_URL)
            .client(client)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(BohaoApi::class.java)
    }
}
```
