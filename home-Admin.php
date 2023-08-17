<!DOCTYPE php>
<php lang="en">

    <head>
        <!-- amcharts -->
        <script src="https://cdn.amcharts.com/lib/4/core.js"></script>
        <script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
        <script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- links -->
        <link rel="shortcut icon" href="./img/Xicote.svg" type="image/x-icon">
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
        <!-- conexion a BD -->
        <?php include "conexion.php" ?>
        <!-- usuarios logueados -->
        <?php
        // Incluye la verificación de sesión
        include "check_session.php";
        ?>
        <?php
        // Obtener los datos de la vista desde la base de datos
        $query = "SELECT cliente_id, nombre_cliente, email_cliente, total_reservas FROM vw_historial_clientes_frecuentes ORDER BY total_reservas DESC LIMIT 5";
        $result = mysqli_query($conn, $query);

        // Preparar los datos para la gráfica
        $datos = [];
        while ($fila = mysqli_fetch_assoc($result)) {
            $datos[] = [
                "cliente" => $fila["nombre_cliente"],
                "frecuencia" => $fila["total_reservas"]
            ];
        }
        ?>
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
            <p>Estos son tus clientes más frecuentes en la aplicación.</p>
            <div class="chart-container">
                <!-- div grafica -->
                <div id="chartdiv" style="width: 95%; height: 500px;"></div>
            </div>

        </main>

    </body>
    <script src="./js/nav-bar.js"></script>
    <!-- amcharts -->
    <script>
        // Usar los datos obtenidos de la base de datos
        var chart = am4core.create("chartdiv", am4charts.XYChart);
        chart.data = <?php echo json_encode($datos); ?>;

        // Configurar categoría y valor
        var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
        categoryAxis.dataFields.category = "cliente";
        categoryAxis.renderer.grid.template.location = 0;

        var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
        valueAxis.min = 0;
        valueAxis.max = 10;

        // Título lateral
        chart.leftAxesContainer.layout = "vertical";
        var title = chart.leftAxesContainer.createChild(am4core.Label);
        title.text = "Número de reservas";
        title.fontSize = 14;
        title.align = "center";

        // Crear la serie de columnas
        var series = chart.series.push(new am4charts.ColumnSeries());
        series.dataFields.valueY = "frecuencia";
        series.dataFields.categoryX = "cliente";
        series.name = "Total Reservas";
        series.columns.template.tooltipText = "Cliente: {categoryX}\nTotal Reservas: {valueY}";

        // Etiqueta sobre las columnas
        var labelBullet = series.bullets.push(new am4charts.LabelBullet());
        labelBullet.label.text = "{valueY}";
        labelBullet.label.dy = -10;
        labelBullet.label.fontSize = 12;
        labelBullet.label.fill = am4core.color("#FFFFFF");
        labelBullet.label.hideOversized = false;

        // Configurar etiquetas en las columnas
        series.columns.template.width = am4core.percent(50);
        series.columns.template.column.cornerRadiusTopLeft = 10;
        series.columns.template.column.cornerRadiusTopRight = 10;
        series.columns.template.strokeOpacity = 0;

        // Aplicar colores personalizados alternados
        series.columns.template.adapter.add("fill", function (fill, target) {
            return target.dataItem.index % 2 === 0 ? am4core.color("#F9B338") : am4core.color("#794531");
        });

        // Aplicar colores neutros en tooltips
        series.columns.template.tooltip.getFillFromObject = false;
        series.columns.template.tooltip.background.fill = am4core.color("#E0E0E0");

        // Agregar efecto de animación
        chart.events.on("ready", function () {
            chart.animate({ opacity: 1 }, 1000);
        });
    </script>

</php>