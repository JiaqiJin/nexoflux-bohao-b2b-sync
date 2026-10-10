$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot
$python = Join-Path $PSScriptRoot '.venv\Scripts\python.exe'
if (-not (Test-Path -LiteralPath $python)) {
    $python = (Get-Command python -ErrorAction Stop).Source
}
& $python -m PyInstaller --noconfirm --clean --onedir --name NexofluxBohaoSync --collect-data bridge --hidden-import win32timezone --hidden-import bridge.service --hidden-import uvicorn.logging --hidden-import uvicorn.loops.auto --hidden-import uvicorn.protocols.http.auto --hidden-import uvicorn.protocols.websockets.auto --hidden-import uvicorn.lifespan.on launcher.py
if ($LASTEXITCODE -ne 0) { throw 'No se pudo compilar el ejecutable.' }
