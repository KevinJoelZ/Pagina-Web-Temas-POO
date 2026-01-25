# Script para descargar e instalar Git en Windows
Write-Host "Descargando Git para Windows..." -ForegroundColor Green

$gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/Git-2.43.0-64-bit.exe"
$installerPath = "$env:TEMP\Git-Installer.exe"

# Descargar Git
try {
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $gitUrl -OutFile $installerPath
    Write-Host "Git descargado correctamente" -ForegroundColor Green
} catch {
    Write-Host "Error al descargar Git: $_" -ForegroundColor Red
    exit 1
}

# Instalar Git
Write-Host "Instalando Git..." -ForegroundColor Yellow
& $installerPath /VERYSILENT /NORESTART | Out-Null

# Esperar a que se complete la instalación
Start-Sleep -Seconds 5

# Verificar instalación
$gitPath = "C:\Program Files\Git\bin\git.exe"
if (Test-Path $gitPath) {
    Write-Host "Git instalado correctamente!" -ForegroundColor Green
    & $gitPath --version
} else {
    Write-Host "Error: Git no se instaló correctamente" -ForegroundColor Red
    exit 1
}

# Limpiar
Remove-Item $installerPath -Force -ErrorAction SilentlyContinue

Write-Host "`nGit está listo para usar!" -ForegroundColor Green
