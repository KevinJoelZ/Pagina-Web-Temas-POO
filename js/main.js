// Inicializar highlight.js para resaltar sintaxis y comentarios
function initHighlight() {
  if (typeof hljs !== 'undefined') {
    hljs.highlightAll();
  } else {
    // Si no está disponible, esperar un poco e intentar de nuevo
    setTimeout(initHighlight, 100);
  }
}

// Ejecutar cuando el DOM esté listo
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initHighlight);
} else {
  initHighlight();
}

// Tarjetas generadas dinámicamente
const pages = [
  {
    title: 'Fundamentos de la Programación Orientada a Objetos',
    href: 'fundamentos.html',
    description: 'Conceptos básicos: clases, objetos, herencia, polimorfismo y encapsulación.'
  },
  {
    title: 'Instanciación de Objetos y Manipulación de Atributos y Métodos',
    href: 'instanciacion.html',
    description: 'Cómo crear instancias, usar constructores, manipular atributos con getters/setters e invocar métodos.'
  },
  {
    title: 'Conceptos Fundamentales de Herencia en POO',
    href: 'herencia.html',
    description: 'Herencia, sobrescritura de métodos, polimorfismo, modificadores de acceso y jerarquías de clases.'
  },
  {
    title: 'Ejercicios Prácticos: Modelado de Clases',
    href: 'ejercicios.html',
    description: 'Ejercicios completos con análisis, diseño, implementación y pruebas usando herencia y polimorfismo.'
  }
];

// Añadimos tarjeta para la nueva página "Ejercicios en Clase"
pages.push({
  title: 'Ejercicios en Clase - Código visto en sesiones',
  href: 'ejercicios-en-clase.html',
  description: 'Ejercicios trabajados en clase con ejemplos de código y salidas de ejemplo.'
});

// Añadimos tarjeta para "Ejercicios Temas POO"
pages.push({
  title: 'Ejercicios Temas POO',
  href: 'ejercicios-temas-poo.html',
  description: 'Práctica de conceptos POO: Clases, Objetos, Constructor, Herencia, Interfaz, Clases Abstractas y Polimorfismo.'
});

// Añadimos tarjeta para la nueva página "Trabajos Autónomos"
pages.push({
  title: 'Trabajos Autónomos - Investigación y Análisis',
  href: 'trabajos-autonomos.html',
  description: 'Actividades de investigación técnica y ensayos sobre Java y programación orientada a objetos.'
});

// Añadimos tarjeta para "Clase Práctica"
pages.push({
  title: 'Clase Práctica - Desarrollo de Programa',
  href: 'clase-practica.html',
  description: 'Ejemplo de código desarrollado durante la creación del Trabajo Autónomo 4.'
});

// Añadimos tarjeta para "Videos de Ejercicios en Clase" - Enlace a Google Drive
pages.push({
  title: 'Videos de Ejercicios Desarrollados en Clase',
  href: 'https://drive.google.com/drive/folders/175wdD0Z5zasjrHCy6rzqJpAT-K2fHqBW?hl=es',
  description: 'Accede a los videos de los ejercicios prácticos desarrollados durante las clases de POO.',
  external: true,
  isVideo: true
});

const container = document.getElementById('cards');
if(container){
  pages.forEach(p => {
    const a = document.createElement('a');
    a.className = 'card-link';
    a.href = p.href;
    // Si es un enlace externo, abrir en nueva pestaña
    if (p.external) {
      a.target = '_blank';
      a.rel = 'noopener noreferrer';
    }
    a.setAttribute('aria-label', p.title);

    // Agregar clase especial para tarjetas de video
    const cardClass = p.isVideo ? 'card card-video' : 'card';

    a.innerHTML = `
      <article class="${cardClass}">
        <h3>${p.title}</h3>
        <p>${p.description}</p>
      </article>
    `;

    // Efecto pequeño al presionar
    a.addEventListener('mousedown', () => a.querySelector('.card').classList.add('is-pressed'));
    a.addEventListener('mouseup', () => a.querySelector('.card').classList.remove('is-pressed'));
    a.addEventListener('mouseleave', () => a.querySelector('.card').classList.remove('is-pressed'));

    container.appendChild(a);
  });
}

/* Fondo animado: moléculas geométricas flotando (canvas) */
(function(){
  const canvas = document.createElement('canvas');
  canvas.id = 'bg-canvas';
  document.body.appendChild(canvas);
  const ctx = canvas.getContext('2d');
  let DPR = Math.max(1, window.devicePixelRatio || 1);
  let width = 0, height = 0;
  const atoms = [];

  function rand(min,max){ return Math.random()*(max-min)+min; }

  function resize(){
    DPR = Math.max(1, window.devicePixelRatio || 1);
    width = canvas.width = Math.floor(window.innerWidth * DPR);
    height = canvas.height = Math.floor(window.innerHeight * DPR);
    canvas.style.width = window.innerWidth + 'px';
    canvas.style.height = window.innerHeight + 'px';
    ctx.setTransform(DPR,0,0,DPR,0,0);
    initAtoms();
  }
  window.addEventListener('resize', resize);
  window.addEventListener('orientationchange', resize);

  function initAtoms(){
    atoms.length = 0;
    const count = Math.max(25, Math.floor((window.innerWidth * window.innerHeight) / 50000));
    for(let i=0;i<count;i++){
      atoms.push({
        x: rand(0, window.innerWidth),
        y: rand(0, window.innerHeight),
        r: rand(5, 14),
        vx: rand(-0.25, 0.25),
        vy: rand(-0.25, 0.25),
        isGold: Math.random() > 0.5,
      });
    }
  }

  function drawAtom(a, t){
    const gold = a.isGold;
    
    // Órbita externa (anillo de electrones)
    ctx.beginPath();
    ctx.strokeStyle = gold ? `hsla(45,85%,65%,0.2)` : `hsla(220,10%,55%,0.3)`;
    ctx.lineWidth = 1;
    ctx.arc(a.x, a.y, a.r * 2.5, 0, Math.PI*2);
    ctx.stroke();

    // Forma geométrica molecular (octaedro rotativo)
    const scale = a.r * 1.8;
    const vertices = [
      { x: Math.cos(t * 0.0004) * scale, y: Math.sin(t * 0.0004) * scale * 0.6 },
      { x: Math.cos(t * 0.0004 + Math.PI / 1.5) * scale, y: Math.sin(t * 0.0004 + Math.PI / 1.5) * scale * 0.6 },
      { x: Math.cos(t * 0.0004 + 2 * Math.PI / 1.5) * scale, y: Math.sin(t * 0.0004 + 2 * Math.PI / 1.5) * scale * 0.6 },
      { x: Math.cos(t * 0.0004 + Math.PI) * scale * 0.5, y: Math.sin(t * 0.0004 + Math.PI) * scale * 0.3 },
    ];
    
    // Dibujar líneas de forma geométrica
    for(let i = 0; i < vertices.length; i++){
      const v1 = vertices[i];
      const v2 = vertices[(i + 1) % vertices.length];
      ctx.beginPath();
      ctx.strokeStyle = gold ? `hsla(45,80%,60%,0.4)` : `hsla(220,12%,50%,0.4)`;
      ctx.lineWidth = 1;
      ctx.moveTo(a.x + v1.x, a.y + v1.y);
      ctx.lineTo(a.x + v2.x, a.y + v2.y);
      ctx.stroke();
    }

    // Núcleo con gradiente radial
    ctx.beginPath();
    const g = ctx.createRadialGradient(a.x, a.y, 0, a.x, a.y, a.r);
    if(gold){
      g.addColorStop(0, `hsla(45,100%,70%,1)`);
      g.addColorStop(0.5, `hsla(45,95%,60%,0.95)`);
      g.addColorStop(1, `hsla(45,85%,50%,0.7)`);
    } else {
      g.addColorStop(0, `hsla(220,10%,65%,1)`);
      g.addColorStop(0.5, `hsla(220,8%,55%,0.95)`);
      g.addColorStop(1, `hsla(220,6%,45%,0.7)`);
    }
    ctx.fillStyle = g;
    ctx.arc(a.x, a.y, a.r, 0, Math.PI*2);
    ctx.fill();
    
    // Borde del núcleo
    ctx.beginPath();
    ctx.strokeStyle = gold ? `hsla(45,85%,55%,0.9)` : `hsla(220,10%,40%,0.8)`;
    ctx.lineWidth = 1.5;
    ctx.arc(a.x, a.y, a.r, 0, Math.PI*2);
    ctx.stroke();

    // Electrones orbitando (3 electrones distribuidos)
    const orbitR = a.r * 3;
    const electronCount = 3;
    for(let i=0;i<electronCount;i++){
      const angle = t * 0.0005 * (1 + i * 0.5) + (i * 2 * Math.PI / electronCount);
      const ex = a.x + Math.cos(angle) * orbitR;
      const ey = a.y + Math.sin(angle) * (orbitR * 0.6);
      
      // Electron brillante
      ctx.beginPath();
      ctx.fillStyle = gold ? `hsla(45,95%,85%,0.95)` : `hsla(220,15%,75%,0.9)`;
      ctx.arc(ex, ey, 3, 0, Math.PI*2);
      ctx.fill();
      
      // Brillo del electron
      ctx.beginPath();
      ctx.fillStyle = gold ? `hsla(45,100%,95%,0.6)` : `hsla(220,20%,85%,0.5)`;
      ctx.arc(ex, ey, 1.5, 0, Math.PI*2);
      ctx.fill();
    }
  }

  function animate(t){
    ctx.clearRect(0,0,canvas.width, canvas.height);
    
    // Dibujar conexiones entre átomos cercanos
    const connectionDistance = 300;
    for(let i = 0; i < atoms.length; i++){
      for(let j = i + 1; j < atoms.length; j++){
        const dx = atoms[i].x - atoms[j].x;
        const dy = atoms[i].y - atoms[j].y;
        const distance = Math.sqrt(dx * dx + dy * dy);
        
        if(distance < connectionDistance){
          const opacity = 1 - (distance / connectionDistance);
          
          // Determinar color basado en los átomos
          let strokeColor;
          if(atoms[i].isGold && atoms[j].isGold){
            strokeColor = `hsla(45,85%,65%,${opacity * 0.5})`;
          } else if(!atoms[i].isGold && !atoms[j].isGold){
            strokeColor = `hsla(220,10%,55%,${opacity * 0.5})`;
          } else {
            strokeColor = `hsla(30,60%,60%,${opacity * 0.4})`;
          }
          
          // Línea de conexión principal
          ctx.beginPath();
          ctx.strokeStyle = strokeColor;
          ctx.lineWidth = 2.5;
          ctx.moveTo(atoms[i].x, atoms[i].y);
          ctx.lineTo(atoms[j].x, atoms[j].y);
          ctx.stroke();
          
          // Línea de brillo (efecto glow)
          ctx.beginPath();
          ctx.strokeStyle = strokeColor.replace(String(opacity * 0.5), String(opacity * 0.25));
          ctx.lineWidth = 5;
          ctx.moveTo(atoms[i].x, atoms[i].y);
          ctx.lineTo(atoms[j].x, atoms[j].y);
          ctx.stroke();
          
          // Puntos de conexión en los extremos
          ctx.beginPath();
          ctx.fillStyle = strokeColor.replace(String(opacity * 0.5), String(opacity * 0.7));
          ctx.arc(atoms[i].x, atoms[i].y, 4, 0, Math.PI*2);
          ctx.fill();
          
          ctx.beginPath();
          ctx.fillStyle = strokeColor.replace(String(opacity * 0.5), String(opacity * 0.7));
          ctx.arc(atoms[j].x, atoms[j].y, 4, 0, Math.PI*2);
          ctx.fill();
        }
      }
    }
    
    // Dibujar átomos con geometría molecular
    for(const a of atoms){
      a.x += a.vx;
      a.y += a.vy;
      if(a.x < -60) a.x = window.innerWidth + 60;
      if(a.x > window.innerWidth + 60) a.x = -60;
      if(a.y < -60) a.y = window.innerHeight + 60;
      if(a.y > window.innerHeight + 60) a.y = -60;
      drawAtom(a, t);
    }
    requestAnimationFrame(animate);
  }

  resize();
  requestAnimationFrame(animate);
})();
