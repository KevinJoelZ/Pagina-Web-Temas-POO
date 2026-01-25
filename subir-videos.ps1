param(
    [string]$token = ""
)

# Saltarse validación de certificado SSL (necesario para algunos sistemas)
if (-not ([System.Management.Automation.PSTypeName]'ServerCertificateValidationCallback').Type) {
    $certCallback = @"
        using System;
        using System.Net;
        using System.Net.Security;
        using System.Security.Cryptography.X509Certificates;
        public class ServerCertificateValidationCallback
        {
            public static void Ignore()
            {
                if(ServicePointManager.ServerCertificateValidationCallback ==null){
                    ServicePointManager.ServerCertificateValidationCallback += 
                        delegate (
                            Object obj, 
                            X509Certificate certificate, 
                            X509Chain chain, 
                            SslPolicyErrors errors
                        ) {
                            return true;
                        };
                }
            }
        }
"@
    Add-Type $certCallback
}
[ServerCertificateValidationCallback]::Ignore()

$owner = "KevinJoelZ"
$repo = "Pagina-Web-Temas-POO"

if ($token -eq "") {
    Write-Host "INSTRUCCIONES PARA SUBIR VIDEOS" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "1. Ve a: https://github.com/settings/tokens"
    Write-Host "2. Click en 'Generate new token (classic)'"
    Write-Host "3. Nombre: 'GitHub-Upload-Videos'"
    Write-Host "4. Marca el permiso: repo (Full control of private repositories)"
    Write-Host "5. Click en 'Generate token' y copia el token"
    Write-Host ""
    Write-Host "Luego ejecuta:"
    Write-Host ".\subir-videos.ps1 -token 'tu_token_aqui'"
    Write-Host ""
    exit 1
}

Write-Host "Buscando videos..." -ForegroundColor Green

$videosPath = Join-Path (Get-Location) "videos"

if (!(Test-Path $videosPath)) {
    Write-Host "Error: Carpeta 'videos' no encontrada" -ForegroundColor Red
    exit 1
}

$videos = Get-ChildItem -Path $videosPath -File

if ($videos.Count -eq 0) {
    Write-Host "Error: No hay videos en la carpeta" -ForegroundColor Red
    exit 1
}

Write-Host "Videos encontrados:" -ForegroundColor Yellow
$videos | ForEach-Object {
    $sizeMB = [math]::Round($_.Length/1MB, 2)
    Write-Host "  - $($_.Name) ($sizeMB MB)"
}
Write-Host ""

$headers = @{
    "Authorization" = "token $token"
    "Accept" = "application/vnd.github+json"
}

$uploadCount = 0
$totalVideos = $videos.Count

foreach ($video in $videos) {
    Write-Host "Subiendo: $($video.Name)..." -ForegroundColor Cyan
    
    $fileContent = [System.IO.File]::ReadAllBytes($video.FullName)
    $base64Content = [System.Convert]::ToBase64String($fileContent)
    
    $apiUrl = "https://api.github.com/repos/$owner/$repo/contents/videos/$($video.Name)"
    
    $sha = $null
    try {
        $existingFile = Invoke-WebRequest -Uri $apiUrl -Headers $headers -Method Get -ErrorAction SilentlyContinue
        if ($existingFile.StatusCode -eq 200) {
            $content = $existingFile.Content | ConvertFrom-Json
            $sha = $content.sha
            Write-Host "  Actualizando archivo existente..." -ForegroundColor Yellow
        }
    } catch {
        Write-Host "  Creando archivo nuevo..." -ForegroundColor Yellow
    }
    
    $body = @{
        message = "Agregando video: $($video.Name)"
        content = $base64Content
    }
    
    if ($sha) {
        $body.sha = $sha
    }
    
    try {
        $response = Invoke-WebRequest -Uri $apiUrl `
            -Headers $headers `
            -Method Put `
            -Body ($body | ConvertTo-Json) `
            -ContentType "application/json"
        
        if ($response.StatusCode -eq 201 -or $response.StatusCode -eq 200) {
            Write-Host "  Exito!" -ForegroundColor Green
            $uploadCount++
        }
    } catch {
        Write-Host "  Error: $_" -ForegroundColor Red
    }
    
    Write-Host ""
}

Write-Host "RESUMEN" -ForegroundColor Green
Write-Host "Subidos: $uploadCount de $totalVideos archivos"
Write-Host "Repositorio: https://github.com/$owner/$repo"
Write-Host ""
