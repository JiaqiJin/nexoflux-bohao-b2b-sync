@echo off
setlocal

set "INSTALL_SCRIPT=%~dp0install-client.ps1"
if not exist "%INSTALL_SCRIPT%" (
    echo No se encuentra install-client.ps1. Extrae el ZIP completo y vuelve a intentarlo.
    pause
    exit /b 1
)

echo Instalando Nexoflux Bohao Sync para este usuario de Windows...
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%INSTALL_SCRIPT%"
set "INSTALL_EXIT_CODE=%ERRORLEVEL%"

if not "%INSTALL_EXIT_CODE%"=="0" (
    echo La instalacion no se completo. Codigo: %INSTALL_EXIT_CODE%
    pause
    exit /b %INSTALL_EXIT_CODE%
)

echo Instalacion terminada. El servidor se ejecutara en segundo plano al iniciar sesion.
echo Para abrir la consola, haz clic en el acceso directo del escritorio.
pause
exit /b 0
