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
    session_start();

    // Verificar si ya existe una sesión iniciada
    if (isset($_SESSION['user_id'])) {
        // Redirigir al home correspondiente (administrador o cliente)
        if ($_SESSION['user_type'] === 'Administrador') {
            header("Location: home-Admin.php");
        } else {
            header("Location: index.php");
        }
        exit();
    }

    // Realizar la verificación de inicio de sesión si se envió el formulario
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Obtener los datos del formulario
        $correo = $_POST["correo"];
        $password = $_POST["password"];

        // Realizar la consulta para verificar el correo y contraseña
        $login_query = "SELECT * FROM tbb_usuarios WHERE Email = '$correo'";
        $result = mysqli_query($conn, $login_query);

        if ($result && mysqli_num_rows($result) > 0) {
            $user_data = mysqli_fetch_assoc($result);
            if (password_verify($password, $user_data['Password'])) {
                // Inicio de sesión exitoso
                $_SESSION['user_id'] = $user_data['Persona_ID'];
                $tipo_usuario = $user_data['Tipo'];

                // Redirigir al home correspondiente (administrador o cliente)
                if ($tipo_usuario == 'Administrador') {
                    header("Location: carta.php");
                    $notification = array('error');
                } else {
                    header("Location: index.php");
                }
                exit();
            } else {
                $notification = array("status" => "error", "message" => "Contraseña incorrecta.");
            }
        } else {
            $notification = array("status" => "error", "message" => "El correo no está registrado.");
        }
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