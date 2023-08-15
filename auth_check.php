<?php
// auth.php

function isLoggedIn() {
    if (isset($_SESSION['user_id'])) {
        // El usuario tiene un ID de sesión, lo consideramos logueado
        return true;
    } else {
        return false;
    }
}

?>
