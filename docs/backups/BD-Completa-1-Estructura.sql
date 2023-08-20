
CREATE DATABASE  IF NOT EXISTS `u147672553_sazonmaxico` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `u147672553_sazonmaxico`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 154.56.47.52    Database: u117932138_bdsazonmaxico
-- ------------------------------------------------------
-- Server version	5.5.5-10.6.14-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_keyring`
--

DROP TABLE IF EXISTS `tb_keyring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_keyring` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `token` varchar(250) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  `fecha_expiracion` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_user_id_idx` (`user_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `tbb_usuarios` (`Persona_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla para almacenar tokens de usuarios';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbb_areas`
--

DROP TABLE IF EXISTS `tbb_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_areas` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Tipo_Area_ID` int(10) unsigned NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Estatus` bit(1) NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT current_timestamp(),
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fn_tipo_area_idx` (`Tipo_Area_ID`),
  CONSTRAINT `fn_tipo_area` FOREIGN KEY (`Tipo_Area_ID`) REFERENCES `tbc_tipo_area` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbb_eventos`
--

DROP TABLE IF EXISTS `tbb_eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_eventos` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Usuario_ID` int(10) unsigned NOT NULL,
  `Area_ID` int(10) unsigned NOT NULL,
  `Horario_General_ID` int(10) unsigned NOT NULL,
  `Horario_Especifico_ID` int(10) unsigned NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Tipo` enum('Familiar','Social','Educativo') NOT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Descripcion` text DEFAULT NULL,
  `Fecha_Registro` datetime DEFAULT current_timestamp(),
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fn_usuarios_idx` (`Usuario_ID`),
  KEY `fn_area3_idx` (`Area_ID`),
  KEY `fn_horario_general1_idx` (`Horario_General_ID`),
  KEY `fn_horario_especifico1_idx` (`Horario_Especifico_ID`),
  CONSTRAINT `fn_area3` FOREIGN KEY (`Area_ID`) REFERENCES `tbb_areas` (`ID`),
  CONSTRAINT `fn_horario_especifico1` FOREIGN KEY (`Horario_Especifico_ID`) REFERENCES `tbb_horario_especifico` (`ID`),
  CONSTRAINT `fn_horario_general1` FOREIGN KEY (`Horario_General_ID`) REFERENCES `tbb_horario_general` (`ID`),
  CONSTRAINT `fn_usuarios` FOREIGN KEY (`Usuario_ID`) REFERENCES `tbb_usuarios` (`Persona_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbb_horario_especifico`
--

DROP TABLE IF EXISTS `tbb_horario_especifico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_horario_especifico` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Descripcion` text DEFAULT NULL,
  `Fecha_Inicio` datetime NOT NULL,
  `Fecha_Fin` datetime NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT current_timestamp(),
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbb_horario_general`
--

DROP TABLE IF EXISTS `tbb_horario_general`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_horario_general` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Horario_Especifico_ID` int(10) unsigned NOT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Fecha` date NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT current_timestamp(),
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fn_horario_reservado_idx` (`Horario_Especifico_ID`),
  CONSTRAINT `fn_horario_reservado` FOREIGN KEY (`Horario_Especifico_ID`) REFERENCES `tbb_horario_especifico` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbb_menu_del_dia`
--

DROP TABLE IF EXISTS `tbb_menu_del_dia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_menu_del_dia` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Fecha` date NOT NULL,
  `Platillo_ID` int(10) unsigned NOT NULL,
  `Precio` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `unique_menu_platillo` (`Fecha`,`Platillo_ID`),
  KEY `fk_menu_platillo` (`Platillo_ID`),
  CONSTRAINT `fk_menu_platillo` FOREIGN KEY (`Platillo_ID`) REFERENCES `tbb_platillos` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbb_personas`
--

DROP TABLE IF EXISTS `tbb_personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_personas` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  `Primer_Apellido` varchar(50) NOT NULL,
  `Segundo_Apellido` varchar(50) NOT NULL,
  `Genero` enum('F','M') NOT NULL,
  `Numero_Telefonico` varchar(45) DEFAULT NULL,
  `Fecha_Nacimiento` date NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT current_timestamp(),
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbb_platillos`
--

DROP TABLE IF EXISTS `tbb_platillos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_platillos` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Categoria_ID` int(10) unsigned NOT NULL,
  `Puntuacion` float NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Precio` int(11) NOT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Descripcion` text NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT current_timestamp(),
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fn_clasificacion_platillo_idx` (`Categoria_ID`),
  CONSTRAINT `fn_clasificacion_platillo` FOREIGN KEY (`Categoria_ID`) REFERENCES `tbc_categorias_platillos` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbb_puntuacion`
--

DROP TABLE IF EXISTS `tbb_puntuacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_puntuacion` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Usuario_ID` int(10) unsigned NOT NULL,
  `Platillo_ID` int(10) unsigned NOT NULL,
  `Calificacion` int(11) DEFAULT NULL,
  `Comentario` text DEFAULT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT current_timestamp(),
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fn_usuario_idx` (`Usuario_ID`),
  KEY `fk_platillo_idx` (`Platillo_ID`),
  CONSTRAINT `fk_platillo` FOREIGN KEY (`Platillo_ID`) REFERENCES `tbb_platillos` (`ID`),
  CONSTRAINT `fn_usuario` FOREIGN KEY (`Usuario_ID`) REFERENCES `tbb_usuarios` (`Persona_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbb_reservas`
--

DROP TABLE IF EXISTS `tbb_reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_reservas` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Horario_Especifico_ID` int(10) unsigned NOT NULL,
  `Usuario_ID` int(10) unsigned NOT NULL,
  `Mesa_Asignada` int(10) unsigned NOT NULL,
  `Cantidad_Personas` int(10) unsigned NOT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Fecha_Registro` datetime NOT NULL DEFAULT current_timestamp(),
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fn_reserva_horario_idx` (`Horario_Especifico_ID`),
  KEY `fk_reserva_usuario_idx` (`Usuario_ID`),
  CONSTRAINT `fk_reserva_usuario` FOREIGN KEY (`Usuario_ID`) REFERENCES `tbb_usuarios` (`Persona_ID`),
  CONSTRAINT `fn_reserva_horario` FOREIGN KEY (`Horario_Especifico_ID`) REFERENCES `tbb_horario_especifico` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbb_ubicaciones`
--

DROP TABLE IF EXISTS `tbb_ubicaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_ubicaciones` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Direccion` varchar(255) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT current_timestamp(),
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbb_usuarios`
--

DROP TABLE IF EXISTS `tbb_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_usuarios` (
  `Persona_ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Nombre_Usuario` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(250) NOT NULL,
  `Tipo` enum('Administrador','Cliente') NOT NULL DEFAULT 'Cliente',
  `Edad` int(11) NOT NULL,
  `Estatus` enum('Activo','Inactivo') NOT NULL DEFAULT 'Inactivo',
  `Fecha_Registro` datetime NOT NULL DEFAULT current_timestamp(),
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`Persona_ID`),
  UNIQUE KEY `Email_UNIQUE` (`Email`),
  CONSTRAINT `fn_persona_usuario` FOREIGN KEY (`Persona_ID`) REFERENCES `tbb_personas` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbc_categorias_platillos`
--

DROP TABLE IF EXISTS `tbc_categorias_platillos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbc_categorias_platillos` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` text NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT current_timestamp(),
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbc_tipo_area`
--

DROP TABLE IF EXISTS `tbc_tipo_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbc_tipo_area` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` varchar(255) DEFAULT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT current_timestamp(),
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbi_bitacora`
--

DROP TABLE IF EXISTS `tbi_bitacora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbi_bitacora` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_bd` varchar(80) NOT NULL,
  `tabla` varchar(80) NOT NULL,
  `operacion` enum('Create','Read','Update','Delete') NOT NULL,
  `descripcion_completa` text NOT NULL,
  `fecha_hora` datetime NOT NULL DEFAULT current_timestamp(),
  `estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-17  2:29:33
