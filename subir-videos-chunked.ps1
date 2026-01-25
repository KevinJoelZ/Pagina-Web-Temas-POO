param(
    [string]$token = ""
)

if ($token -eq "") {
    Write-Host "ERROR: Token requerido" -ForegroundColor Red
    Write-Host "Uso: .\subir-videos-chunked.ps1 -token 'tu_token'" -ForegroundColor Yellow
    exit 1
}

Write-Host "=== SUBIDOR DE VIDEOS POR CHUNKS ===" -ForegroundColor Cyan
Write-Host ""

# Configurar TLS
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

$owner = "KevinJoelZ"
$repo = "Pagina-Web-Temas-POO"
$videosPath = Join-Path (Get-Location) "videos"

# Verificar carpeta
if (!(Test-Path $videosPath)) {
    Write-Host "ERROR: Carpeta '$videosPath' no encontrada" -ForegroundColor Red
    exit 1
}

# Obtener videos
$videos = @(Get-ChildItem -Path $videosPath -Filter "*.mp4" -File)

if ($videos.Count -eq 0) {
    Write-Host "ERROR: No hay archivos MP4 en $videosPath" -ForegroundColor Red
    exit 1
}

Write-Host "Videos encontrados: $($videos.Count)" -ForegroundColor Yellow
$videos | ForEach-Object {
    Write-Host "  • $($_.Name) - $([math]::Round($_.Length/1MB, 2)) MB" -ForegroundColor White
}
Write-Host ""

$headers = @{
    "Authorization" = "token $token"
    "Accept" = "application/vnd.github+json"
    "User-Agent" = "PowerShell-Uploader"
}

$successCount = 0

foreach ($video in $videos) {
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host "ARCHIVO: $($video.Name)" -ForegroundColor Yellow
    Write-Host "TAMANIO: $([math]::Round($video.Length/1MB, 2)) MB" -ForegroundColor Gray
    Write-Host "================================================" -ForegroundColor Cyan
    Write-Host ""
    
    try {
        # PASO 1: Leer archivo
        Write-Host "[PASO 1/3] Leyendo archivo..." -ForegroundColor White -NoNewline
        $fileContent = [System.IO.File]::ReadAllBytes($video.FullName)
        $fileSizeMB = $fileContent.Length / 1MB
        Write-Host " OK ($fileSizeMB MB)" -ForegroundColor Green
        
        # PASO 2: Codificar en Base64
        Write-Host "[PASO 2/3] Codificando en Base64..." -ForegroundColor White -NoNewline
        $base64Content = [System.Convert]::ToBase64String($fileContent)
        $base64SizeMB = $base64Content.Length / 1MB
        Write-Host " OK ($base64SizeMB MB)" -ForegroundColor Green
        
        # PASO 3: Preparar JSON
        Write-Host "[PASO 3/3] Preparando para envío..." -ForegroundColor White -NoNewline
        $payload = @{
            message = "Subiendo video: $($video.Name)"
            content = $base64Content
        } | ConvertTo-Json
        Write-Host " OK" -ForegroundColor Green
        
        # PASO 4: Enviar a GitHub
        Write-Host "[PASO 4/4] Enviando a GitHub..." -ForegroundColor White -NoNewline
        
        $apiUrl = "https://api.github.com/repos/$owner/$repo/contents/videos/$($video.Name)"
        
        $response = Invoke-WebRequest -Uri $apiUrl `
            -Headers $headers `
            -Method Put `
            -Body $payload `
            -ContentType "application/json" `
            -UseBasicParsing `
            -TimeoutSec 600 `
            -ErrorAction Stop
        
        Write-Host " OK (Código: $($response.StatusCode))" -ForegroundColor Green
        
        Write-Host ""
        Write-Host "✓ EXITO: Video subido correctamente" -ForegroundColor Green
        Write-Host "  URL: https://github.com/$owner/$repo/blob/main/videos/$($video.Name)" -ForegroundColor Cyan
        $successCount++
        
    } catch {
        Write-Host " ERROR" -ForegroundColor Red
        Write-Host ""
        Write-Host "✗ ERROR: No se pudo subir el archivo" -ForegroundColor Red
        Write-Host "  Tipo: $($_.Exception.GetType().Name)" -ForegroundColor Yellow
        Write-Host "  Mensaje: $($_.Exception.Message)" -ForegroundColor Yellow
        
        if ($_.Exception.Response) {
            try {
                $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
                $reader.BaseStream.Position = 0
                $reader.DiscardBufferedData()
                $responseBody = $reader.ReadToEnd()
                Write-Host "  Respuesta del servidor:" -ForegroundColor Yellow
                Write-Host "  $responseBody" -ForegroundColor Red
                $reader.Dispose()
            } catch {}
        }
    }
    
    Write-Host ""
}

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "RESUMEN FINAL" -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Exitosos: $successCount / $($videos.Count)" -ForegroundColor Green
Write-Host "Repositorio: https://github.com/$owner/$repo" -ForegroundColor Cyan
Write-Host "Carpeta videos: https://github.com/$owner/$repo/tree/main/videos" -ForegroundColor Cyan
Write-Host ""

if ($successCount -eq $videos.Count) {
    Write-Host "¡TODOS LOS VIDEOS SE SUBIERON CORRECTAMENTE!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "ADVERTENCIA: No se subieron todos los videos" -ForegroundColor Yellow
    exit 1
}
