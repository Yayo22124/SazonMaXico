<?php 
    $server = 'localhost';
    $DB = 'bdsazonmaxico';
    $user = "root";
    $password = '';
    try {
        $conexion = new PDO ("mysql:host=$server;dbname=$DB",$user,$password);
    } catch (Exception $e) {
        echo $e->getMessage();
    }
?>