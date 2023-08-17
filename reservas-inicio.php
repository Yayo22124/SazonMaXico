<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link
    href="https://fonts.googleapis.com/css2?family=Bree+Serif&family=Gudea:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;500;600;700&family=Pacifico&display=swap"
    rel="stylesheet">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <!-- links CSS -->
  <!-- <link rel="stylesheet" href="/Normalize.css"> #### da algunos fallos-->
  <link rel="stylesheet" href="./styles/reservas.css">
  <link rel="stylesheet" href="./styles/footer-styles.css">
  <link rel="stylesheet" href="./styles/navbar.css">
  <link rel="stylesheet" href="./styles/politica.css">
  <link rel="stylesheet" href="./styles/scroll-styles.css">


  <!-- favicon -->
  <link rel="shortcut icon" href="./img/Xicote.svg" type="image/x-icon">

  <title>Reserva</title>
</head>

<body>
  <div id="privacy-modal" class="modal">
    <div class="modal-content">
      <span class="close" id="close-modal">&times;</span>
      <h2>Política de Privacidad</h2>
      <p>
        Esta Política de Privacidad describe cómo se recopilan y utilizan los datos personales que proporcionas
        en
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
        Mantenemos tus datos personales confidenciales y aplicamos medidas de seguridad para protegerlos de
        acceso no
        autorizado.
      </p>
      <h3>Consentimiento</h3>
      <p>
        Al utilizar esta aplicación, das tu consentimiento para la recopilación y uso de tus datos personales
        según lo
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
      <li class="dropdown-nav"><a href="./evento1.php">Eventos</a></li>
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
    <div id="fondo_blanco">
      <h1 id="title">Reservas</h1>
      <h2 class="sub_title">Revisa nuestra disponibilidad y reserva la fecha y hora que más te convengan</h2>
      <p class="texto">Bienvenido a Sazón México, un destino gastronómico que te llevará en un viaje de sabores por la
        rica y diversa cocina mexicana. En nuestro acogedor restaurante, cada platillo está cuidadosamente elaborado
        para ofrecerte una auténtica experiencia culinaria. Nuestra pasión por los ingredientes frescos y auténticos se
        refleja en cada bocado.</p>
      <!-- !Primeras mesas de la parte de arriba -->

      <div id="numeros">
        <div class="circle">
          <span class="number">1</span>
        </div>
        <div class="circle">
          <span class="number">2</span>
        </div>
        <div class="circle">
          <span class="number">3</span>
        </div>
      </div>
      <div id="mesas">
        <img class="mesa_circular" src="./image.php?src=./img/img-reservas-platillos/mesa-cuatro.png" alt="">
        <img class="mesa_circular" src="./image.php?src=./img/img-reservas-platillos/mesa-cuatro.png" alt="">
        <img class="mesa_circular" src="./image.php?src=./img/img-reservas-platillos/mesa-cuatro.png" alt="">
      </div>

      <!-- !Primeras mesas de la parte de arriba -->
      <!-- * Primeras mesas de la parte izquierda -->
      <div id="numeros2">
        <div class="circle2">
          <span class="number">4</span>
        </div>

        <div class="circle2">
          <span class="number">5</span>
        </div>
      </div>
      <div id="mesas_rectangulares">
        <img class="mesa_rectangular" src="./image.php?src=./img/img-reservas-platillos/mesa-ocho.png" alt="">
        <img class="mesa_rectangular" src="./image.php?src=./img/img-reservas-platillos/mesa-ocho.png" alt="">

      </div>
      <div id="numeros2">
        <div class="circle2">
          <span class="number">6</span>
        </div>

        <div class="circle2">
          <span class="number">7</span>
        </div>

      </div>

      <div id="mesas_rectangulares">
        <img class="mesa_rectangular" src="./image.php?src=./img/img-reservas-platillos/mesa-ocho.png" alt="">
        <img class="mesa_rectangular" src="./image.php?src=./img/img-reservas-platillos/mesa-ocho.png" alt="">
      </div>


      <!-- * Primeras mesas de la parte izquierda -->
      <!-- !Primeras mesas de la parte de abajo -->
      <div id="numeros">
        <div class="circle">
          <span class="number">8</span>
        </div>
        <div class="circle">
          <span class="number">9</span>
        </div>
        <div class="circle">
          <span class="number">10</span>
        </div>
      </div>
      <div id="mesas">

        <img class="mesa_circular" src="./image.php?src=./img/img-reservas-platillos/mesa-cuatro.png" alt="">
        <img class="mesa_circular" src="./image.php?src=./img/img-reservas-platillos/mesa-cuatro.png" alt="">
        <img class="mesa_circular" src="./image.php?src=./img/img-reservas-platillos/mesa-cuatro.png" alt="">

      </div>
      <!-- !Primeras mesas de la parte de abajo -->
      <p class="texto">Siempre estamos listos para satisfacer todas sus necesidades y requerimientos durante su comida
        especial. Llame al <a href="tel:+52 764 764 3687" class="phone">+52 764-764-3687</a> o llene los siguientes
        campos para darle una reserva de nuestras diferentes mesas y revisar su disponibilidad y el numero de mesa o
        mesas y sobre todo de personas que tendra la mesa</p>
      <h1 id="lol">Reserva de Mesas</h1>
      <form id="reservation-form">
        <label for="num_mesa">Número de mesa:</label><br>
        <input type="number" id="num_mesa" name="num_mesa" placeholder="Número de mesa" required><br>

        <label for="fecha_reserva">Fecha de reserva:</label><br>
        <input type="date" id="fecha_reserva" name="fecha_reserva" required><br>


        <label for="hora_reserva">Hora de reserva:</label><br>
        <input type="time" id="hora_reserva" name="hora_reserva" required><br>

        <input id="submit" type="submit" value="¡Reservar!">
      </form>
      <div id="confirmacion"></div>
      <script src="/sazonmaxico/reserva_horario.js"></script>



      <header class="parallax">
        <h1>Reseña</h1>
      </header>

      <section class="contenedor">
        <div class="linea"></div>
        <h1 id="title">Sazon MaXico</h1>
        <div class="linea"></div>
        <div id="content1">
          <div id="content">
            <p class="inicio">"¡Bienvenidos a Nuestra Experiencia Gastronómica en Sazon MaXico!

              En Sazon MaXico, nuestra pasión es ofrecer una fusión excepcional de sabores auténticos y creatividad
              culinaria
              en cada platillo.
              Nuestra página de reseñas es el lugar donde tus sentidos encuentran su voz.
              Aquí, tus experiencias se convierten en historias compartidas y tus paladares son los protagonistas.
              <br><br>
              Te invitamos a explorar, comentar y compartir tus propias reseñas. Tu voz es fundamental para el corazón
              de
              nuestra cocina.
              Cada opinión es una chispa que ilumina nuestro compromiso de ofrecerte una experiencia inolvidable.
              Únete a nosotros en esta travesía culinaria, donde cada reseña es un paso hacia el deleite y la
              satisfacción."
              <br><br>
              Recuerda que esta es solo una sugerencia y puedes personalizarla según la atmósfera y el estilo de tu
              restaurante.
              La clave es comunicar la pasión por la comida y la experiencia excepcional que brinda tu restaurante a
              través de
              las reseñas.
            </p>
          </div>
          <span id="expand-button">Ver más</span>
          <script src="/sazonmaxico/js/resena1.js"></script>
        </div>

        <div id="contenedor-resena">
          <p>Reseñas</p>
          <p>más de MXN500</p>
          <p>Latinoamericana</p>
        </div>
        <div class="puntuacion">
          <span class="estrella" onclick="agregarPuntuacion(this)">&#9733;</span>
          <span class="estrella" onclick="agregarPuntuacion(this)">&#9733;</span>
          <span class="estrella" onclick="agregarPuntuacion(this)">&#9733;</span>
          <span class="estrella" onclick="agregarPuntuacion(this)">&#9733;</span>
          <span class="estrella" onclick="agregarPuntuacion(this)">&#9733;</span>
        </div>
        <div class="reseña">
          <textarea placeholder="Escribe tu reseña aquí..."></textarea>
          <button onclick="agregarReseña(this)">Agregar Reseña</button>
          <script src="./js/resena.js"></script>
        </div>


      </section>
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

</html>