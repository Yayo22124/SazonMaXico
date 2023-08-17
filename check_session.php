<?php
session_start();

// Redirige al inicio de sesión si no está logueado
if (!isset($_SESSION['user_id'])) {
    // Puedes personalizar el redireccionamiento
    header("Location: login.php");
    exit();
}
?>
