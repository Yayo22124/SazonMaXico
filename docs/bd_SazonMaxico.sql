CREATE DATABASE  IF NOT EXISTS `bdsazonmaxico` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bdsazonmaxico`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: bdsazonmaxico
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `tbb_areas`
--

DROP TABLE IF EXISTS `tbb_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_areas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Tipo_Area_ID` int unsigned NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` text,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fn_tipo_area_idx` (`Tipo_Area_ID`),
  CONSTRAINT `fn_tipo_area` FOREIGN KEY (`Tipo_Area_ID`) REFERENCES `tbc_tipo_area` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbb_areas`
--

LOCK TABLES `tbb_areas` WRITE;
/*!40000 ALTER TABLE `tbb_areas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbb_areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbb_espacios`
--

DROP TABLE IF EXISTS `tbb_espacios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_espacios` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Area_ID` int unsigned NOT NULL,
  `Descripcion` text,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Observaciones` text,
  `Capacidad` int NOT NULL,
  `Fecha_Registro` datetime NOT NULL,
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fn_tipo_area_idx` (`Area_ID`),
  CONSTRAINT `fn_areas2` FOREIGN KEY (`Area_ID`) REFERENCES `tbb_areas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbb_espacios`
--

LOCK TABLES `tbb_espacios` WRITE;
/*!40000 ALTER TABLE `tbb_espacios` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbb_espacios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbb_eventos`
--

DROP TABLE IF EXISTS `tbb_eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_eventos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Usuario_ID` int unsigned DEFAULT NULL,
  `Area_ID` int unsigned DEFAULT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Estatus` bit(1) NOT NULL,
  `Descripcion` text,
  `Horario_General_ID` int unsigned DEFAULT NULL,
  `Horario_Especifico_ID` int unsigned DEFAULT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Horario_Especifico_ID_UNIQUE` (`Horario_Especifico_ID`),
  UNIQUE KEY `Horario_General_ID_UNIQUE` (`Horario_General_ID`),
  KEY `fn_usuarios_idx` (`Usuario_ID`),
  KEY `fn_area3_idx` (`Area_ID`),
  CONSTRAINT `fn_area3` FOREIGN KEY (`Area_ID`) REFERENCES `tbb_areas` (`ID`),
  CONSTRAINT `fn_usuarios` FOREIGN KEY (`Usuario_ID`) REFERENCES `tbb_usuarios` (`Persona_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbb_eventos`
--

LOCK TABLES `tbb_eventos` WRITE;
/*!40000 ALTER TABLE `tbb_eventos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbb_eventos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbb_horario_especifico`
--

DROP TABLE IF EXISTS `tbb_horario_especifico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_horario_especifico` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Espacio_ID` int unsigned NOT NULL,
  `Descripcion` text,
  `Fecha_Inicio` datetime NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fn_espacios_horario_idx` (`Espacio_ID`),
  CONSTRAINT `fn_espacios_horario` FOREIGN KEY (`Espacio_ID`) REFERENCES `tbb_espacios` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbb_horario_especifico`
--

LOCK TABLES `tbb_horario_especifico` WRITE;
/*!40000 ALTER TABLE `tbb_horario_especifico` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbb_horario_especifico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbb_horario_general`
--

DROP TABLE IF EXISTS `tbb_horario_general`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_horario_general` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Horario_Especifico_ID` int unsigned NOT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Espacio_ID` int unsigned NOT NULL,
  `Descripcion` text,
  `Fecha` date NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `fn_horario_reservado_idx` (`Horario_Especifico_ID`),
  CONSTRAINT `fn_horario_reservado` FOREIGN KEY (`Horario_Especifico_ID`) REFERENCES `tbb_horario_especifico` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbb_horario_general`
--

LOCK TABLES `tbb_horario_general` WRITE;
/*!40000 ALTER TABLE `tbb_horario_general` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbb_horario_general` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbb_personas`
--

DROP TABLE IF EXISTS `tbb_personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_personas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Genero` enum('F','M') NOT NULL,
  `Correo_Electronico` varchar(255) NOT NULL,
  `Numero_Telefonico` varchar(45) DEFAULT NULL,
  `Fecha_Nacimiento` date NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbb_personas`
--

LOCK TABLES `tbb_personas` WRITE;
/*!40000 ALTER TABLE `tbb_personas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbb_personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbb_platillos`
--

DROP TABLE IF EXISTS `tbb_platillos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_platillos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Categoria_ID` int unsigned NOT NULL,
  `Puntuacion_ID` int unsigned NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Precio` int NOT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  `Descripcion` text NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fn_clasificacion_platillo_idx` (`Categoria_ID`),
  KEY `fn_puntuacion_platillo_idx` (`Puntuacion_ID`),
  CONSTRAINT `fn_clasificacion_platillo` FOREIGN KEY (`Categoria_ID`) REFERENCES `tbc_categorias_platillos` (`ID`),
  CONSTRAINT `fn_puntuacion_platillo` FOREIGN KEY (`Puntuacion_ID`) REFERENCES `tbb_puntuacion` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbb_platillos`
--

LOCK TABLES `tbb_platillos` WRITE;
/*!40000 ALTER TABLE `tbb_platillos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbb_platillos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbb_puntuacion`
--

DROP TABLE IF EXISTS `tbb_puntuacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_puntuacion` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Usuario_ID` int unsigned NOT NULL,
  `Calificacion` int DEFAULT NULL,
  `Comentario` text,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fn_usuario_idx` (`Usuario_ID`),
  CONSTRAINT `fn_usuario` FOREIGN KEY (`Usuario_ID`) REFERENCES `tbb_usuarios` (`Persona_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbb_puntuacion`
--

LOCK TABLES `tbb_puntuacion` WRITE;
/*!40000 ALTER TABLE `tbb_puntuacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbb_puntuacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbb_reservas`
--

DROP TABLE IF EXISTS `tbb_reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_reservas` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Horario_ID` int unsigned NOT NULL,
  `Mesa_Asignada` int unsigned NOT NULL,
  `Cantidad_Personas` int unsigned NOT NULL,
  `Estatus` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ID`),
  KEY `fn_horario_reservado_idx` (`Horario_ID`),
  CONSTRAINT `fn_reserva_horario` FOREIGN KEY (`Horario_ID`) REFERENCES `tbb_horario_general` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbb_reservas`
--

LOCK TABLES `tbb_reservas` WRITE;
/*!40000 ALTER TABLE `tbb_reservas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbb_reservas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbb_ubicaciones`
--

DROP TABLE IF EXISTS `tbb_ubicaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_ubicaciones` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Espacio_ID` int unsigned DEFAULT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Direccion` varchar(255) NOT NULL,
  `Descripcion` text,
  `Fecha_Regitro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fn_espacio_ubicado_idx` (`Espacio_ID`),
  CONSTRAINT `fn_espacio_ubicado` FOREIGN KEY (`Espacio_ID`) REFERENCES `tbb_espacios` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbb_ubicaciones`
--

LOCK TABLES `tbb_ubicaciones` WRITE;
/*!40000 ALTER TABLE `tbb_ubicaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbb_ubicaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbb_usuarios`
--

DROP TABLE IF EXISTS `tbb_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_usuarios` (
  `Persona_ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Tipo` enum('Administrador','Cliente') NOT NULL DEFAULT 'Cliente',
  `Edad` int NOT NULL,
  `Estatus` enum('Activo','Inactivo') NOT NULL DEFAULT 'Inactivo',
  `Historial_Reservas` varchar(255) DEFAULT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`Persona_ID`),
  CONSTRAINT `fn_persona_usuario` FOREIGN KEY (`Persona_ID`) REFERENCES `tbb_personas` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbb_usuarios`
--

LOCK TABLES `tbb_usuarios` WRITE;
/*!40000 ALTER TABLE `tbb_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbb_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbc_categorias_platillos`
--

DROP TABLE IF EXISTS `tbc_categorias_platillos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbc_categorias_platillos` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` text NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Ultima_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbc_categorias_platillos`
--

LOCK TABLES `tbc_categorias_platillos` WRITE;
/*!40000 ALTER TABLE `tbc_categorias_platillos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbc_categorias_platillos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbc_tipo_area`
--

DROP TABLE IF EXISTS `tbc_tipo_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbc_tipo_area` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbc_tipo_area`
--

LOCK TABLES `tbc_tipo_area` WRITE;
/*!40000 ALTER TABLE `tbc_tipo_area` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbc_tipo_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'bdsazonmaxico'
--

--
-- Dumping routines for database 'bdsazonmaxico'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-04  9:01:41
