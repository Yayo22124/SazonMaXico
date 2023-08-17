<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- <link rel="stylesheet" href="/Normalize.css"> -->
  <link rel="shortcut icon" href="./image.php?src=./img/Xicote.svg" type="image/x-icon">
  <link rel="stylesheet" href="./styles/menu-del-dia.css">
  <link rel="stylesheet" href="./styles/evento1.css">
  <link rel="stylesheet" href="./styles/eventos2.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
  <!-- icon page -->
  <link rel="shortcut icon" href="./image.php?src=./img/Xicote.svg" type="image/x-icon">
  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link
    href="https://fonts.googleapis.com/css2?family=Bree+Serif&family=Gudea:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;500;600;700&family=Pacifico&display=swap"
    rel="stylesheet">

  <!-- CSS Link -->
  <link rel="stylesheet" href="./styles/evento.css">
  <link rel="stylesheet" href="./styles/reservas.css">
  <link rel="stylesheet" href="./styles/scroll-styles.css">
  <link rel="stylesheet" href="./styles/footer-styles.css">
  <link rel="stylesheet" href="./styles/navbar.css">

  <!-- Tittle Page -->
  <title>SazónMáXico | Eventos</title>
</head>

<body>
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
    <img src="./image.php?src=./img/navbar-icons/logo-recortado.svg" alt="SázonMáXico" class="logo">
    <!-- Links Menu -->
    <ul class="links">
      <li><a href="./index.php">Inicio</a></li>
      <li><a href="./carta.php">Carta</a></li>
      <li><a href="./menu-del-dia.php">Menú del Día</a></li>
      <li><a href="./evento1.php">Eventos</a></li>
      <li><a href="./reservas-inicio.php">Reservas</a></li>
    </ul>
    <!-- Iniciar sesion button -->
    <a href="./login.php" class="login">Iniciar Sesión</a>
    <!-- Dropdown button -->
    <div class="dropdown-button-container">
      <img src="./image.php?src=./img/navbar-icons/menu.png" alt="menu" class="dropdown" id="activar-boton"
        onclick="mostrarMenu()">

      <img src="./image.php?src=./img/navbar-icons/close.png" alt="menu" class="dropdown" id="desactivar-boton"
        onclick="ocultarMenu()">
    </div>

    <!-- dropdown menu -->
    <ul class="dropdown-menu active" id="dropdown-menu">
      <li class="dropdown-nav"><a href="./index.php">Inicio</a></li>
      <li class="dropdown-nav"><a href="./carta.php">Carta</a></li>
      <li class="dropdown-nav"><a href="./menu-del-dia.php">Menú del Día</a></li>
      <li class="dropdown-nav"><a href="./evento1.html">Eventos</a></li>
      <li class="dropdown-nav"><a href="./reservas-inicio.php">Reservas</a></li>
      <!-- settings -->
      <hr class="dropdown-line">
      <li class="settings"><a href="./login.php"><img src="./image.php?src=./img/navbar-icons/usuario.png" alt="user">
          Iniciar Sesión</a>
      </li>
      <li class="settings"><a href="#" id="privacy-link"><img src="./image.php?src=./img/navbar-icons/documento.png"
            alt="user">Política y
          Privacidad</a>
      </li>
      <li class="settings"><a href="mailto:220087@utxicotepec.edu.mx"><img
            src="./image.php?src=./img/navbar-icons/interrogatorio.png" alt="help">Ayuda</a>
      </li>
    </ul>
  </nav>
  <!-- ################ END NAV BAR #################-->

  <div id="fondo">
    <div id="fondo_blanco" style="background-color: rgb(255, 228, 196)">
      <p>Eventos</p>
      <div class="imgevento1"><img src="./image.php?src=./img/img-enventos/image 23.svg" alt=""></div>
      <div class="fondo3">
        <p>
          ¡Una gran opción para ti y para tu dia especial!
        </p>
        <p class="texto">Manejamos gran variedad de eventos y podemos brindarte lo que necesites.
          Para mas informacion y poder llevar acabo tu evento de una mejor forma.
          Aqui estan nuestros diferentes contactos o acude a el restaurante y podremos ayudarte de una forma mucho mas
          precisa.

          Numero de teléfono: 776-112-1211

          Correo Electronico: sazonmaxico@outlook.com</p> <br> <br>
      </div>
      <div class="imgevento1"><img src="./image.php?src=./img/img-enventos/image 25.svg" alt=""></div>
      <div class="recuadro1">
        <p>Familiar</p>
        <div class="iconofamilia"><img src="./image.php?src=./img/img-enventos/family.png" alt=""></div>
      </div>
      <div class="bloquefamilia1">
        <div class="familia1"><img src="./image.php?src=./img/img-enventos/FB_IMG_1687126322003.jpg" alt=""></div>
        <div class="familia2"><img src="./image.php?src=./img/img-enventos/FB_IMG_1687126477911.jpg" alt=""></div>
      </div>
      <p>Social</p>
      <p class="texto">VEN, Y DISFRUTA DE LA

        MEJOR COMIDA CASERA EN

        COMPAÑIA DE TUS SERES QUERIDOS.</p>
      <div class="bloquefamilia2">
        <div class="familia3"><img src="./image.php?src=./img/img-enventos/FB_IMG_1687123199865.jpg" alt=""></div>
      </div>
      <p>Educativo</p>
      <div class="bloquefamilia3">
        <div class="familia1"><img src="./image.php?src=./img/img-enventos/FB_IMG_1687126407369.jpg" alt=""></div>
        <div class="familia2"><img src="./image.php?src=./img/img-enventos/FB_IMG_1687132314814.jpg" alt=""></div>
      </div>
      <div class="agendacion">
        <p>¡agenda tu evento ya!</p>
        <h2>Envianos un correo electronico o llame <a href="tel:+52 764 764 3687" class="phone">+52
            764-764-3687</a> o agenda tu evento aquí mismo solo tienes que iniciar sesión.</h2>

        <form id="reservation-form">
          <label for="nombre">Tu nombre:</label><br>
          <input type="text" id="nombre" name="nombre" placeholder="Juan Pedro"><br>

          <label for="correo">Tu correo electrónico:</label><br>
          <input type="email" id="correo" name="correo" placeholder="persona_falsa@hotmail.com" required><br>

          <label for="num_mesa">Número de mesa:</label><br>
          <input type="number" id="num_mesa" name="num_mesa" placeholder="Número de mesa" required><br>

          <input id="submit" type="submit" value="¡Reservar!">
        </form>
        <div id="confirmacion"></div>
        <script src="./reserva_horario.js"></script>
      </div>
    </div>


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
<script src="./js/nav-bar.js"></script>
<script src="./js/politica.js"></script>
</body>

</html>