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
    <link rel="shortcut icon" href="/img/Xicote.svg" type="image/x-icon">
    <!-- CSS link -->
    <link rel="stylesheet" href="/styles/register-styles.css">
    <link rel="stylesheet" href="/styles/scroll-styles.css">

    <title>SazónMáXico | Crear Cuenta</title>
</head>

<body>
    <!-- Conexion a la BD -->
    <?php include "/php/conexion.php" ?>

    <!-- Envio de datos PHP -->
    <?php
    // Obtener datos del Formularios
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Obtener Nombre
        $nombre = $_POST["nombre"];
        // Obtener Primer Apellido
        $primerA = $_POST["primer_apellido"];
        // Obtener Segundo Apellido
        $segundoA = $_POST["segundo_apellido"];
        // Obtener Correo
        $correo = $_POST["correo"];
        // Obtener Contraseña
        $passwd = $_POST["contrasenia"];

        // Encriptar la contraseña
        $hash_passwd = password_hash($passwd, PASSWORD_DEFAULT);

        $consulta_correo = "SELECT COUNT(*) AS total FROM tbb_usuarios WHERE Correo = '$correo'";
        $resultado_consulta = $conn->query($consulta_correo);

        if ($resultado_consulta) {
            $fila = $resultado_consulta->fetch_assoc();
            $total = $fila["total"];

            if ($total > 0) {
                echo "Ya existe una cuenta con este correo. Por favor, elige otro correo.";
            } else {
                // consulta SQL para registrar los datos
                $sql = "INSERT INTO tbb_usuarios (Nombre, Correo, Passwd) VALUES ('$nombre', '$correo', '$hash_passwd')";



                // Verificar consulta
                if ($conn->query($sql) === TRUE) {
                    header("Location: login.php"); // Redirigir a la página de confirmación
                    $resultado = true;
                    exit;
                } else {
                    echo "Error: " . $sql . "<br>" . $conn->error;
                    $resultado = false;
                }
            }
        } else {
            echo "Error en la consulta: " . $conn->error;
        }

        $conn->close();

    }

    ?>
    <main class="container">
        <!-- left container (form) -->
        <div class="left-container">
            <!-- Header of Form -->
            <header>
                <!-- icon (return) -->
                <a href="/index.html">
                    <img src="/img/return.svg" alt="back">
                </a>
                <!-- logo -->
                <a href="/index.html">
                    <img src="/img/logo-header.svg" alt="logo SazónMaXico">
                </a>
            </header>

            <!-- phrase -->
            <h2><i>Crea una cuenta y accede a más funciones</i></h2>

            <!-- ######## form ######## -->
            <form>
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
                    <input type="text" class="input" name="correo"  required="true" />
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label>Correo Electrónico</label>
                </div>
                <!-- Password Input -->
                <div class="form-control passwd">
                    <input class="input" type="password" required="true" name="passwd" id="password-input">
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label>Contraseña</label>
                    <div class="mostrar-ocultar">
                        <!-- ver contraseña -->
                        <img src="/img/login-register-img/ver.svg" alt="ver contraseña" id="ver"
                            onclick="verContrasenia()">
                        <!-- ocultar contraseña -->
                        <img src="/img/login-register-img/ocultar.svg" alt="Ocultar contraseña" id="ocultar"
                            onclick="ocultarContrasenia()">
                    </div>
                </div>
                <!-- register a -->

                <!-- sign in - button -->
                <button type="submit">Crear Cuenta</button>
                <span class="create-account">¿Ya tienes cuenta? <b class="pd60"><a href="/login.html">Inicia
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
<script src="/js/see-password.js"></script>

</html>