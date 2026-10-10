param(
    [string]$InstallDir = "$env:LOCALAPPDATA\Programs\NexofluxBohaoSync",
    [string]$DataDir = "$env:LOCALAPPDATA\NexofluxBohaoSync",
    [switch]$Monitor,
    [switch]$OpenBrowser
)
$ErrorActionPreference = 'Stop'
$repo = 'JiaqiJin/nexoflux-bohao-b2b-sync'
$exe = Join-Path $InstallDir 'NexofluxBohaoSync.exe'
$stageRoot = Join-Path $DataDir 'update-staging'

function Get-AppProcess {
    Get-Process -Name 'NexofluxBohaoSync' -ErrorAction SilentlyContinue | Select-Object -First 1
}

function Start-Console {
    if (Test-Path -LiteralPath $exe) {
        Start-Process -FilePath $exe -ArgumentList "--data-dir `"$DataDir`" --open" -WorkingDirectory $InstallDir
    }
}

function Invoke-UpdateCheck {
    $process = Get-AppProcess
    $wasRunning = $null -ne $process
    $wasStopped = $false
    $updated = $false
    try {
        $headers = @{ 'User-Agent' = 'NexofluxBohaoSync-Updater'; Accept = 'application/vnd.github+json' }
        $release = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/releases/latest" -Headers $headers -TimeoutSec 20
        $latest = $release.tag_name -replace '^v', ''
        $versionFile = Join-Path $InstallDir 'version.txt'
        $current = if (Test-Path -LiteralPath $versionFile) { (Get-Content -LiteralPath $versionFile -Raw).Trim() } else { '0.0.0' }
        $asset = $release.assets | Where-Object { $_.name -eq 'NexofluxBohaoSync-win-x64.zip' } | Select-Object -First 1

        if ($asset -and [version]$latest -gt [version]$current) {
            if ($wasRunning) {
                $status = Invoke-RestMethod -Uri 'http://127.0.0.1:8765/api/status' -TimeoutSec 5
                if ($status.running) { return }
                Invoke-RestMethod -Method Post -Uri 'http://127.0.0.1:8765/api/shutdown-for-update' -Headers @{ 'x-bridge-csrf' = $status.csrf } -TimeoutSec 10 | Out-Null
                try { Wait-Process -Id $process.Id -Timeout 45 -ErrorAction Stop } catch { }
                if (Get-AppProcess) { return }
                $wasStopped = $true
            }

            New-Item -ItemType Directory -Path $stageRoot -Force | Out-Null
            $archive = Join-Path $stageRoot 'latest.zip'
            $unpacked = Join-Path $stageRoot 'unpacked'
            $stagedApp = Join-Path $unpacked 'NexofluxBohaoSync'
            $backup = "$InstallDir.previous"
            Remove-Item -LiteralPath $unpacked -Recurse -Force -ErrorAction SilentlyContinue
            Invoke-WebRequest -Uri $asset.browser_download_url -Headers @{ 'User-Agent' = 'NexofluxBohaoSync-Updater' } -OutFile $archive -TimeoutSec 120
            Expand-Archive -LiteralPath $archive -DestinationPath $unpacked -Force
            if (-not (Test-Path -LiteralPath (Join-Path $stagedApp 'NexofluxBohaoSync.exe'))) {
                throw 'El paquete descargado no contiene la aplicación esperada.'
            }
            if (Test-Path -LiteralPath $backup) { Remove-Item -LiteralPath $backup -Recurse -Force }
            if (Test-Path -LiteralPath $InstallDir) { Move-Item -LiteralPath $InstallDir -Destination $backup }
            try {
                Move-Item -LiteralPath $stagedApp -Destination $InstallDir
            } catch {
                if (Test-Path -LiteralPath $backup) { Move-Item -LiteralPath $backup -Destination $InstallDir }
                throw
            }
            $bundledUpdater = Join-Path $unpacked 'update-and-start.ps1'
            if (Test-Path -LiteralPath $bundledUpdater) {
                Copy-Item -LiteralPath $bundledUpdater -Destination $PSCommandPath -Force
            }
            if (Test-Path -LiteralPath $backup) { Remove-Item -LiteralPath $backup -Recurse -Force }
            $updated = $true
        }
    } catch {
        # Preserve and start the installed version when GitHub or the download is unavailable.
    }

    if (-not $wasRunning -or $updated -or $wasStopped) {
        Start-Console
    } elseif ($OpenBrowser) {
        Start-Process 'http://127.0.0.1:8765'
    }
}

do {
    Invoke-UpdateCheck
    if ($Monitor) { Start-Sleep -Seconds 3600 }
} while ($Monitor)
