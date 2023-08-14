<?php 
    $server = '154.56.47.52';
    $DB = 'u117932138_bdsazonmaxico';
    $user = "u117932138_raul";
    $password = 'Raul53rrb53';
    try {
        $conexion = new PDO ("mysql:host=$server;dbname=$DB",$user,$password);
    } catch (Exception $e) {
        echo $e->getMessage();
    }
?>