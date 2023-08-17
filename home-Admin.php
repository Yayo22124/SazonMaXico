<!DOCTYPE php>
<php lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- links -->
        <link rel="shortcut icon" href="./img/Xicote.svg" type="image/x-icon">
        <link rel="stylesheet" href="./styles/home-admin.css">
        <link rel="stylesheet" href="./styles/scroll-styles.css">
        <link rel="stylesheet" href="./styles/parallax.css">
        <link rel="stylesheet" href="./styles/navbar-admin.css">
        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Bree+Serif&family=Gudea:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;500;600;700&family=Pacifico&display=swap"
            rel="stylesheet">

        <title>Inicio | Administrador</title>
    </head>

    <body>
        <!-- Header -->
        <nav>
            <!-- logo -->
            <a href="./home-Admin.php" class="logo">
                <img src="./img/navbar-icons/logo-recortado.svg" alt="logo SazónMáXico">
            </a>


            <!-- Dropdown button -->
            <div class="dropdown-button-container">
                <img src="./image.php?src=./img/navbar-icons/menu.png" alt="menu" class="dropdown" id="activar-boton"
                    onclick="mostrarMenu()">

                <img src="./image.php?src=./img/navbar-icons/close.png" alt="menu" class="dropdown"
                    id="desactivar-boton" onclick="ocultarMenu()">
            </div>

            <!-- dropdown menu -->
            <ul class="dropdown-menu active" id="dropdown-menu">
                <li class="dropdown-nav"><a href="./home-Admin.php">Inicio</a></li>
                <li class="dropdown-nav"><a href="./reservas-Admin.php">Administrar Reservas</a></li>
                <li class="dropdown-nav"><a href="#">Administrar Eventos</a></li>
                <li class="dropdown-nav"><a href="#">Estadísticas</a></li>
                <!-- settings -->
                <hr class="dropdown-line">
                <li class="settings"><a href="./login.php"><img src="./image.php?src=./img/navbar-icons/usuario.png"
                            alt="user"> Cerrar Sesión</a></li>
                <li class="settings"><a href="mailto:220087@utxicotepec.edu.mx"><img
                            src="./img/navbar-icons/interrogatorio.png" alt="help">Ayuda</a></li>
            </ul>
        </nav>

        <!-- main content -->
        <main>
            <h1 class="phrase">
                Conoce tu Negocio
            </h1>

        </main>
        <script src="./js/nav-bar.js"></script>
    </body>
</php>