<?php
$servername = "154.56.47.52";
$username = "u117932138_raul";
$password = "Raul53rrb53";
$database = "u117932138_bdsazonmaxico";

$conn = mysqli_connect($servername, $username, $password, $database);

if (!$conn) {
    die("Conexión fallida: " . mysqli_connect_error());
}
?>
