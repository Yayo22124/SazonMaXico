<!DOCTYPE html>
<html lang="es">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <!-- icon page -->
  <link rel="shortcut icon" href="/sazonmaxico/img/Xicote.svg" type="image/x-icon">
  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link
    href="https://fonts.googleapis.com/css2?family=Bree+Serif&family=Gudea:ital,wght@0,400;0,700;1,400&family=Inter:wght@300;400;500;600;700&family=Pacifico&display=swap"
    rel="stylesheet">

  <!-- CSS Link -->
  <link rel="stylesheet" href="/sazonmaxico/styles/index-styles.css">
  <link rel="stylesheet" href="/sazonmaxico/styles/scroll-styles.css">
  <link rel="stylesheet" href="/sazonmaxico/styles/parallax.css">
  <link rel="stylesheet" href="/sazonmaxico/styles/footer-styles.css">
  <link rel="stylesheet" href="/sazonmaxico/styles/navbar.css">
  <link rel="stylesheet" href="/sazonmaxico/styles/menu-del-dia.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>

  <!-- Tittle Page -->
  <title>SazónMáXico | Menú del Día</title>
</head>

<body>
  <!-- Nav Bar -->
  <nav class="bar">
    <!-- Logo -->
    <img src="/sazonmaxico/img/navbar-icons/logo-recortado.svg" alt="SázonMáXico" class="logo">
    <!-- Links Menu -->
    <ul class="links">
      <li><a href="/sazonmaxico/index.php">Inicio</a></li>
      <li><a href="/sazonmaxico/carta.html">Carta</a></li>
      <li><a href="/sazonmaxico/sazonmaxico/menu-del-dia.php">Menú del Día</a></li>
      <li><a href="#">Eventos</a></li>
      <li><a href="/sazonmaxico/reservas-inicio.html">Reservas</a></li>
    </ul>
    <!-- Iniciar sesion button -->
    <a href="/sazonmaxico/login.php" class="login">Iniciar Sesión</a>
    <!-- Dropdown button -->
    <div class="dropdown-button-container">
      <img src="/sazonmaxico/img/navbar-icons/menu.png" alt="menu" class="dropdown" id="activar-boton"
        onclick="mostrarMenu()">

      <img src="/sazonmaxico/img/navbar-icons/close.png" alt="menu" class="dropdown" id="desactivar-boton"
        onclick="ocultarMenu()">
    </div>

    <!-- dropdown menu -->
    <ul class="dropdown-menu active" id="dropdown-menu">
      <li class="dropdown-nav"><a href="/sazonmaxico/index.php">Inicio</a></li>
      <li class="dropdown-nav"><a href="/sazonmaxico/carta.html">Carta</a></li>
      <li class="dropdown-nav"><a href="/sazonmaxico/menu-del-dia.php">Menú del Día</a></li>
      <li class="dropdown-nav"><a href="/sazonmaxico/evento1.html">Eventos</a></li>
      <li class="dropdown-nav"><a href="/sazonmaxico/reservas-inicio.html">Reservas</a></li>
      <!-- settings -->
      <hr class="dropdown-line">
      <li class="settings"><a href="/sazonmaxico/login.php"><img src="/sazonmaxico/img/navbar-icons/usuario.png"
            alt="user"> Iniciar Sesión</a>
      </li>
      <li class="settings"><a href="#"><img src="/sazonmaxico/img/navbar-icons/documento.png" alt="user">Política y
          Privacidad</a>
      </li>
      <li class="settings"><a href="#"><img src="/sazonmaxico/img/navbar-icons/interrogatorio.png" alt="help">Ayuda</a>
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
                  <img src="/sazonmaxico/img/img-reservas-platillos/pechugas.png" alt="" class="platillos">
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
                  <img src="/sazonmaxico/img/img-reservas-platillos/enmoladas.png" alt="" class="platillos">
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
                  <img src="/sazonmaxico/img/img-reservas-platillos/tostadas.png" alt="" class="platillos">
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
                  <img src="/sazonmaxico/img/img-reservas-platillos/sopa_caldo.png" alt="" class="platillos">
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
                  <img src="/sazonmaxico/img/img-reservas-platillos/sopa.png" alt="" class="platillos">
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
                  <img src="/sazonmaxico/img/img-reservas-platillos/sopa_letras.png" alt="" class="platillos">
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
                  <img src="/sazonmaxico/img/img-reservas-platillos/refrescos.png" alt="" class="bebidas">
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
                  <img src="/sazonmaxico/img/img-reservas-platillos/limonada.png" alt="" class="bebidas">
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
                  <img src="/sazonmaxico/img/img-reservas-platillos/naranjada.png" alt="" class="bebidas">
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
    <button id="downloadPdfButton">Descargar PDF</button>

  </div>
  <!-- footer page -->
  <footer>
    <div class="footer-top">
      <!-- left list -->
      <ul class="footer-list-left">
        <li><a href="/sazonmaxico/carta.html">Carta</a></li>
        <li><a href="/sazonmaxico/reservas-inicio.html">Reserva</a></li>
        <li><a href="#">Política de Privacidad</a></li>
      </ul>
      <!-- center logo -->
      <a href="/sazonmaxico/index.php">
        <img loading="lazy" src="/sazonmaxico/img/index-img/logo-footer.svg" alt="logo SazónMáXico">
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
          <a href="https://www.facebook.com/sazonmaxico" target="_blank">
            <img loading="lazy" src="/sazonmaxico/img/footer-icons/facebook.png" alt="facebook">
          </a>
        </li>
        <li>
          <a href="tel:764 764 3687" target="_blank">
            <img loading="lazy" src="/sazonmaxico/img/footer-icons/tel.png" alt="teléfono">
          </a>
        </li>
        <li>
          <a href="mailto:restaurantesazonmaxico@outlook.com" target="_blank">
            <img loading="lazy" src="/sazonmaxico/img/footer-icons/mail.png" alt="correo">
          </a>
        </li>
      </ul>
    </div>
  </footer>
</body>
<!-- Scripts -->
<script src="/sazonmaxico/js/nav-bar.js"></script>
<script>
  // Agregar un evento al botón para activar la generación del PDF
  document.getElementById('downloadPdfButton').addEventListener('click', () => {
    // Crear una instancia de jsPDF
    const doc = new jsPDF();

    // Obtener el contenido del div
    const contentDiv = document.getElementById('contentToConvert');

    // Generar el PDF a partir del contenido del div
    doc.fromHTML(contentDiv, 15, 15);

    // Descargar el PDF con un nombre específico
    doc.save('menu_del_dia.pdf');
  });
</script>

</html>