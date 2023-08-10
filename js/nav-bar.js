// obtener el boton (imagen)
const button1 = document.getElementById("activar-boton");
const button2 = document.getElementById("desactivar-boton");

const menu = document.getElementById("dropdown-menu");

function mostrarMenu() {
    // muestra el menu
    menu.style.visibility = "visible";
    menu.style.zIndex = "10";
    menu.style.maxHeight = "400px";
    // oculta el boton de activar menu
    button1.style.display = "none";
    // muestra el boton de ocultar boton
    button2.style.display = "block";
}

function ocultarMenu() {
    // oculta el menu
    menu.style.maxHeight = "0";
    menu.style.zIndex = "0";
    menu.style.visibility = "hidden";
    // muestra el boton de activar menu
    button1.style.display = "block";
    // oculta el boton de ocultar boton
    button2.style.display = "none";
    
}