function agregarPuntuacion(estrella) {
  const estrellas = document.querySelectorAll('.estrella');

  estrellas.forEach((e, index) => {
      if (index <= Array.from(estrellas).indexOf(estrella)) {
          e.classList.add('pintada');
      } else {
          e.classList.remove('pintada');
      }
  });
}

function agregarReseña(button) {
  const reseñaTextarea = button.previousElementSibling;
  const reseña = reseñaTextarea.value;

  if (reseña.trim() !== '') {
      const reseñaDiv = document.createElement('div');
      reseñaDiv.className = 'reseña-usuario';
      reseñaDiv.innerHTML = `<p>${reseña}</p>`;

      const platillo = button.parentNode.parentNode;
      platillo.appendChild(reseñaDiv);

      reseñaTextarea.value = '';
  }
}

