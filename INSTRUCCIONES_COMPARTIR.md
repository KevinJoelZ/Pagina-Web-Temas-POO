# 🌐 Cómo Compartir tu Página Web POO

## Opción 1: Live Server (RECOMENDADO - Más fácil)

### Pasos:
1. **En VS Code**, haz clic derecho en el archivo `index.html`
2. Selecciona **"Open with Live Server"**
3. Se abrirá automáticamente tu navegador en: `http://localhost:5500`

### Para compartir con otros en tu red:
- Encuentra tu dirección IP:
  - Abre PowerShell y ejecuta: `ipconfig`
  - Busca "IPv4 Address" bajo tu adaptador de red (ej: 192.168.x.x)
  
- Comparte esta URL con tus compañeros:
  ```
  http://192.168.x.x:5500
  ```
  (Reemplaza `192.168.x.x` con tu IP real)

---

## Opción 2: Node.js (Si tienes Node instalado)

### Si tienes Node.js instalado:
```bash
cd "f:\Educación Superior TSUDS - ITECSUR\4to Semestre\Programación Orientada a Objetos\Página Web POO"
npx http-server -p 8000
```

Luego abre: `http://localhost:8000`

---

## Opción 3: Instalar Python y usar su servidor

### 1. Descarga Python desde: https://www.python.org/downloads/
### 2. Durante la instalación, MARCA la opción "Add Python to PATH"
### 3. Reinicia la terminal
### 4. Ejecuta:
```bash
cd "f:\Educación Superior TSUDS - ITECSUR\4to Semestre\Programación Orientada a Objetos\Página Web POO"
python -m http.server 8000
```

Luego abre: `http://localhost:8000`

---

## Opción 4: GitHub Pages (Para internet - Permanente)

Si quieres que sea accesible desde cualquier lugar del mundo:

1. Crea cuenta en github.com
2. Crea un repositorio público llamado `Pagina-Web-POO`
3. Sube los archivos (index.html, fundamentos.html, css/, js/, videos/)
4. Ve a Settings → Pages
5. Selecciona "main branch" como source
6. GitHub te dará una URL pública como:
   ```
   https://tu-usuario.github.io/Pagina-Web-POO
   ```

---

## ✅ RECOMENDACIÓN INMEDIATA:
Usa **Live Server** (Opción 1) - Es lo más rápido y fácil.
