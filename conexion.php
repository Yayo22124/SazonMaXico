<?php
$servername = "localhost";
$username = "root";
$password = "022124Haziel02#";
$database = "bd_sazonmaxico";

$conn = mysqli_connect($servername, $username, $password, $database);

if (!$conn) {
    die("Conexión fallida: " . mysqli_connect_error());
}
?>
