<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="./styles/carta.css">
  <!-- <link rel="stylesheet" href="/Normalize.css"> -->
  <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">


  <!-- icon page -->
  <link rel="shortcut icon" href="./img/Xicote.svg" type="image/x-icon">
  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link
    href="https://fonts.googleapis.com/css2?family=Bree+Serif&family=Gudea:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;500;600;700&family=Pacifico&display=swap"
    rel="stylesheet">

  <!-- CSS Link -->
  <link rel="stylesheet" href="./styles/index-styles.css">
  <link rel="stylesheet" href="./styles/scroll-styles.css">
  <link rel="stylesheet" href="./styles/parallax.css">
  <link rel="stylesheet" href="./styles/footer-styles.css">
  <link rel="stylesheet" href="./styles/navbar.css">
  <link rel="stylesheet" href="./styles/politica.css">

  <!-- Tittle Page -->
  <title>SazónMáXico | Carta</title>
</head>

<body>
  <div id="privacy-modal" class="modal">
    <div class="modal-content">
      <span class="close" id="close-modal">&times;</span>
      <h2>Política de Privacidad</h2>
      <p>
        Esta Política de Privacidad describe cómo se recopilan y utilizan los datos personales que proporcionas en
        nuestra aplicación web. Al utilizar esta aplicación, aceptas los términos descritos en esta política.
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
        Mantenemos tus datos personales confidenciales y aplicamos medidas de seguridad para protegerlos de acceso no
        autorizado.
      </p>
      <h3>Consentimiento</h3>
      <p>
        Al utilizar esta aplicación, das tu consentimiento para la recopilación y uso de tus datos personales según lo
        descrito en esta política.
      </p>
    </div>
  </div>
  <!-- conexion a BD -->
  <?php include "conexion.php" ?>
  <!-- usuarios logueados -->
  <?php
  // Incluye la verificación de sesión
  include "check_session.php";
  ?>
  <!-- Nav Bar -->
  <nav class="bar">
    <!-- Logo -->
    <img src="./img/navbar-icons/logo-recortado.svg" alt="SázonMáXico" class="logo">
    <!-- Links Menu -->
    <ul class="links">
      <li><a href="./index.php">Inicio</a></li>
      <li><a href="./carta.php">Carta</a></li>
      <li><a href="./menu-del-dia.php">Menú del Día</a></li>
      <li><a href="./evento1.php">Eventos</a></li>
      <li><a href="./reservas-inicio.php">Reservas</a></li>
    </ul>
    <!-- Iniciar sesion button -->
    <!-- <a href="./login.php" class="login">Iniciar Sesión</a> -->
    <?php
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
    if (isset($_SESSION['user_id'])) {
      echo '<a href="./logout.php" class="login">Cerrar Sesión</a>';
    } else {
      echo '<a href="./login.php" class="login">Iniciar Sesión</a>';
    }
    ?>
    <!-- Dropdown button -->
    <div class="dropdown-button-container">
      <img src="./img/navbar-icons/menu.png" alt="menu" class="dropdown" id="activar-boton" onclick="mostrarMenu()">

      <img src="./img/navbar-icons/close.png" alt="menu" class="dropdown" id="desactivar-boton" onclick="ocultarMenu()">
    </div>

    <!-- dropdown menu -->
    <ul class="dropdown-menu active" id="dropdown-menu">
      <li class="dropdown-nav"><a href="./index.php">Inicio</a></li>
      <li class="dropdown-nav"><a href="./carta.php">Carta</a></li>
      <li class="dropdown-nav"><a href="./menu-del-dia.php">Menú del Día</a></li>
      <li class="dropdown-nav"><a href="./evento1.php">Eventos</a></li>
      <li class="dropdown-nav"><a href="./reservas-inicio.php">Reservas</a></li>
      <!-- settings -->
      <hr class="dropdown-line">
      <?php
      if (isset($_SESSION['user_id'])) {
        echo '<li class="settings"><a href="./logout.php"><img src="./img/navbar-icons/usuario.png" alt="user"> Cerrar Sesión</a></li>';
      } else {
        echo '<li class="settings"><a href="./login.php"><img src="./img/navbar-icons/usuario.png" alt="user"> Iniciar Sesión</a></li>';
      }
      ?>
      <li class="settings"><a href="#" id="privacy-link"><img src="./img/navbar-icons/documento.png" alt="user">Política
          y
          Privacidad</a></li>
      <li class="settings"><a href="mailto:220087@utxicotepec.edu.mx"><img src="./img/navbar-icons/interrogatorio.png"
            alt="help">Ayuda</a></li>
    </ul>
  </nav>
  <!-- END NAV BAR -->
  <main id="fondo_cafe">
    <div id="fondo2">

      <div class="imagenes">
        <div class="reboso"> <img
            src="./image.php?src=./img/carta-desayuno/750e6aa8ed4747450cb2b08ea329e89e-removebg-preview (1) 3Reboso.svg"
            alt=""></div>
        <div class="menu1"><img src="./image.php?src=./img/carta-desayuno/menu.svg" alt=""></div>

      </div>

      <div class="menu">
        <img src="./image.php?src=./img/carta-desayuno/Hamburguesa.svg" class="hamburguesa" />
        <div class="menu2">
          <p class="encabezado">Bebidas</p>
          <div class="linea"></div>
          <div class="bebida1">Café Exprés $30</div>
          <div class="bebida1">Capuchino $25</div>
          <div class="bebida1">Agua de frutos $20</div>
          <div class="bebida1">Té $15</div>
          <div class="bebida1">Vino Tinto $80</div>
          <div class="bebida1">Vino Blanco $75</div>
        </div>
      </div>

      <div class="platillos">
        <div class="platillos2">
          <p class="encabezado"> Platillos</p>
          <div class="linea2"></div>
          <div class="platillos1">Enchiladas Suizas $60</div>
          <div class="platillos1">Carne a la plancha $90</div>
          <div class="platillos1">Pozole $100</div>
          <div class="platillos1">Hamburguesas $70</div>
          <div class="platillos1">Camarones al mojo de ajo $160</div>
          <div class="platillos1">Tacos al pastor $60</div>
          <div class="platillos1">Estofado de cerdo $50</div>
        </div>
        <img src="./image.php?src=./img/carta-desayuno/Mole.svg" alt="" class="plato1">
      </div>

      <div class="postres">
        <img src="./image.php?src=./img/carta-desayuno/burrito.svg" alt="" class="platillo1">
        <div class="postres2">
          <div class="encabezado">Postres</div>
          <div class="linea3"></div>
          <div class="postres3">Mus de helado $25</div>
          <div class="postres3">Crepa de cacao $40</div>
          <div class="postres3">Karlota de limón $20</div>
          <div class="postres3">Flan Napolitano $35</div>
          <div class="postres3">Gelatina de mazapán $40</div>
        </div>
      </div>

      <div class="imgultimas">
        <img src="./image.php?src=./img/carta-desayuno/gorro-de-cocinero 2.svg" alt="" class="img1">
        <img src="./image.php?src=./img/carta-desayuno/postre_chocolate_avellana 2.svg" alt="" class="img2">
        <img
          src="./image.php?src=./img/carta-desayuno/750e6aa8ed4747450cb2b08ea329e89e-removebg-preview (1) 3Reboso.svg"
          alt="" class="img3">
      </div>


    </div>


  </main>
  <!-- footer page -->
  <footer>
    <div class="footer-top">
      <!-- left list -->
      <ul class="footer-list-left">
        <li><a href="./carta.php">Carta</a></li>
        <li><a href="./reservas-inicio.php">Reserva</a></li>
        <li><a href="#" id="privacy-link">Política de Privacidad</a></li>
      </ul>
      <!-- center logo -->
      <a href="./index.php">
        <img loading="lazy" src="./image.php?src=./img/index-img/logo-footer.svg" alt="logo SazónMáXico">
      </a>
      <!-- list right -->
      <ul class="footer-list-right">
        <li>
          <h3>horario xicotepec de juarez</h3>
        </li>
        <li>
          Lunes a Jueves
          <br>
          09:00 - 18:00h
        </li>
        <li>
          Viernes a Sábado
          <br>
          10:00 - 20:00h
        </li>
        <li>
          Domingo
          <br>
          10:00 - 17:00h
          <br>
          20:00 - 23:00h
        </li>
      </ul>
    </div>
    <hr>
    <div class="footer-bottom">
      <span>© Copyright 2022 Sazón MáXico - Todos los Derechos Reservados</span>
      <ul class="social">
        <li>
          <a href="https://www.facebook.com." target="_blank">
            <img loading="lazy" src="./image.php?src=./img/footer-icons/facebook.png" alt="facebook">
          </a>
        </li>
        <li>
          <a href="tel:764 764 3687" target="_blank">
            <img loading="lazy" src="./image.php?src=./img/footer-icons/tel.png" alt="teléfono">
          </a>
        </li>
        <li>
          <a href="mailto:restaurantesazonmaxico@outlook.com" target="_blank">
            <img loading="lazy" src="./image.php?src=./img/footer-icons/mail.png" alt="correo">
          </a>
        </li>
      </ul>
    </div>
  </footer>
</body>

<!-- SCRIPTS -->
<script src="./js/nav-bar.js"></script>
<script src="./js/politica.js"></script>

</html>