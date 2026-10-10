param(
    [string]$InstallDir = "$env:LOCALAPPDATA\Programs\NexofluxBohaoSync",
    [string]$DataDir = "$env:LOCALAPPDATA\NexofluxBohaoSync",
    [int]$Port = 8765
)
$ErrorActionPreference = 'Stop'

$monitorScript = Join-Path $DataDir 'updater\update-and-start.ps1'
$appProcesses = @(Get-Process -Name 'NexofluxBohaoSync' -ErrorAction SilentlyContinue)

if ($appProcesses.Count -gt 0) {
    try {
        $status = Invoke-RestMethod -Uri "http://127.0.0.1:$Port/api/status" -TimeoutSec 5
        Invoke-RestMethod -Method Post `
            -Uri "http://127.0.0.1:$Port/api/shutdown-for-update" `
            -Headers @{ 'x-bridge-csrf' = $status.csrf } `
            -TimeoutSec 10 | Out-Null
    } catch {
        $detail = $_.ErrorDetails.Message
        if ($detail) {
            try { $detail = ($detail | ConvertFrom-Json).detail } catch { }
        }
        if (-not $detail) { $detail = 'No se pudo confirmar un cierre seguro.' }
        Write-Host $detail -ForegroundColor Yellow
        Write-Host 'No se forzo el cierre. Espera a que termine la sincronizacion e intenta otra vez.'
        exit 2
    }
}

$monitorProcesses = @(
    Get-CimInstance -ClassName Win32_Process -ErrorAction SilentlyContinue |
        Where-Object {
            $_.Name -in @('powershell.exe', 'pwsh.exe') -and
            $_.CommandLine -and
            $_.CommandLine.IndexOf($monitorScript, [System.StringComparison]::OrdinalIgnoreCase) -ge 0 -and
            $_.CommandLine -match '(?i)(?:^|\s)-Monitor(?:\s|$)'
        }
)
foreach ($monitor in $monitorProcesses) {
    Stop-Process -Id $monitor.ProcessId -Force -ErrorAction SilentlyContinue
}

if ($appProcesses.Count -gt 0) {
    try {
        Wait-Process -Id $appProcesses.Id -Timeout 45 -ErrorAction Stop
    } catch {
        Get-Process -Id $appProcesses.Id -ErrorAction SilentlyContinue |
            Stop-Process -Force -ErrorAction SilentlyContinue
    }
}

if (Get-Process -Name 'NexofluxBohaoSync' -ErrorAction SilentlyContinue) {
    Write-Host 'La aplicacion sigue abierta. Reinicia Windows antes de borrar sus archivos.' -ForegroundColor Red
    exit 1
}

Write-Host 'Servicio detenido de forma segura. Ya puedes borrar los archivos antiguos.' -ForegroundColor Green
Write-Host 'Se iniciara de nuevo la proxima vez que este usuario inicie sesion en Windows.'
