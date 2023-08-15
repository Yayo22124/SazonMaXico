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
    <link rel="shortcut icon" href="/sazonmaxico/img/Xicote.svg" type="image/x-icon">
    <!-- CSS link -->
    <link rel="stylesheet" href="/sazonmaxico/styles/notification.css">
    <link rel="stylesheet" href="/sazonmaxico/styles/login-styles.css">

    <title>SazónMáXico | Iniciar Sesión</title>
</head>

<body>
    <!-- Conexion a la BD -->
    <?php include "conexion.php" ?>

    <!-- Envio de datos PHP -->
    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Obtener los datos del formulario
        $correo = $_POST["correo"];
        $password = $_POST["password"]; // Asegúrate de tener un campo 'password' en tu formulario
    
        // Verificar las credenciales del usuario en la base de datos
        $check_user_query = "SELECT ID, Email, Password FROM tbb_usuarios WHERE Email = '$correo'";
        $result_user = mysqli_query($conn, $check_user_query);
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
                $user_id = $user_data['ID'];
                $insert_token_query = "INSERT INTO tb_keyring (user_id, token, fecha_creacion, fecha_expiracion) VALUES ($user_id, '$token', '$creation_time', '$expiration_time')";
                $result_token = mysqli_query($conn, $insert_token_query);

                if ($result_token) {
                    // Redirigir al usuario a su página de inicio o al panel
                    header("Location: /sazonmaxico/index.php"); // Cambia la URL a la página deseada
                    exit();
                } else {
                    $notification = array("status" => "error", "message" => "Error al generar el token: " . mysqli_error($conn));
                }
            } else {
                $notification = array("status" => "error", "message" => "Contraseña incorrecta.");
            }
        } else {
            $notification = array("status" => "error", "message" => "Usuario no encontrado.");
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
                <a href="/sazonmaxico/index.html">
                    <img src="/sazonmaxico/img/return.svg" alt="back">
                </a>
                <!-- logo -->
                <a href="/sazonmaxico/index.html">
                    <img src="/sazonmaxico/img/logo-header.svg" alt="logo SazónMaXico">
                </a>
            </header>

            <!-- phrase -->
            <h2><i>“Un lugar diferente para un paladar exigente”</i></h2>

            <!-- ######## form ######## -->
            <form method="post">
                <!-- Email Input -->
                <div class="form-control">
                    <!-- <input type="Email" placeholder="Correo Electrónico"> -->

                    <input type="text" class="input" required="true" />
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label>Correo Electrónico</label>
                </div>
                <!-- Password Input -->
                <div class="form-control passwd">
                    <input class="input" type="password" required="true" id="password-input">
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label>Contraseña</label>
                    <div class="mostrar-ocultar">
                        <!-- ver contraseña -->
                        <img src="/sazonmaxico/img/login-register-img/ver.svg" alt="ver contraseña" id="ver"
                            onclick="verContrasenia()">
                        <!-- ocultar contraseña -->
                        <img src="/sazonmaxico/img/login-register-img/ocultar.svg" alt="Ocultar contraseña" id="ocultar"
                            onclick="ocultarContrasenia()">
                    </div>
                </div>
                <!-- sign in - button -->
                <button type="submit" class="login">Iniciar Sesión</button>
                <!-- register a -->
                <span class="create-account">¿No tienes cuenta? <b><a href="/sazonmaxico/register.php">Crea
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
<script src="/sazonmaxico/js/see-password.js"></script>
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