<?php
// auth.php

function isLoggedIn($conn) {
    if (isset($_COOKIE['auth_token'])) {
        $token = $_COOKIE['auth_token'];

        // Verificar si el token existe y está dentro de su período de validez
        $current_time = date('Y-m-d H:i:s');
        $check_token_query = "SELECT COUNT(*) AS count FROM tb_keyring WHERE token = ? AND fecha_expiracion > ?";
        $stmt = mysqli_prepare($conn, $check_token_query);

        if ($stmt) {
            mysqli_stmt_bind_param($stmt, "ss", $token, $current_time);
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);
            $row = mysqli_fetch_assoc($result);

            if ($row['count'] > 0) {
                return true;
            }
        }
    }

    return false;
}
?>
