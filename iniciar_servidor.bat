<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 41511d61b0db3ff085b4663947ef9b8cb0b5cf56
@echo off
cd /d "%~dp0"
echo.
echo ============================================
echo   Servidor Web - Página POO
echo ============================================
echo.
echo Iniciando servidor en puerto 8000...
echo.

REM Intentar con Python 3
where python >nul 2>nul
if %errorlevel% equ 0 (
    echo Servidor iniciado! Abre en tu navegador:
    echo http://localhost:8000
    echo.
    python -m http.server 8000
    goto end
)

REM Intentar con Python 2
where python2 >nul 2>nul
if %errorlevel% equ 0 (
    echo Servidor iniciado! Abre en tu navegador:
    echo http://localhost:8000
    echo.
    python2 -m SimpleHTTPServer 8000
    goto end
)

REM Si no tiene Python, mostrar alternativas
echo Python no encontrado en el sistema.
echo.
echo ALTERNATIVAS:
echo.
echo 1. Instala Python desde: https://www.python.org/downloads/
echo.
echo 2. O usa Live Server en VS Code:
echo    - Clic derecho en index.html
echo    - Selecciona "Open with Live Server"
echo.
echo 3. O instala Node.js desde: https://nodejs.org/
echo    Luego ejecuta: npx http-server -p 8000
echo.
pause

:end
<<<<<<< HEAD
=======
=======
@echo off
cd /d "%~dp0"
echo.
echo ============================================
echo   Servidor Web - Página POO
echo ============================================
echo.
echo Iniciando servidor en puerto 8000...
echo.

REM Intentar con Python 3
where python >nul 2>nul
if %errorlevel% equ 0 (
    echo Servidor iniciado! Abre en tu navegador:
    echo http://localhost:8000
    echo.
    python -m http.server 8000
    goto end
)

REM Intentar con Python 2
where python2 >nul 2>nul
if %errorlevel% equ 0 (
    echo Servidor iniciado! Abre en tu navegador:
    echo http://localhost:8000
    echo.
    python2 -m SimpleHTTPServer 8000
    goto end
)

REM Si no tiene Python, mostrar alternativas
echo Python no encontrado en el sistema.
echo.
echo ALTERNATIVAS:
echo.
echo 1. Instala Python desde: https://www.python.org/downloads/
echo.
echo 2. O usa Live Server en VS Code:
echo    - Clic derecho en index.html
echo    - Selecciona "Open with Live Server"
echo.
echo 3. O instala Node.js desde: https://nodejs.org/
echo    Luego ejecuta: npx http-server -p 8000
echo.
pause

:end
>>>>>>> d66c44f330585b18b34e71ab7be7a2a7a5fc472c
>>>>>>> 41511d61b0db3ff085b4663947ef9b8cb0b5cf56
