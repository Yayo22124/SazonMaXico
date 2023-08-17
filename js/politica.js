// Obteniendo el DOM
var privacyLink = document.getElementById("privacy-link");
var privacyModal = document.getElementById("privacy-modal");

// Cuando se haga clic en el enlace, muestra el modal
privacyLink.addEventListener("click", function() {
    privacyModal.style.display = "block";
});

// Cuando se haga clic en el botón de cerrar, oculta el modal
var closeModal = document.getElementById("close-modal");
closeModal.addEventListener("click", function() {
    privacyModal.style.display = "none";
});
