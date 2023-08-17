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
    <link rel="stylesheet" href="./styles/register-styles.css">
    <link rel="stylesheet" href="./styles/scroll-styles.css">
    <link rel="stylesheet" href="./styles/notification.css">
    <link rel="stylesheet" href="./styles/politica.css">
    
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
        $fecha_nacimiento = $_POST["fecha_nacimiento"];
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

                // Calcular la edad utilizando la función fn_calcula_edad
                $edad_query = "SELECT fn_calcula_edad('$fecha_nacimiento') AS edad";
                $result_edad = mysqli_query($conn, $edad_query);
                $edad_data = mysqli_fetch_assoc($result_edad);
                $edad = $edad_data['edad'];

                // Insertar datos en la tabla tbb_usuarios
                $hashed_password = password_hash($password, PASSWORD_DEFAULT); // Hashear la contraseña
                $insert_usuario_query = "INSERT INTO tbb_usuarios (Persona_ID, Nombre_Usuario, Email, Password, Edad) VALUES ('$persona_id', '$nombre', '$correo', '$hashed_password', '$edad')";
                $result_usuario = mysqli_query($conn, $insert_usuario_query);

                if ($result_usuario) {
                    // Registro exitoso
                    $notification = array("status" => "success", "message" => "Registro exitoso!");

                    // Redirigir a la página de inicio de sesión
                    header("Location: ./login.php");
                    exit();
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
    <div id="privacy-modal" class="modal">
        <div class="modal-content">
            <span class="close" id="close-modal">&times;</span>
            <h2>Política de Privacidad</h2>
            <p>
                Esta Política de Privacidad describe cómo se recopilan y utilizan los datos personales que proporcionas en nuestra aplicación web. Al utilizar esta aplicación, aceptas los términos descritos en esta política.
            </p>
            <h3>Datos Recopilados</h3>
            <p>
                Recopilamos los siguientes datos personales:
                <ul>
                    <li>Nombre completo</li>
                    <li>Correo electrónico</li>
                    <li>Edad</li>
                    <li>Fecha de nacimiento</li>
                    <li>Historial en la aplicación</li>
                </ul>
            </p>
            <h3>Uso de Datos</h3>
            <p>
                Utilizamos los datos recopilados para:
                <ul>
                    <li>Personalizar tu experiencia en la aplicación</li>
                    <li>Proporcionar servicios y funciones solicitadas</li>
                    <li>Mejorar nuestros servicios y comunicaciones</li>
                </ul>
            </p>
            <h3>Confidencialidad y Seguridad</h3>
            <p>
                Mantenemos tus datos personales confidenciales y aplicamos medidas de seguridad para protegerlos de acceso no autorizado.
            </p>
            <h3>Consentimiento</h3>
            <p>
                Al utilizar esta aplicación, das tu consentimiento para la recopilación y uso de tus datos personales según lo descrito en esta política.
            </p>
        </div>
    </div>

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
                    <input type="date" id="fecha-nacimiento" name="fecha_nacimiento">
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
                        <img src="./image.php?src=./img/login-register-img/ver.svg" alt="ver contraseña" id="ver"
                            onclick="verContrasenia()">
                        <!-- ocultar contraseña -->
                        <img src="./image.php?src=./img/login-register-img/ocultar.svg" alt="Ocultar contraseña"
                            id="ocultar" onclick="ocultarContrasenia()">
                    </div>
                </div>
                <div class="form-control checkbox">
                    <input type="checkbox" name="acuerdo" id="acuerdo" required>
                    <span for="acuerdo" class="check-text">Aceptas las <a href="#" id="privacy-link">Condiciones</a></span>
                </div>
                <!-- register a -->

                <!-- sign in - button -->
                <button type="submit">Crear Cuenta</button>
                <span class="create-account">¿Ya tienes cuenta? <b class="pd60"><a href="./login.php">Inicia
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
<script src="./js/see-password.js"></script>
<script src="./js/politica.js"></script>

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

<!-- validar edad -->
<script>
    // Obtén el elemento del campo de fecha de nacimiento
    var fechaNacimiento = document.getElementById("fecha-nacimiento");

    // Agrega un evento de cambio al campo de fecha
    fechaNacimiento.addEventListener("change", function() {
        // Obtén la fecha de nacimiento ingresada
        var fechaIngresada = new Date(this.value);

        // Calcula la fecha actual
        var fechaActual = new Date();

        // Calcula la diferencia de años entre la fecha actual y la fecha de nacimiento ingresada
        var edad = fechaActual.getFullYear() - fechaIngresada.getFullYear();

        // Verifica si el mes de nacimiento ya pasó en el año actual
        if (fechaIngresada.getMonth() > fechaActual.getMonth() ||
            (fechaIngresada.getMonth() === fechaActual.getMonth() && fechaIngresada.getDate() > fechaActual.getDate())) {
            edad--;
        }

        // Comprueba si la edad es mayor o igual a 18 años
        if (edad < 18) {
            alert("Debes tener al menos 18 años para registrarte.");
            this.value = ""; // Limpia el campo de fecha
        }
    });
</script>
</html>