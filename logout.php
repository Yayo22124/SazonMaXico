<?php
session_start();

// Elimina cualquier variable de sesión
session_unset();

// Destruye la sesión
session_destroy();

// Redirige al usuario a la página de inicio de sesión
header("Location: /sazonmaxico/login.php");
exit();
?>
