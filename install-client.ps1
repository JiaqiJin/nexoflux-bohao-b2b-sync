param(
    [string]$InstallDir = "$env:LOCALAPPDATA\Programs\NexofluxBohaoSync",
    [string]$DataDir = "$env:LOCALAPPDATA\NexofluxBohaoSync"
)
$ErrorActionPreference = 'Stop'

$packageDir = Join-Path $PSScriptRoot 'NexofluxBohaoSync'
$exe = Join-Path $packageDir 'NexofluxBohaoSync.exe'
$updater = Join-Path $PSScriptRoot 'update-and-start.ps1'
if (-not (Test-Path -LiteralPath $exe)) { throw 'Extrae el ZIP de la versión completa y vuelve a ejecutar install-client.ps1.' }
if (-not (Test-Path -LiteralPath $updater)) { throw 'Falta update-and-start.ps1 en el paquete.' }

$running = Get-Process -Name 'NexofluxBohaoSync' -ErrorAction SilentlyContinue
if ($running) { throw 'Cierra Nexoflux Bohao Sync antes de instalar o reparar la aplicación.' }

New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
New-Item -ItemType Directory -Path $DataDir -Force | Out-Null
$staged = "$InstallDir.new"
$backup = "$InstallDir.previous"
Remove-Item -LiteralPath $staged -Recurse -Force -ErrorAction SilentlyContinue
Copy-Item -LiteralPath $packageDir -Destination $staged -Recurse -Force
if (Test-Path -LiteralPath $backup) { Remove-Item -LiteralPath $backup -Recurse -Force }
if (Test-Path -LiteralPath $InstallDir) { Move-Item -LiteralPath $InstallDir -Destination $backup }
try {
    Move-Item -LiteralPath $staged -Destination $InstallDir
} catch {
    if (Test-Path -LiteralPath $backup) { Move-Item -LiteralPath $backup -Destination $InstallDir }
    throw
}
if (Test-Path -LiteralPath $backup) { Remove-Item -LiteralPath $backup -Recurse -Force }

$updaterDir = Join-Path $DataDir 'updater'
New-Item -ItemType Directory -Path $updaterDir -Force | Out-Null
Copy-Item -LiteralPath $updater -Destination (Join-Path $updaterDir 'update-and-start.ps1') -Force

$monitorArgs = "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$updaterDir\update-and-start.ps1`" -InstallDir `"$InstallDir`" -DataDir `"$DataDir`" -Monitor"
$shortcutArgs = "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$updaterDir\update-and-start.ps1`" -InstallDir `"$InstallDir`" -DataDir `"$DataDir`" -OpenBrowser"
$command = "powershell.exe $monitorArgs"
$runKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'
New-Item -Path $runKey -Force | Out-Null
New-ItemProperty -Path $runKey -Name 'NexofluxBohaoSync' -PropertyType String -Value $command -Force | Out-Null

$shell = New-Object -ComObject WScript.Shell
$shortcutPaths = @(
    (Join-Path ([Environment]::GetFolderPath('Desktop')) 'Nexoflux Bohao Sync.lnk'),
    (Join-Path ([Environment]::GetFolderPath('StartMenu')) 'Programs\Nexoflux Bohao Sync.lnk')
)
foreach ($shortcutPath in $shortcutPaths) {
    New-Item -ItemType Directory -Path (Split-Path -Parent $shortcutPath) -Force | Out-Null
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = 'powershell.exe'
    $shortcut.Arguments = $shortcutArgs
    $shortcut.IconLocation = "$(Join-Path $InstallDir 'NexofluxBohaoSync.exe'),0"
    $shortcut.WorkingDirectory = $updaterDir
    $shortcut.Description = 'Iniciar o abrir la consola Nexoflux Bohao Sync'
    $shortcut.Save()
}

Write-Host 'Instalación completada. Se actualizará al iniciar sesión y se abrirá la consola.'
Start-Process -FilePath 'powershell.exe' -ArgumentList $monitorArgs
