// obtener elementos del DOM
const ver = document.getElementById('ver');
const ocultar = document.getElementById('ocultar');
const input = document.getElementById('password-input');

// para cuando se quiera ver la contraseña
function verContrasenia() {
    input.type = "text";
    ver.style.display = "none";
    ocultar.style.display = "inline";
}

// para cuando se quiera ver la contraseña
function ocultarContrasenia() {
    input.type = "password";
    ver.style.display = "inline";
    ocultar.style.display = "none";
}