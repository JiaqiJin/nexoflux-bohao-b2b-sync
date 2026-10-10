$ErrorActionPreference = 'Stop'
Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name 'NexofluxBohaoSync' -ErrorAction SilentlyContinue
Write-Host 'Inicio automático desactivado. Se conservan configuración y datos.'
