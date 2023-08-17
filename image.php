<?php
require 'vendor/autoload.php'; // Carga Composer autoloader
use Intervention\Image\ImageManagerStatic as Image;

// Ruta de la imagen original
$imagePath = $_GET['src'];

// Cargar la imagen y comprimirla
$image = Image::make($imagePath)->encode('webp', 80); // 80 es la calidad de compresión

// Establecer las cabeceras para entregar la imagen
header('Content-Type: image/webp');
header('Cache-Control: public, max-age=2592000'); // Caché por 30 días

// Mostrar la imagen al navegador
echo $image;
?>
