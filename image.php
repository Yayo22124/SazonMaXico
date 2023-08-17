<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
require 'vendor/autoload.php';
use Intervention\Image\ImageManagerStatic as Image;

$imagePath = $_GET['src'];

if (!file_exists($imagePath)) {
    header('HTTP/1.0 404 Not Found');
    exit();
}

$image = Image::make($imagePath)->encode('webp', 80);

header('Content-Type: image/webp');
header('Cache-Control: public, max-age=2592000');

echo $image;
?>