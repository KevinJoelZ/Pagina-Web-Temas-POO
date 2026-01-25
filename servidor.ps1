<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 41511d61b0db3ff085b4663947ef9b8cb0b5cf56
# Servidor HTTP simple en PowerShell
$puerto = 8000
$ruta = (Get-Item -Path ".\").FullName

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://+:$puerto/")
$listener.Start()

Write-Host "Servidor web iniciado en: http://localhost:$puerto"
Write-Host "Sirviendo archivos desde: $ruta"
$compName = $env:COMPUTERNAME
Write-Host "URL para compartir: http://$compName:$puerto"
Write-Host "Presiona Ctrl+C para detener el servidor`n"

while ($true) {
    try {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $requestPath = $request.Url.LocalPath
        if ($requestPath -eq "/") { $requestPath = "/index.html" }
        
        $filePath = Join-Path $ruta $requestPath.TrimStart('/')
        
        if (Test-Path $filePath -PathType Leaf) {
            $fileContent = [System.IO.File]::ReadAllBytes($filePath)
            
            # Determinar tipo MIME
            $extension = [System.IO.Path]::GetExtension($filePath).ToLower()
            $mimeType = switch ($extension) {
                ".html" { "text/html; charset=utf-8" }
                ".css" { "text/css" }
                ".js" { "application/javascript" }
                ".json" { "application/json" }
                ".png" { "image/png" }
                ".jpg" { "image/jpeg" }
                ".gif" { "image/gif" }
                ".svg" { "image/svg+xml" }
                ".mp4" { "video/mp4" }
                default { "application/octet-stream" }
            }
            
            $response.ContentType = $mimeType
            $response.ContentLength64 = $fileContent.Length
            $response.OutputStream.Write($fileContent, 0, $fileContent.Length)
            $response.StatusCode = 200
        } else {
            $notFoundPath = Join-Path $ruta "404.html"
            if (Test-Path $notFoundPath) {
                $fileContent = [System.IO.File]::ReadAllBytes($notFoundPath)
            } else {
                $fileContent = [System.Text.Encoding]::UTF8.GetBytes("404 - Archivo no encontrado")
            }
            $response.StatusCode = 404
            $response.ContentType = "text/html; charset=utf-8"
            $response.ContentLength64 = $fileContent.Length
            $response.OutputStream.Write($fileContent, 0, $fileContent.Length)
        }
        $response.OutputStream.Close()
    } catch {
        Write-Host "Error: $_"
    }
}
$listener.Stop()
<<<<<<< HEAD
=======
=======
# Servidor HTTP simple en PowerShell
$puerto = 8000
$ruta = (Get-Item -Path ".\").FullName

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://+:$puerto/")
$listener.Start()

Write-Host "Servidor web iniciado en: http://localhost:$puerto"
Write-Host "Sirviendo archivos desde: $ruta"
$compName = $env:COMPUTERNAME
Write-Host "URL para compartir: http://$compName:$puerto"
Write-Host "Presiona Ctrl+C para detener el servidor`n"

while ($true) {
    try {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $requestPath = $request.Url.LocalPath
        if ($requestPath -eq "/") { $requestPath = "/index.html" }
        
        $filePath = Join-Path $ruta $requestPath.TrimStart('/')
        
        if (Test-Path $filePath -PathType Leaf) {
            $fileContent = [System.IO.File]::ReadAllBytes($filePath)
            
            # Determinar tipo MIME
            $extension = [System.IO.Path]::GetExtension($filePath).ToLower()
            $mimeType = switch ($extension) {
                ".html" { "text/html; charset=utf-8" }
                ".css" { "text/css" }
                ".js" { "application/javascript" }
                ".json" { "application/json" }
                ".png" { "image/png" }
                ".jpg" { "image/jpeg" }
                ".gif" { "image/gif" }
                ".svg" { "image/svg+xml" }
                ".mp4" { "video/mp4" }
                default { "application/octet-stream" }
            }
            
            $response.ContentType = $mimeType
            $response.ContentLength64 = $fileContent.Length
            $response.OutputStream.Write($fileContent, 0, $fileContent.Length)
            $response.StatusCode = 200
        } else {
            $notFoundPath = Join-Path $ruta "404.html"
            if (Test-Path $notFoundPath) {
                $fileContent = [System.IO.File]::ReadAllBytes($notFoundPath)
            } else {
                $fileContent = [System.Text.Encoding]::UTF8.GetBytes("404 - Archivo no encontrado")
            }
            $response.StatusCode = 404
            $response.ContentType = "text/html; charset=utf-8"
            $response.ContentLength64 = $fileContent.Length
            $response.OutputStream.Write($fileContent, 0, $fileContent.Length)
        }
        $response.OutputStream.Close()
    } catch {
        Write-Host "Error: $_"
    }
}
$listener.Stop()
>>>>>>> d66c44f330585b18b34e71ab7be7a2a7a5fc472c
>>>>>>> 41511d61b0db3ff085b4663947ef9b8cb0b5cf56
