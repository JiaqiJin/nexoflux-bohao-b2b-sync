# Documentación de la Base de Datos Bohao (Smerps)

Esta documentación detalla la estructura y forma de conexión a la base de datos utilizada por el software **Bohao Restaurant Management Expert**.

> **Seguridad:** no guardes usuarios ni contraseñas en esta documentación o en el código. Configura `BOHAO_DB_HOST`, `BOHAO_DB_USER`, `BOHAO_DB_PASSWORD` y `BOHAO_DB_NAME` en el entorno protegido del proceso. El usuario `Admin/1111` pertenece al programa de mantenimiento de Bohao y no es una cuenta MySQL.
**ODBC (Open Database Connectivity)** es un estándar que permite a aplicaciones externas conectarse a bases de datos de diferentes fabricantes usando un "traductor" (Driver).

En Bohao:
- Se utiliza un driver personalizado llamado `MySQL ODBC Driver 8.0 for Bohao`.
- Este driver está instalado en versión de **32 bits**, ya que el software Bohao es una aplicación de 32 bits.
- **Importante**: Para que aplicaciones externas (como Python o DBeaver) se conecten vía ODBC, deben coincidir en "bits". Como la mayoría de aplicaciones modernas son de 64 bits, la conexión directa vía ODBC suele fallar con errores de "Data Source Name not found".

## 2. Forma de Conexión Recomendada (Nativa)
Aunque Bohao usa ODBC internamente, el motor real es MySQL. La versión depende de la instalación; el equipo comprobado aquí reporta MySQL 5.7.44.
La mejor forma de conectarse **sin depender de ODBC** es usar un cliente nativo de MySQL (como `pymysql` en Python o el comando `mysql.exe`).

### Datos de Conexión

En la instalación local verificada el 10 de octubre de 2026, el servidor responde en `127.0.0.1:3306`, usa la base `bohaosupermarket3` y reporta MySQL 5.7.44. Configura el host, el motor y las credenciales de nuevo en cada instalación; no supongas que coinciden con otros equipos.

## 3. Comprobación de Conexión
Para verificar la conexión desde el mismo PC, se puede usar:
```powershell
& "D:\Bohao\SmerpsSNSP7\mysql-x64\bin\mysql.exe" -u $env:BOHAO_DB_USER -p -h $env:BOHAO_DB_HOST -P 3306 bohaosupermarket3
```
Si el cliente muestra el prompt de MySQL sin error, la conexión se realizó. Puedes confirmar el destino con `SELECT DATABASE(), VERSION();`.
