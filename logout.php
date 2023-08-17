<?php
session_start();

// Destruye la sesión
session_destroy();

// Redirige a la página de inicio
header("Location: index.php");
exit();
?>
