param([switch]$Development)
$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot
if (-not (Test-Path -LiteralPath '.venv\Scripts\python.exe')) {
    py -3.12 -m venv .venv
    if ($LASTEXITCODE -ne 0) { throw 'Instala Python 3.12 o superior y vuelve a ejecutar setup.ps1.' }
}
$syncPackage = if ($Development) { '.[dev]' } else { '.' }
& '.\.venv\Scripts\python.exe' -m pip install -e $syncPackage
if ($LASTEXITCODE -ne 0) { throw 'No se pudo instalar el entorno virtual.' }
Write-Host 'Preparado. Ejecuta .\start.ps1 para abrir la consola.'
