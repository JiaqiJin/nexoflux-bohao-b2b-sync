@echo off
setlocal

set "STOP_SCRIPT=%~dp0stop-client.ps1"
if not exist "%STOP_SCRIPT%" (
    echo No se encuentra stop-client.ps1. Extrae el ZIP completo y vuelve a intentarlo.
    pause
    exit /b 1
)

echo Cerrando Nexoflux Bohao Sync de forma segura...
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%STOP_SCRIPT%"
set "STOP_EXIT_CODE=%ERRORLEVEL%"
if not "%STOP_EXIT_CODE%"=="0" (
    echo No se pudo detener el servicio. Codigo: %STOP_EXIT_CODE%
)
pause
exit /b %STOP_EXIT_CODE%
