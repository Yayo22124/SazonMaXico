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
    <link rel="stylesheet" href="/sazonmaxico/styles/register-styles.css">
    <link rel="stylesheet" href="/sazonmaxico/styles/scroll-styles.css">
    <link rel="stylesheet" href="/sazonmaxico/styles/notification.css">

    <title>SazónMáXico | Crear Cuenta</title>
</head>

<body>
    <!-- Conexion a la BD -->
    <?php include "conexion.php" ?>

    <!-- Envio de datos PHP -->
    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Obtener los datos del formulario
        $nombre = $_POST["nombre"];
        $primer_apellido = $_POST["primer_apellido"];
        $segundo_apellido = $_POST["segundo_apellido"];
        $correo = $_POST["correo"];
        $fecha_nacimiento = $_POST["date"];
        $genero = $_POST["genero"];
        $password = $_POST["passwd"];

        // Verificar si el correo ya existe en la tabla tbb_usuarios
        $check_email_query = "SELECT COUNT(*) AS count FROM tbb_usuarios WHERE Email = '$correo'";
        $result_email = mysqli_query($conn, $check_email_query);
        $email_data = mysqli_fetch_assoc($result_email);

        if ($email_data['count'] > 0) {
            // El correo ya está registrado, mostrar un mensaje de error
            $notification = array("status" => "error", "message" => "Este correo ya está registrado. Por favor, elige otro correo.");
        } else {
            // Insertar datos en la tabla tbb_personas
            $insert_persona_query = "INSERT INTO tbb_personas (Nombre, Primer_Apellido, Segundo_Apellido, Genero, Fecha_Nacimiento) VALUES ('$nombre', '$primer_apellido', '$segundo_apellido', '$genero', '$fecha_nacimiento')";
            $result_persona = mysqli_query($conn, $insert_persona_query);

            if ($result_persona) {
                // Obtener el ID de la persona recién insertada
                $persona_id = mysqli_insert_id($conn);

                // Insertar datos en la tabla tbb_usuarios
                $hashed_password = password_hash($password, PASSWORD_DEFAULT); // Hashear la contraseña
                $insert_usuario_query = "INSERT INTO tbb_usuarios (Persona_ID, Nombre_Usuario, Email, Password) VALUES ('$persona_id', '$nombre', '$correo', '$hashed_password')";
                $result_usuario = mysqli_query($conn, $insert_usuario_query);

                if ($result_usuario) {
                    // Registro exitoso
                    $notification = array("status" => "success", "message" => "Registro exitoso!");
                } else {
                    $notification = array("status" => "error", "message" => "Error al registrar el usuario: " . mysqli_error($conn));
                }
            } else {
                $notification = array("status" => "error", "message" => "Error al registrar la persona: " . mysqli_error($conn));
            }
        }

        // Cerrar la conexión
        mysqli_close($conn);
    }

    ?>
    <div class="notification" id="notification"></div>
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
            <h2><i>Crea una cuenta y accede a más funciones</i></h2>

            <!-- ######## form ######## -->
            <form method="POST">
                <!-- Name Input -->
                <div class="form-control">
                    <input type="text" class="input" name="nombre" required="true" />
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label>Nombre</label>
                </div>
                <!-- apellido paterno Input -->
                <div class="form-control">
                    <input type="text" class="input" name="primer_apellido" required="true" />
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label>Primer Apellido</label>
                </div>
                <!-- apellido materno Input -->
                <div class="form-control">
                    <input type="text" class="input" name="segundo_apellido" required="true" />
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label>Segundo Apellido</label>
                </div>
                <!-- Email Input -->
                <div class="form-control">
                    <!-- <input type="Email" placeholder="Correo Electrónico"> -->
                    <input type="text" class="input" name="correo" required="true" />
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label>Correo Electrónico</label>
                </div>
                <!-- Fecha Nacimiento  -->
                <div class="form-control date">
                    <label for="birth">Fecha de Nacimiento</label>
                    <input type="date" id="birth" name="date">
                </div>
                <!-- Genero -->
                <div class="form-control genero">
                    <label for="genero">Genero</label>
                    <select name="genero" id="genero">
                        <option value="M">Masculino</option>
                        <option value="F">Femenino</option>
                    </select>
                </div>
                <!-- Password Input -->
                <div class="form-control passwd">
                    <input class="input" type="password" required="true" name="passwd" id="password-input">
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
                <!-- register a -->

                <!-- sign in - button -->
                <button type="submit">Crear Cuenta</button>
                <span class="create-account">¿Ya tienes cuenta? <b class="pd60"><a href="/sazonmaxico/login.html">Inicia
                            Sesión</a></b></span>
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

            notificationContainer.appendChild(notificationDiv);

            setTimeout(function () {
                notificationDiv.style.display = "none";
            }, 5000); // Ocultar la notificación después de 5 segundos
        }
    });
</script>

</html>