document.addEventListener("DOMContentLoaded", function() {
    var notificationData = <?php echo json_encode($notification); ?>;

    if (notificationData) {
        var notificationContainer = document.getElementById("notification");
        var notificationDiv = document.createElement("div");
        
        notificationDiv.classList.add("notification", notificationData.status);
        notificationDiv.textContent = notificationData.message;
        
        notificationContainer.appendChild(notificationDiv);
        
        setTimeout(function() {
            notificationDiv.style.display = "none";
        }, 5000); // Ocultar la notificación después de 5 segundos
    }
});