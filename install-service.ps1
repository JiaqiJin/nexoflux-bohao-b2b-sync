# Ejecuta desde PowerShell como administrador después de build.ps1.
$ErrorActionPreference = 'Stop'
$syncExe = Join-Path $PSScriptRoot 'dist\NexofluxBohaoSync\NexofluxBohaoSync.exe'
if (-not (Test-Path -LiteralPath $syncExe)) { throw 'Ejecuta build.ps1 antes de instalar el servicio.' }
$syncData = Join-Path $env:PROGRAMDATA 'NexofluxBohaoSync'
New-Item -ItemType Directory -Path $syncData -Force | Out-Null
# Machine-scope DPAPI requires access protection on its ciphertext and queue.
icacls $syncData /inheritance:r /grant:r '*S-1-5-18:(OI)(CI)F' '*S-1-5-32-544:(OI)(CI)F' | Out-Null
if ($LASTEXITCODE -ne 0) { throw 'No se pudo proteger la carpeta de datos.' }
sc.exe create NexofluxBohaoSync binPath= "`"$syncExe`" --service" start= auto DisplayName= 'Nexoflux Bohao Sync'
if ($LASTEXITCODE -ne 0) { throw 'No se pudo crear el servicio.' }
sc.exe failure NexofluxBohaoSync reset= 86400 actions= restart/10000/restart/30000/restart/60000
Start-Service NexofluxBohaoSync
Write-Host 'Consola: http://127.0.0.1:8765'
