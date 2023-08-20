<?php
$servername = "154.56.47.154";
$username = "u147672553_Raul";
$password = "Raul53rrb53";
$database = "u147672553_sazonmaxico";

$conn = mysqli_connect($servername, $username, $password, $database);

if (!$conn) {
    die("Conexión fallida: " . mysqli_connect_error());
}
?>
