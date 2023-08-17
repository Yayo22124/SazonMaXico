<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
  <link rel="stylesheet" href="./styles/menu-del-dia.css">
  <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script> -->

  <!-- Tittle Page -->
  <title>SazónMáXico | Menú del Día</title>
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
  <!-- END NAV BAR -->
  <div class="contentToConvert" id="contentToConvert">

    <div id="fondo">
      <div id="fondo_blanco">
        <h1 id="titulo_menu" style="text-align: center; font-size: 50px;">MENU DEL DIA <span>LUNES</span></h1>
        <div class="circulo">
          <p id="uno">1</p>
        </div>
        <h2 class="title">ELIJE UN PLATILLO</h2>


        <div id="carta">
          <!-- *Aqui empieza las tarjetas de los platillos* -->
          <div id="contenedor">
            <div class="card">
              <div class="contenido">
                <span></span>
                <div class="img">
                  <img src="./image.php?src=./img/img-reservas-platillos/pechugas.png" alt="" class="platillos">
                </div>
                <h3>Pechuga Empanizada</h3>
                <p style="margin-top: 20px;">Con arroz a la mexicana, ensalada de lechuga con jitomate. (160 g)</p>
              </div>
            </div>
          </div>
          <!-- *Primer platillo finaliza aqui* -->
          <!-- !Comienza otro platillo -->
          <div id="contenedor">
            <div class="card">
              <div class="contenido">
                <span></span>
                <div class="img">
                  <img src="./image.php?src=./img/img-reservas-platillos/enmoladas.png" alt="" class="platillos">
                </div>
                <h3>Enchiladas Caseras</h3>
                <p style="margin-top: 20px;">Rellenas de cerdo guisado, bañadas con salsa pasilla, verde o roja,
                  servidas
                  con crema, queso, cebolla
                  y
                  cilantro. (7 piezas)</p>
              </div>
            </div>
          </div>
          <!-- !segundo platillo finaliza aqui -->
          <!-- *Comienza otro platillo -->
          <div id="contenedor">
            <div class="card">
              <div class="contenido">
                <span></span>
                <div class="img">
                  <img src="./image.php?src=./img/img-reservas-platillos/tostadas.png" alt="" class="platillos">
                </div>
                <h3>TOSTADAS CON CHORIZO</h3>
                <p style="margin-top: 20px;">Con salsas incluidas y mas condimentos al gusto del cliente(5 piezas)</p>
              </div>
            </div>
          </div>
        </div>

        <!-- !Aqui comienza la segunda seccion! -->
        <div class="circulo">
          <p id="uno">2</p>
        </div>
        <h2 class="title">ELIJE UNA SOPA</h2>
        <div id="carta">
          <!-- *Aqui empieza las tarjetas de los platillos* -->
          <div id="contenedor">
            <div class="card">
              <div class="contenido">
                <span></span>
                <div class="img">
                  <img src="./image.php?src=./img/img-reservas-platillos/sopa_caldo.png" alt="" class="platillos">
                </div>
                <h3>Consomé con arroz y pollo</h3>
                <p style="margin-top: 20px;">Aceite de oliva,
                  Cebolla,
                  Ajo,
                  Zanahorias,
                  Caldo de pollo,
                  Pechuga de pollo,
                  Arroz blanco,
                  Sal y pimienta,
                  Hojas de laurel ,
                  Perejil fresco </p>
              </div>
            </div>
          </div>
          <!-- *Primer platillo finaliza aqui* -->
          <!-- !Comienza otro platillo -->
          <div id="contenedor">
            <div class="card">
              <div class="contenido">
                <span></span>
                <div class="img">
                  <img src="./image.php?src=./img/img-reservas-platillos/sopa.png" alt="" class="platillos">
                </div>
                <h3>Sopa de fideos</h3>
                <p style="margin-top: 20px;">Aceite de oliva,
                  Cebolla,
                  Ajo,
                  Zanahorias,
                  Apio,
                  Caldo de pollo o caldo de verduras,
                  Fideos,
                  Sal y pimienta
                  Perejil fresco</p>
              </div>
            </div>
          </div>
          <!-- !segundo platillo finaliza aqui -->
          <!-- *Comienza otro platillo -->
          <div id="contenedor">
            <div class="card">
              <div class="contenido">
                <span></span>
                <div class="img">
                  <img src="./image.php?src=./img/img-reservas-platillos/sopa_letras.png" alt="" class="platillos">
                </div>
                <h3>Sopa de letras</h3>
                <p style="margin-top: 20px;">Cebolla,
                  Ajo,
                  Zanahorias,
                  Apio,
                  Caldo de pollo o caldo de verduras,
                  Tomates triturados en lata,
                  Pasta de letras,
                  Sal y pimienta(160 g)</p>
              </div>
            </div>
          </div>
        </div>
        <!-- *Aqui finaliza la segunda seccion -->


        <div class="circulo">
          <p id="uno">3</p>
        </div>
        <h2 class="title">ELIGE 1 DE NUESTRAS <br> 3 OPCIONES DE <br> BEBIDAS</h2>
        <div id="carta">
          <!-- *Aqui empieza las tarjetas de los platillos* -->
          <div id="contenedor">
            <div class="card">
              <div class="contenido">
                <span></span>
                <div class="img">
                  <img src="./image.php?src=./img/img-reservas-platillos/refrescos.png" alt="" class="bebidas">
                </div>
                <h3>Refrescos</h3>
                <p style="margin-top: 20px;">Todos tu refrescos favoritos estan aqui </p>
              </div>
            </div>
          </div>
          <!-- *Primer platillo finaliza aqui* -->
          <!-- !Comienza otro platillo -->
          <div id="contenedor">
            <div class="card">
              <div class="contenido">
                <span></span>
                <div class="img">
                  <img src="./image.php?src=./img/img-reservas-platillos/limonada.png" alt="" class="bebidas">
                </div>
                <h3>Limonada</h3>
                <p style="margin-top: 20px;">La limonada es una refrescante y deliciosa bebida cítrica, perfecta para
                  aliviar la sed en los días
                  calurosos.</p>
              </div>
            </div>
          </div>
          <!-- !segundo platillo finaliza aqui -->
          <!-- *Comienza otro platillo -->
          <div id="contenedor">
            <div class="card">
              <div class="contenido">
                <span></span>
                <div class="img">
                  <img src="./image.php?src=./img/img-reservas-platillos/naranjada.png" alt="" class="bebidas">
                </div>
                <h3>Naranjada</h3>
                <p style="margin-top: 20px;">La naranjada es una refrescante y vibrante bebida de origen cítrico que
                  conquista con su alegre y
                  soleado sabor.</p>
              </div>
            </div>
          </div>
          <!-- *tercer platillo finaliza aqui -->
        </div>
        <h2 class="ultimo_titulo">Este menú esta disponible en el restaurante hoy mismo</h2>
      </div>
    </div>
  </div>
  <div class="boton-container">
    <button id="downloadPdfButton">Descargar Menu</button>

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
<!-- Scripts -->
<script src="./js/nav-bar.js"></script>
<script src="./js/politica.js"></script>
<script>
  // Agregar un evento al botón para activar la generación del PDF
  document.getElementById('downloadPdfButton').addEventListener('click', () => {
    // URL del archivo PDF que deseas descargar
    const pdfUrl = './pdf/menu-del-dia.pdf';

    // Crea un enlace temporal
    const downloadLink = document.createElement('a');
    downloadLink.href = pdfUrl;

    // Establece el nombre del archivo que se descargará
    downloadLink.download = 'menu-del-dia-pdf.pdf';

    // Agrega el enlace al documento y haz clic en él para iniciar la descarga
    document.body.appendChild(downloadLink);
    downloadLink.click();

    // Elimina el enlace temporal del documento
    document.body.removeChild(downloadLink);
  });
</script>

</html>