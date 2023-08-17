<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Google Fonts Link -->
    <!-- Montserrat (300, 400, 600, 700) -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,300;0,400;0,500;0,600;0,700;1,400;1,600;1,700&display=swap"
        rel="stylesheet">
    <link rel="shortcut icon" href="./img/Xicote.svg" type="image/x-icon">
    <!-- CSS link -->
    <link rel="stylesheet" href="./styles/notification.css">
    <link rel="stylesheet" href="./styles/login-styles.css">

    <title>SazónMáXico | Iniciar Sesión</title>
</head>

<body>
    <!-- Conexion a la BD -->
    <?php include "conexion.php" ?>

    <!-- Envio de datos PHP -->
    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        error_reporting(E_ALL);
        ini_set('display_errors', '1');

        // Obtener los datos del formulario
        $correo = $_POST["correo"];
        $password = $_POST["password"];
    
        // Verificar las credenciales del usuario en la base de datos
        $check_user_query = "SELECT Persona_ID, Email, 'Password', Tipo FROM tbb_usuarios WHERE Email = $correo";
        $stmt = mysqli_prepare($conn, $check_user_query);

        if ($stmt) {
            mysqli_stmt_bind_param($stmt, "s", $correo);
            mysqli_stmt_execute($stmt);
            $result_user = mysqli_stmt_get_result($stmt);
            $user_data = mysqli_fetch_assoc($result_user);

            if ($user_data) {
                // Verificar la contraseña
                if (password_verify($password, $user_data['Password'])) {
                    // Generar un token único
                    $token = bin2hex(random_bytes(32)); // Genera un token hexadecimal de 64 caracteres
    
                    // Calcular las fechas de creación y expiración
                    $creation_time = date('Y-m-d H:i:s');
                    $expiration_time = date('Y-m-d H:i:s', strtotime('+1 hour')); // Una hora después de la creación
    
                    // Insertar el token en la tabla tb_keyring
                    $user_id = $user_data['Persona_ID'];
                    $insert_token_query = "INSERT INTO tb_keyring (user_id, token, fecha_creacion, fecha_expiracion) VALUES (?, ?, ?, ?)";
                    $stmt_insert = mysqli_prepare($conn, $insert_token_query);

                    if ($stmt_insert) {
                        mysqli_stmt_bind_param($stmt_insert, "isss", $user_id, $token, $creation_time, $expiration_time);
                        $result_token = mysqli_stmt_execute($stmt_insert);

                        if ($result_token) {
                            // Redirigir según el tipo de usuario
                            if ($user_data['Tipo'] === 'Administrador') {
                                header("Location: ./home-Admin.php"); // Redirigir a la página de administradores
                                exit();
                            } elseif ($user_data['Tipo'] === 'Cliente') {
                                header("Location: ./index.php"); // Redirigir a la página de clientes
                                exit();
                            } else {
                                $notification = array("status" => "error", "message" => "Tipo de usuario desconocido.");
                            }
                        } else {
                            $notification = array("status" => "error", "message" => "Error al generar el token: " . mysqli_error($conn));
                        }

                        mysqli_stmt_close($stmt_insert);
                    } else {
                        $notification = array("status" => "error", "message" => "Error en la preparación de la consulta: " . mysqli_error($conn));
                    }
                } else {
                    $notification = array("status" => "error", "message" => "Contraseña incorrecta.");
                }
            } else {
                $notification = array("status" => "error", "message" => "Usuario no encontrado.");
            }

            mysqli_stmt_close($stmt);
        } else {
            $notification = array("status" => "error", "message" => "Error en la preparación de la consulta: " . mysqli_error($conn));
        }

        // Cerrar la conexión
        mysqli_close($conn);
    }
    ?>

    <main class="container">
        <!-- left container (form) -->
        <div class="left-container">
            <!-- Header of Form -->
            <header>
                <!-- icon (return) -->
                <a href="./index.php">
                    <img src="./image.php?src=./img/return.svg" alt="back">
                </a>
                <!-- logo -->
                <a href="./index.php">
                    <img src="./image.php?src=./img/logo-header.svg" alt="logo SazónMaXico">
                </a>
            </header>

            <!-- phrase -->
            <h2><i>“Un lugar diferente para un paladar exigente”</i></h2>

            <!-- ######## form ######## -->
            <form method="post">
                <!-- Email Input -->
                <div class="form-control">
                    <!-- <input type="Email" placeholder="Correo Electrónico"> -->

                    <input type="text" class="input" required="true" name="correo" id="correo" />
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label>Correo Electrónico</label>
                </div>
                <!-- Password Input -->
                <div class="form-control passwd">
                    <input class="input" type="password" required="true" id="password-input" name="password">
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label>Contraseña</label>
                    <div class="mostrar-ocultar">
                        <!-- ver contraseña -->
                        <img src="./image.php?src=./img/login-register-img/ver.svg" alt="ver contraseña" id="ver"
                            onclick="verContrasenia()">
                        <!-- ocultar contraseña -->
                        <img src="./image.php?src=./img/login-register-img/ocultar.svg" alt="Ocultar contraseña"
                            id="ocultar" onclick="ocultarContrasenia()">
                    </div>
                </div>
                <!-- sign in - button -->
                <button type="submit" class="login">Iniciar Sesión</button>
                <!-- register a -->
                <span class="create-account">¿No tienes cuenta? <b><a href="./register.php">Crea
                            una</a></b></span>
            </form>
        </div>
        <!-- right container (bg image) -->
        <div class="right-container">
            <!-- <img src="/img/restaurant.png" alt="Restaurant Background Image"> -->
        </div>
    </main>
</body>
<!-- scripts -->
<script src="./js/see-password.js"></script>
<!-- notifications -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var notificationData = <?php echo json_encode($notification); ?>;

        if (notificationData) {
            var notificationContainer = document.getElementById("notification");
            var notificationDiv = document.createElement("div");

            notificationDiv.classList.add("notification", notificationData.status);
            notificationDiv.textContent = notificationData.message;

            notificationContainer.style.maxHeight = "auto";
            notificationContainer.style.display = "block";
            notificationDiv.style.display = "block";
            notificationContainer.appendChild(notificationDiv);

            setTimeout(function () {
                notificationDiv.style.display = "none";
                notificationContainer.style.display = "none";
                notificationContainer.style.maxHeight = "0";
            }, 5000); // Ocultar la notificación después de 5 segundos
        }
    });
</script>

</html>