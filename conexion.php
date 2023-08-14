<?php 
    $server = 'localhost';
    $DB = 'bd_sazonmaxico';
    $user = "root";
    $password = '022124Haziel02#';
    try {
        $conexion = new PDO ("mysql:host=$server;dbname=$DB",$user,$password);
    } catch (Exception $e) {
        echo $e->getMessage();
    }
?>