param([string]$DataDir = "$env:LOCALAPPDATA\NexofluxBohaoSync")
$ErrorActionPreference = 'Stop'
$syncPython = Join-Path $PSScriptRoot '.venv\Scripts\pythonw.exe'
if (-not (Test-Path -LiteralPath $syncPython)) { throw 'Ejecuta setup.ps1 antes de configurar el inicio automático.' }
New-Item -ItemType Directory -Path $DataDir -Force | Out-Null
$syncRun = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'
New-Item -Path $syncRun -Force | Out-Null
New-ItemProperty -Path $syncRun -Name 'NexofluxBohaoSync' -PropertyType String -Value "`"$syncPython`" -m bridge --data-dir `"$DataDir`" --open" -Force | Out-Null
Write-Host "Inicio automático al iniciar sesión configurado. Datos: $DataDir"
Write-Host 'La consola se abrirá automáticamente en http://127.0.0.1:8765'
