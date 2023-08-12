<?php
$servername = "localhost";
$username = "root";
$password = "contraseña";
$dbname = "bd_sazonmaxico";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$puntuacion = $_POST['puntuacion'];
$usuario_id = $_POST['nombre_usuario'];
$texto = $_POST['texto'];

$sql = "INSERT INTO reseñas (puntuacion, usuario_id, texto) VALUES ('$puntuacion', '$usuario_id', '$texto')";

if ($conn->query($sql) === TRUE) {
    echo "Reseña guardada exitosamente.";
} else {
    echo "Error al guardar la reseña: " . $conn->error;
}

$conn->close();
?>
