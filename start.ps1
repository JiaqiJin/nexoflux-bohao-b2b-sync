param([string]$DataDir = "$env:LOCALAPPDATA\NexofluxBohaoSync", [int]$Port = 8765)
$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot
if (-not (Test-Path -LiteralPath '.venv\Scripts\python.exe')) { throw 'Primero ejecuta .\setup.ps1.' }
& '.\.venv\Scripts\python.exe' -m bridge --data-dir $DataDir --port $Port --open
