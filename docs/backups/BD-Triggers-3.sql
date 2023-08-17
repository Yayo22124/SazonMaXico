CREATE DATABASE  IF NOT EXISTS `u117932138_bdsazonmaxico` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `u117932138_bdsazonmaxico`;
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
v_usuario != "u117932138_raul@%"
DELIMITER ;;
CREATE  TRIGGER `u117932138_bdsazonmaxico`.`tb_keyring_BEFORE_INSERT` BEFORE INSERT ON `tb_keyring` FOR EACH ROW
BEGIN
	-- Eliminar tokens cuando su tiempo de vida expira
    -- Verificar que no exista uno para el usaurio
    DECLARE v_existe_token INT DEFAULT (SELECT COUNT(*) FROM tb_keyring WHERE user_id = new.user_id);
    IF (v_existe_token>0) THEN
		DELETE FROM tb_keyring WHERE user_id = new.user_id;
	END IF;
END ;;
DELIMITER ;


--
-- Table structure for table `tbb_areas`
--
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `u117932138_bdsazonmaxico`.`tbb_areas_BEFORE_INSERT` BEFORE INSERT ON `tbb_areas` FOR EACH ROW
BEGIN
	DECLARE tipo_area_valido INT;
    DECLARE nombre_valido INT;
    DECLARE estatus_valido INT;
    
    SET tipo_area_valido = 0;
    SET nombre_valido = 0;
    SET estatus_valido = 0;
    
    -- Valida el Tipo_Area_ID en el rango del 1 al 6
    IF NEW.Tipo_Area_ID >= 1 AND NEW.Tipo_Area_ID <= 6 THEN
        SET tipo_area_valido = 1;
    END IF;
    
    -- Valida el Nombre en el rango de "Mesa 1" a "Mesa 10"
    IF NEW.Nombre LIKE 'Mesa %' AND NEW.Nombre REGEXP 'Mesa [1-9]|Mesa 10' THEN
        SET nombre_valido = 1;
    END IF;
    
    -- Valida el Estatus igual a 1
    IF NEW.Estatus = 1 THEN
        SET estatus_valido = 1;
    END IF;
    
    -- Verifica las condiciones y lanza un error si no se cumplen
    IF NOT (tipo_area_valido = 1 AND nombre_valido = 1 AND estatus_valido = 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Datos de área inválidos';
    END IF;
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_areas_AFTER_INSERT` AFTER INSERT ON `tbb_areas` FOR EACH ROW BEGIN
		INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_areas", "CREATE",
		CONCAT_WS(" ","El usuario:", USER(), "ha insertado una nueva ÁREA con el ID:", new.id, 
         " TIPO de ÁREA ID:",new.Tipo_Area_ID," NOMBRE:",new.nombre, " con DESCRIPCIÓN:",new.descripcion,
         " ESTATUS:",  IF(new.estatus,'1','0')," y con FECHA DE REGISTRO:", new.fecha_registro, "."), DEFAULT,
		DEFAULT);

END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_areas_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_areas` FOR EACH ROW BEGIN
	SET NEW.Fecha_Ultima_Actualizacion = NOW();
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_areas_AFTER_UPDATE` AFTER UPDATE ON `tbb_areas` FOR EACH ROW BEGIN
		INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), 'tbb_areas', 'UPDATE',
        CONCAT_WS('',
            'El usuario: ', USER(), ' ha modificado el ÁREA con ID: ', NEW.id,
            ' con los siguientes cambios: ',
            IF(NEW.id = OLD.id, '', CONCAT_WS('', ' el ID de: ', OLD.id, ' a: ', NEW.id)),
            IF(NEW.Tipo_Area_ID = OLD.Tipo_Area_ID, '', CONCAT_WS('', ', el TIPO DE ÁREA ID de: ', OLD.Tipo_Area_ID, ' a: ', NEW.Tipo_Area_ID)),
            IF(NEW.nombre = OLD.nombre, '', CONCAT_WS('', ', el NOMBRE de: ', OLD.nombre, ' a: ', NEW.nombre)),
            IF(NEW.Descripcion IS NOT NULL AND OLD.Descripcion IS NOT NULL AND NEW.Descripcion != OLD.Descripcion, CONCAT_WS('', ', la DESCRIPCIÓN de: ', OLD.Descripcion, ' a: ', NEW.Descripcion), ''),
            IF(NEW.Estatus = OLD.Estatus, '', CONCAT_WS('', ', el ESTATUS de: ', IF(OLD.Estatus, '1', '0'), ' a:', IF(NEW.Estatus, '1', '0'))),
            IF(NEW.fecha_registro = OLD.fecha_registro, '', CONCAT_WS('', ' la FECHA_DE_REGISTRO de: ', OLD.fecha_registro, ' a: ', NEW.fecha_registro))
        ), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_areas_BEFORE_DELETE` BEFORE DELETE ON `tbb_areas` FOR EACH ROW BEGIN
	declare v_usuario varchar(80) default user();
    declare MESSAGGE_TEXT varchar(255) default "";
    
    if v_usuario != "u117932138_raul@%" then
		signal sqlstate '45000'
        set	MESSAGE_TEXT = 'No tienes los privilegios para borrar la infromacion de la tabla: tbb_areas';
    end if;  
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_areas_AFTER_DELETE` AFTER DELETE ON `tbb_areas` FOR EACH ROW BEGIN
		INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_areas", "DELETE",
		CONCAT_WS(" ","El usuario:", USER(), "ha eliminado a una ÁREA con el ID:", old.id, 
         " TIPO de ÁREA ID:",old.Tipo_Area_ID," NOMBRE:",old.nombre, " con DESCRIPCIÓN:",old.descripcion,
         " ESTATUS:",  IF(old.estatus,'1','0')," y con FECHA DE REGISTRO:", old.fecha_registro, "."), DEFAULT,
		DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################

--
-- Table structure for table `tbb_eventos`
--

DELIMITER ;;
CREATE  TRIGGER `u117932138_bdsazonmaxico`.`tbb_eventos_BEFORE_INSERT` BEFORE INSERT ON `tbb_eventos` FOR EACH ROW
BEGIN
	DECLARE tipo_area_valido INT;
     DECLARE estatus_valido INT;
    
    
  -- Valida el Tipo_Area_ID en el rango del 1 al 6
    IF NEW.Area_ID >= 1 AND NEW.Area_ID <= 6 THEN
        SET tipo_area_valido = 1;
    END IF;
    
      -- Valida el Estatus igual a 1
    IF NEW.Estatus = 1 THEN
        SET estatus_valido = 1;
    END IF;
    
     IF NOT (tipo_area_valido = 1  AND estatus_valido = 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Datos de área inválidos o evento no disponible';
    END IF;

END ;;
DELIMITER ;
-- ############################################################################################

DELIMITER ;;
CREATE  TRIGGER `tbb_eventos_AFTER_INSERT` AFTER INSERT ON `tbb_eventos` FOR EACH ROW BEGIN
		INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_eventos", "CREATE",
		CONCAT_WS(" ","El usuario:", USER(), "ha insertado un nuevo EVENTO con el ID:", new.id, 
       " con USUARIO ID:",new.Usuario_ID," con ÁREA ID:",new.Area_ID, " con HORARIO GENERAL ID:",new.Horario_General_ID,
       " con HORARIO ESPECÍFICO ID:",new.Horario_Especifico_ID,"NOMBRE:",new.nombre, " ESTATUS:",  IF(new.estatus,'1','0'),
        IFNULL(CONCAT("DESCRIPCIÓN:"," ",new.Descripcion), ""),
		" y con FECHA DE REGISTRO:", new.fecha_registro, "."), DEFAULT,
		DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_eventos_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_eventos` FOR EACH ROW BEGIN
SET NEW.Fecha_Ultima_Actualizacion = NOW();
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_eventos_AFTER_UPDATE` AFTER UPDATE ON `tbb_eventos` FOR EACH ROW BEGIN
		    INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), 'tbb_eventos', 'UPDATE',
        CONCAT_WS('',
            'El usuario: ', USER(), ' ha modificado el EVENTO con ID: ', NEW.id,
            ' con los siguientes cambios: ',
            IF(NEW.id = OLD.id, '', CONCAT_WS('', ' el ID de: ', OLD.id, ' a: ', NEW.id)),
            IF(NEW.Usuario_ID = OLD.Usuario_ID, '', CONCAT_WS('', ', el USUARIO ID de: ', OLD.Usuario_ID, ' a:', NEW.Usuario_ID)),
            IF(NEW.Area_ID = OLD.Area_ID, '', CONCAT_WS('', ', el ÁREA ID de: ', OLD.Area_ID, ' a: ', NEW.Area_ID)),
			IF(NEW.Horario_General_ID = OLD.Horario_General_ID, '', CONCAT_WS('', ', el HORARIO GENERAL ID de: ', OLD.Horario_General_ID, ' a: ', NEW.Horario_General_ID)),           
            IF(NEW.Horario_Especifico_ID = OLD.Horario_Especifico_ID, '', CONCAT_WS('', ', el HORARIO ESPECÍFICO ID de: ', OLD.Horario_Especifico_ID, ' a: ', NEW.Horario_Especifico_ID)),           
            IF(NEW.nombre = OLD.nombre, '', CONCAT_WS('', ', el NOMBRE de: ', OLD.nombre, ' a: ', NEW.nombre)),
			IF(NEW.Estatus = OLD.Estatus, '', CONCAT_WS('', ', el ESTATUS de: ', IF(OLD.Estatus, '1', '0'), ' a:', IF(NEW.Estatus, '1', '0'))),
            IF(NEW.Descripcion IS NOT NULL AND OLD.Descripcion IS NOT NULL AND NEW.Descripcion != OLD.Descripcion, CONCAT_WS('', ', la DESCRIPCIÓN de: ', OLD.Descripcion, ' a: ', NEW.Descripcion), ''),
            IF(NEW.fecha_registro = OLD.fecha_registro, '', CONCAT_WS('', ' la FECHA_DE_REGISTRO de: ', OLD.fecha_registro, ' a: ', NEW.fecha_registro))
        ), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_eventos_BEFORE_DELETE` BEFORE DELETE ON `tbb_eventos` FOR EACH ROW BEGIN
	declare v_usuario varchar(80) default user();
    declare MESSAGGE_TEXT varchar(255) default "";
    
    if v_usuario != "u117932138_raul@%" then
		signal sqlstate '45000'
        set	MESSAGE_TEXT = 'No tienes los privilegios para borrar la infromacion de la tabla: tbb_eventos';
    end if; 
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_eventos_AFTER_DELETE` AFTER DELETE ON `tbb_eventos` FOR EACH ROW BEGIN
		INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_eventos", "DELETE",
		CONCAT_WS(" ","El usuario:", USER(), "ha eliminado un EVENTO con el ID:", old.id, 
       " con USUARIO ID:",old.Usuario_ID," con ÁREA ID:",old.Area_ID, " con HORARIO GENERAL ID:",old.Horario_General_ID,
       " con HORARIO ESPECÍFICO ID:",old.Horario_Especifico_ID,"NOMBRE:",old.nombre, " ESTATUS:",  IF(old.estatus,'1','0'),
        IFNULL(CONCAT("DESCRIPCIÓN:"," ",old.Descripcion), ""),
		" y con FECHA DE REGISTRO:", old.fecha_registro, "."), DEFAULT,
		DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################


--
-- Table structure for table `tbb_horario_especifico`
--

DELIMITER ;;
CREATE  TRIGGER `tbb_horario_especifico_AFTER_INSERT` AFTER INSERT ON `tbb_horario_especifico` FOR EACH ROW BEGIN
 INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_horario_especifico", "CREATE",
    CONCAT_WS(" ","El usuario:", USER(), "ha insertado un nuevo HORARIO_ESPECIFICO con el ID:", new.ID,
    " con ESTATUS por defecto: ", IF(new.estatus,'1','0'),
    "DESCRIPCION:", IFNULL(new.Descripcion, ''),
    " FECHA INICIO:", new.Fecha_Inicio, "FECHA FIN:", new.Fecha_Fin, 
    " FECHA REGISTRO:", new.Fecha_Registro), DEFAULT,
    DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_horario_especifico_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_horario_especifico` FOR EACH ROW BEGIN
SET NEW.fecha_ultima_actualizacion = NOW();
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_horario_especifico_AFTER_UPDATE` AFTER UPDATE ON `tbb_horario_especifico` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), 'tbb_platillos', 'UPDATE',
        CONCAT_WS('',
            'El usuario: ', USER(), ' ha MODIFICADO el HORARIO ESPECIFICO con ID: ', NEW.ID,
            ' con los siguientes cambios: ',
            IF(NEW.ID = OLD.ID, '', CONCAT_WS('', ' el ID de: ', OLD.ID, ' a: ', NEW.ID)),
			IF(NEW.Estatus = OLD.Estatus, '', CONCAT_WS('', ', el ESTATUS de: ', IF(OLD.Estatus, '1', '0'), ' a:', IF(NEW.Estatus, '1', '0'))),
			IF(NEW.Descripcion IS NOT NULL AND OLD.Descripcion IS NOT NULL AND NEW.Descripcion != OLD.Descripcion, CONCAT_WS('', ', la DESCRIPCION de: ', OLD.Descripcion, ' a: ', NEW.Descripcion), ''),
            IF(NEW.Fecha_Inicio = OLD.Fecha_Inicio, '', CONCAT_WS('', ', la FECHA INICIO de: ', OLD.Fecha_Inicio, ' a:', NEW.Fecha_Inicio)),
            IF(NEW.Fecha_Fin = OLD.Fecha_Fin, '', CONCAT_WS('', ', la FECHA FIN de: ', OLD.Fecha_Fin, ' a:', NEW.Fecha_Fin)),
			IF(NEW.Fecha_Registro = OLD.Fecha_Registro, '', CONCAT_WS('', ', la FECHA REGISTRO de: ', OLD.Fecha_Registro, ' a:', NEW.Fecha_Registro))), DEFAULT, DEFAULT);

END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_horario_especifico_BEFORE_DELETE` BEFORE DELETE ON `tbb_horario_especifico` FOR EACH ROW BEGIN
declare v_usuario varchar(80) default user();
    declare MESSAGGE_TEXT varchar(255) default "";
    
    if v_usuario != "u117932138_raul@%" then
		signal sqlstate '45000'
        set	MESSAGE_TEXT = 'No tienes los privilegios para borrar la infromacion de la tabla: HORARIO_ESPECIFICO';
    end if;  
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_horario_especifico_AFTER_DELETE` AFTER DELETE ON `tbb_horario_especifico` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_horario_especifico", "DELETE",
    CONCAT_WS(" ","El usuario:", USER(), "ha ELIMINADO un HORARIO_ESPECIFICO con el ID:", old.ID,
    " con ESTATUS por defecto: ", IF(old.estatus,'1','0'),
    "DESCRIPCION:", IFNULL(old.Descripcion, ''),
    " FECHA INICIO:", old.Fecha_Inicio, "FECHA FIN:", old.Fecha_Fin, 
    " FECHA REGISTRO:", old.Fecha_Registro), DEFAULT,
    DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################

--
-- Table structure for table `tbb_horario_general`
--


DELIMITER ;;
CREATE  TRIGGER `u117932138_bdsazonmaxico`.`tbb_horario_general_BEFORE_INSERT` BEFORE INSERT ON `tbb_horario_general` FOR EACH ROW
BEGIN
IF NEW.Horario_Especifico_ID < 1 OR NEW.Horario_Especifico_ID > 7 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El Horario_Especifico_ID debe estar entre 1 y 7';
    END IF;

    IF NEW.Estatus < 0 OR NEW.Estatus > 1 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El Estatus debe ser 0 (inactivo) o 1 (activo)';
    END IF;
END ;;
DELIMITER ;

-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_horario_general_AFTER_INSERT` AFTER INSERT ON `tbb_horario_general` FOR EACH ROW BEGIN
				INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_horario_general", "CREATE",
		CONCAT_WS(" ","El usuario:", USER(), "ha insertado un nuevo HORARIO GENERAL con el ID:", new.id, 
        "con HORARIO ESPECÍFICO:",new.Horario_Especifico_ID," con ESTATUS:",  IF(new.estatus,'1','0'),
        " FECHA :",new.fecha, " y con FECHA DE REGISTRO:", new.fecha_registro, "."), DEFAULT,
		DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_horario_general_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_horario_general` FOR EACH ROW BEGIN
	SET NEW.fecha_ultima_actualizacion = NOW();
END ;;
DELIMITER ;
-- ############################################################################################

DELIMITER ;;
CREATE  TRIGGER `tbb_horario_general_AFTER_UPDATE` AFTER UPDATE ON `tbb_horario_general` FOR EACH ROW BEGIN
		    INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), 'tbb_horario_general', 'UPDATE',
        CONCAT_WS('',
            'El usuario: ', USER(), ' ha modificado el HORARIO GENERAL con ID: ', NEW.id,
            ' con los siguientes cambios: ',
            IF(NEW.id = OLD.id, '', CONCAT_WS('', ' el ID de: ', OLD.id, ' a: ', NEW.id)),
            IF(NEW.Horario_Especifico_ID = OLD.Horario_Especifico_ID , '', CONCAT_WS('', ', el HORARIO ESPECÍFICO ID  de: ', OLD.Horario_Especifico_ID , ' a: ', NEW.Horario_Especifico_ID )),
            IF(NEW.Estatus = OLD.Estatus, '', CONCAT_WS('', ', el ESTATUS de: ', IF(OLD.Estatus, '1', '0'), ' a:', IF(NEW.Estatus, '1', '0'))),
            IF(NEW.Fecha = OLD.Fecha, '', CONCAT_WS('', ', la Fecha de: ', OLD.Fecha, ' a: ', NEW.Fecha)),
            IF(NEW.fecha_registro = OLD.fecha_registro, '', CONCAT_WS('', ' la FECHA_DE_REGISTRO de: ', OLD.fecha_registro, ' a: ', NEW.fecha_registro))
        ), DEFAULT, DEFAULT);

END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_horario_general_BEFORE_DELETE` BEFORE DELETE ON `tbb_horario_general` FOR EACH ROW BEGIN
		declare v_usuario varchar(80) default user();
    declare MESSAGGE_TEXT varchar(255) default "";
    
    if v_usuario != "u117932138_raul@%" then
		signal sqlstate '45000'
        set	MESSAGE_TEXT = 'No tienes los privilegios para borrar la infromacion de la tabla: tbb_horario_general';
    end if;
END ;;
DELIMITER ;
-- ############################################################################################

DELIMITER ;;
CREATE  TRIGGER `tbb_horario_general_AFTER_DELETE` AFTER DELETE ON `tbb_horario_general` FOR EACH ROW BEGIN
		INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_horario_general", "DELETE",
		CONCAT_WS(" ","El usuario:", USER(), "ha eliminado un HORARIO GENERAL con el ID:", old.id, 
        "con HORARIO ESPECÍFICO:",old.Horario_Especifico_ID," con ESTATUS:",  IF(old.estatus,'1','0'),
        " FECHA :",old.fecha, " y con FECHA DE REGISTRO:", old.fecha_registro, "."), DEFAULT,
		DEFAULT);
END ;;
DELIMITER ;

-- ############################################################################################
--
-- Table structure for table `tbb_menu_del_dia`
--


DELIMITER ;;
CREATE  TRIGGER `u117932138_bdsazonmaxico`.`tbb_menu_del_dia_BEFORE_INSERT_1` BEFORE INSERT ON `tbb_menu_del_dia` FOR EACH ROW
BEGIN
	 DECLARE Platillo_ID INT;
     
        -- Valida el Platillo_ID en el rango del 1 al 34
    IF NEW.Platillo_ID >= 1 AND NEW.Platillo_ID <= 34 THEN
        SET Platillo_ID = 1;
    END IF;
    
        -- Verifica las condiciones y lanza un error si no se cumplen
    IF NOT (Platillo_ID= 1 ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El menú no existe';
    END IF;
END ;;
DELIMITER ;
-- ############################################################################################

--
-- Table structure for table `tbb_personas`
--
DELIMITER ;;
CREATE  TRIGGER `u117932138_bdsazonmaxico`.`tbb_personas_BEFORE_INSERT` BEFORE INSERT ON `tbb_personas` FOR EACH ROW
BEGIN
    IF NEW.Genero NOT IN ('M', 'F') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Género no válido.';
    END IF;
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_personas_AFTER_INSERT` AFTER INSERT ON `tbb_personas` FOR EACH ROW BEGIN
		INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_personas", "CREATE",
		CONCAT_WS(" ","El usuario:", USER(), "ha insertado una nueva PERSONA con el ID:", new.id, 
        "NOMBRE:",new.nombre, "PRIMER APELLIDO:",new.primer_apellido,
        "SEGUNDO APELLIDO:", new.segundo_apellido," GENERO:", new.genero, IFNULL(CONCAT("NÚMERO_TELEFÓNICO:"," ",new.numero_telefonico), ""),
        " FECHA DE NACIMIENTO:",new.fecha_nacimiento, 
		" y con FECHA DE REGISTRO:", new.fecha_registro, "."), DEFAULT,
		DEFAULT);

END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_personas_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_personas` FOR EACH ROW BEGIN
SET NEW.fecha_ultima_actualizacion = NOW();
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_personas_AFTER_UPDATE` AFTER UPDATE ON `tbb_personas` FOR EACH ROW BEGIN
		    INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), 'tbb_personas', 'UPDATE',
        CONCAT_WS('',
            'El usuario: ', USER(), ' ha modificado la PERSONA con ID: ', NEW.id,
            ' con los siguientes cambios: ',
            IF(NEW.id = OLD.id, '', CONCAT_WS('', ' el ID de: ', OLD.id, ' a: ', NEW.id)),
            IF(NEW.nombre = OLD.nombre, '', CONCAT_WS('', ', el NOMBRE de: ', OLD.nombre, ' a: ', NEW.nombre)),
            IF(NEW.Primer_Apellido = OLD.Primer_Apellido, '', CONCAT_WS('', ', el PRIMER APELLIDO de: ', OLD.Primer_Apellido, ' a:', NEW.Primer_Apellido)),
            IF(NEW.Segundo_Apellido IS NOT NULL AND OLD.Segundo_Apellido IS NOT NULL AND NEW.Segundo_Apellido != OLD.Segundo_Apellido, CONCAT_WS('', ', el SEGUNDO APELLIDO de: ', OLD.Segundo_Apellido, ' a: ', NEW.Segundo_Apellido), ''),
            IF(NEW.genero = OLD.genero, '', CONCAT_WS('', ', el GENERO de: ', OLD.genero, ' a: ', NEW.genero)),
			IF(NEW.Numero_Telefonico = OLD.Numero_Telefonico, '', CONCAT_WS('', ', el NÚMERO TELEFÓNICO de: ', OLD.Numero_Telefonico, ' a: ', NEW.Numero_Telefonico)),
            IF(NEW.Fecha_Nacimiento = OLD.Fecha_Nacimiento, '', CONCAT_WS('', ', la Fecha_Nacimiento de: ', OLD.Fecha_Nacimiento, ' a: ', NEW.Fecha_Nacimiento)),
            IF(NEW.fecha_registro = OLD.fecha_registro, '', CONCAT_WS('', ' la FECHA_DE_REGISTRO de: ', OLD.fecha_registro, ' a: ', NEW.fecha_registro))
        ), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_personas_BEFORE_DELETE` BEFORE DELETE ON `tbb_personas` FOR EACH ROW BEGIN
declare v_usuario varchar(80) default user();
    declare MESSAGGE_TEXT varchar(255) default "";
    
    if v_usuario != "u117932138_raul@%" then
		signal sqlstate '45000'
        set	MESSAGE_TEXT = 'No tienes los privilegios para borrar la infromacion de la tabla: tbb_personas';
    end if;  
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_personas_AFTER_DELETE` AFTER DELETE ON `tbb_personas` FOR EACH ROW BEGIN
 		INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_personas", "DELETE",
		CONCAT_WS(" ","El usuario:", USER(), "ha eliminado una PERSONA con el ID:", old.id, 
        "NOMBRE:",old.nombre, "PRIMER APELLIDO:",old.primer_apellido,
        "SEGUNDO APELLIDO:", old.segundo_apellido," GENERO:", old.genero, IFNULL(CONCAT("NÚMERO_TELEFÓNICO:"," ",old.numero_telefonico), ""),
        " FECHA DE NACIMIENTO:",old.fecha_nacimiento, 
		" y con FECHA DE REGISTRO:", old.fecha_registro, "."), DEFAULT,
		DEFAULT);
END ;;
DELIMITER ;

-- ############################################################################################
--
-- Table structure for table `tbb_platillos`
--

DELIMITER ;;
CREATE  TRIGGER `u117932138_bdsazonmaxico`.`valida_puntuacion` BEFORE INSERT ON `tbb_platillos` FOR EACH ROW
BEGIN
    IF NEW.puntuacion < 1 OR NEW.puntuacion > 5 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La puntuación debe estar entre 1 y 5';
    END IF;
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_platillos_AFTER_INSERT` AFTER INSERT ON `tbb_platillos` FOR EACH ROW BEGIN
    INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_platillos", "CREATE",
    CONCAT_WS(" ","El usuario:", USER(), "ha insertado un nuevo PLATILLO con el ID:", new.ID,
    "CATEGORIA ID:", new.Categoria_ID, "PUNTUACION :", new.Puntuacion, "NOMBRE:", new.Nombre,
    "PRECIO:", new.precio,  "ESTATUS:",  IF(new.estatus,'1','0'),
    "DESCRIPCION:", IFNULL(new.Descripcion, ''), 
    "FECHA REGISTRO:", new.Fecha_Registro), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_platillos_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_platillos` FOR EACH ROW BEGIN
SET NEW.fecha_ultima_actualizacion = NOW();
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_platillos_AFTER_UPDATE` AFTER UPDATE ON `tbb_platillos` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), 'tbb_platillos', 'UPDATE',
        CONCAT_WS('',
            'El usuario: ', USER(), ' ha modificado el PLATILLO con ID: ', NEW.ID,
            ' con los siguientes cambios: ',
            IF(NEW.ID = OLD.ID, '', CONCAT_WS('', ' el ID de: ', OLD.ID, ' a: ', NEW.ID)),
            IF(NEW.Categoria_ID = OLD.Categoria_ID, '', CONCAT_WS('', ', de la CATEGORIA ID de: ', OLD.Categoria_ID, ' a:', NEW.Categoria_ID)),
            IF(NEW.Puntuacion = OLD.Puntuacion, '', CONCAT_WS('', ', la PUNTUACION  de: ', OLD.Puntuacion, ' a:', NEW.Puntuacion)),
            IF(NEW.Nombre = OLD.Nombre, '', CONCAT_WS('', ', el NOMBRE de: ', OLD.Nombre, ' a:', NEW.Nombre)),
			IF(NEW.Precio = OLD.Precio, '', CONCAT_WS('', ', el PRECIO de: ', OLD.Precio, ' a:', NEW.Precio)), 
             IF(NEW.Estatus = OLD.Estatus, '', CONCAT_WS('', ', el ESTATUS de: ', IF(OLD.Estatus, '1', '0'), ' a:', IF(NEW.Estatus, '1', '0'))),
            IF(NEW.Descripcion IS NOT NULL AND OLD.Descripcion IS NOT NULL AND NEW.Descripcion != OLD.Descripcion, CONCAT_WS('', ', la DESCRIPCION de: ', OLD.Descripcion, ' a: ', NEW.Descripcion), ''),
			IF(NEW.Fecha_Registro = OLD.Fecha_Registro, '', CONCAT_WS('', ', la FECHA REGISTRO de: ', OLD.Fecha_Registro, ' a:', NEW.Fecha_Registro))), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_platillos_BEFORE_DELETE` BEFORE DELETE ON `tbb_platillos` FOR EACH ROW BEGIN
declare v_usuario varchar(80) default user();
    declare MESSAGGE_TEXT varchar(255) default "";
    
    if v_usuario != "u117932138_raul@%" then
		signal sqlstate '45000'
        set	MESSAGE_TEXT = 'No tienes los privilegios para borrar la informacion de la tabla: PLATILLOS';
    end if;  
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_platillos_AFTER_DELETE` AFTER DELETE ON `tbb_platillos` FOR EACH ROW BEGIN
    INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_platillos", "DELETE",
    CONCAT_WS(" ","El usuario:", USER(), "ha ELIMINADO un PLATILLO con el ID:", old.ID,
    "CATEGORIA ID:", old.Categoria_ID, "PUNTUACION :", old.Puntuacion, "NOMBRE:", old.Nombre,
    "PRECIO:", old.precio,  "ESTATUS:",  IF(old.estatus,'1','0'),
    "DESCRIPCION:", IFNULL(old.Descripcion, ''), 
    "FECHA REGISTRO:", old.Fecha_Registro), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################

--
-- Table structure for table `tbb_puntuacion`
--

DELIMITER ;;
CREATE  TRIGGER `u117932138_bdsazonmaxico`.`tbb_puntuacion_BEFORE_INSERT` BEFORE INSERT ON `tbb_puntuacion` FOR EACH ROW
BEGIN
 IF LENGTH(NEW.Comentario) = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El contenido del comentario no puede estar vacío.';
    END IF;
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_puntuacion_AFTER_INSERT` AFTER INSERT ON `tbb_puntuacion` FOR EACH ROW BEGIN
 INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_puntuacion", "CREATE",
    CONCAT_WS(" ","El usuario:", USER(), "ha INSERTADO una nueva PUNTUACION con el ID:", new.ID,
    "USUARIO ID:", new.Usuario_ID, "PLATILLO ID:", new.Platillo_ID, "CALIFICACION:", IFNULL(new.Calificacion, ''),
    "COMENTARIO:", IFNULL(new.Comentario, ''), 
    "FECHA REGISTRO:", new.Fecha_Registro), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_puntuacion_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_puntuacion` FOR EACH ROW BEGIN
SET NEW.fecha_ultima_actualizacion = NOW();
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_puntuacion_AFTER_UPDATE` AFTER UPDATE ON `tbb_puntuacion` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), 'tbb_puntuacion', 'UPDATE',
        CONCAT_WS('',
            'El usuario: ', USER(), ' ha modificado una PUNTUACION con ID: ', NEW.ID,
            ' con los siguientes cambios: ',
            IF(NEW.ID = OLD.ID, '', CONCAT_WS('', ' el ID de: ', OLD.ID, ' a: ', NEW.ID)),
            IF(NEW.Usuario_ID = OLD.Usuario_ID, '', CONCAT_WS('', ', del USUARIO ID de: ', OLD.Usuario_ID, ' a:', NEW.Usuario_ID)),
            IF(NEW.Platillo_ID = OLD.Platillo_ID, '', CONCAT_WS('', ', del PLATILLO ID de: ', OLD.Platillo_ID, ' a:', NEW.Platillo_ID)),
			IF(NEW.Calificacion IS NOT NULL AND OLD.Calificacion IS NOT NULL AND NEW.Calificacion != OLD.Calificacion, CONCAT_WS('', ', la CALIFICACION de: ', OLD.Calificacion, ' a: ', NEW.Calificacion), ''),
            IF(NEW.Comentario IS NOT NULL AND OLD.Comentario IS NOT NULL AND NEW.Comentario != OLD.Comentario, CONCAT_WS('', ', la COMENTARIO de: ', OLD.Comentario, ' a: ', NEW.Comentario), ''),
			IF(NEW.Fecha_Registro = OLD.Fecha_Registro, '', CONCAT_WS('', ', la FECHA REGISTRO de: ', OLD.Fecha_Registro, ' a:', NEW.Fecha_Registro))), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_puntuacion_BEFORE_DELETE` BEFORE DELETE ON `tbb_puntuacion` FOR EACH ROW BEGIN
declare v_usuario varchar(80) default user();
    declare MESSAGGE_TEXT varchar(255) default "";
    
    if v_usuario != "u117932138_raul@%" then
		signal sqlstate '45000'
        set	MESSAGE_TEXT = 'No tienes los privilegios para borrar la infromacion de la tabla: PUNTUACION';
    end if;  
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_puntuacion_AFTER_DELETE` AFTER DELETE ON `tbb_puntuacion` FOR EACH ROW BEGIN
 INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_puntuacion", "DELETE",
    CONCAT_WS(" ","El usuario:", USER(), "ha ELIMINADO una PUNTUACION con el ID:", old.ID,
    "USUARIO ID:", old.Usuario_ID, "PLATILLO ID:", old.Platillo_ID, "CALIFICACION:", IFNULL(old.Calificacion, ''),
    "COMENTARIO:", IFNULL(old.Comentario, ''), 
    "FECHA REGISTRO:", old.Fecha_Registro), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################

--
-- Table structure for table `tbb_reservas`
--

DELIMITER ;;
CREATE  TRIGGER `u117932138_bdsazonmaxico`.`tbb_reservas_BEFORE_INSERT` BEFORE INSERT ON `tbb_reservas` FOR EACH ROW
BEGIN
	
	DECLARE estatus_valido INT;
    DECLARE mesa_valida INT;
    
    SET estatus_valido = 0;
    SET mesa_valida = 0;
    
    -- Valida el Estatus (1 para disponible, 0 para ocupada)
    IF NEW.Estatus = 0 OR NEW.Estatus = 1 THEN
        SET estatus_valido = 1;
    END IF;
    
    -- Valida el Nombre de la Mesa en el rango de "Mesa 1" a "Mesa 10"
    IF NEW.Mesa_Asignada LIKE 'Mesa %' AND NEW.Mesa_Asignada REGEXP 'Mesa [1-9]|Mesa 10' THEN
        SET mesa_valida = 1;
    END IF;
    
    -- Verifica las condiciones y lanza un error si no se cumplen
    IF NOT (estatus_valido = 1 AND mesa_valida = 1) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Datos de reserva inválidos';
    END IF;
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_reservas_AFTER_INSERT` AFTER INSERT ON `tbb_reservas` FOR EACH ROW BEGIN
 INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_reservas", "CREATE",
    CONCAT_WS(" ","El usuario:", USER(), "ha INSERTADO una nueva RESERVA con el ID:", new.ID,
    "HORARIO ESPECIFICO ID:", new.Horario_Especifico_ID, "USUARIO ID:", new.Usuario_ID, 
    " MESA_ASIGNADA:", new.Mesa_Asignada, " CANTIDAD_PERSONAS:", new.Cantidad_Personas, 
    "ESTATUS:",  IF(new.estatus,'1','0'), "FECHA REGISTRO:", new.Fecha_Registro), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_reservas_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_reservas` FOR EACH ROW BEGIN
SET NEW.fecha_ultima_actualizacion = NOW();
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_reservas_AFTER_UPDATE` AFTER UPDATE ON `tbb_reservas` FOR EACH ROW BEGIN
INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), 'tbb_reservas', 'UPDATE',
        CONCAT_WS('','El usuario: ', USER(), ' ha modificado una RESERVA con ID: ', NEW.ID,
		' con los siguientes cambios: ',
            IF(NEW.ID = OLD.ID, '', CONCAT_WS('', ' el ID de: ', OLD.ID, ' a: ', NEW.ID)),
           IF(NEW.Horario_Especifico_ID = OLD.Horario_Especifico_ID, '', CONCAT_WS('', ', del HORARIO ESPECIFICO ID de: ', OLD.Horario_Especifico_ID, ' a:', NEW.Horario_Especifico_ID)),
           IF(NEW.Usuario_ID = OLD.Usuario_ID, '', CONCAT_WS('', ', del USUARIO ID de: ', OLD.Usuario_ID, ' a:', NEW.Usuario_ID)),
			IF(NEW.Mesa_Asignada = OLD.Mesa_Asignada, '', CONCAT_WS('', ', de la MESA ASIGNADA de: ', OLD.Mesa_Asignada, ' a:', NEW.Mesa_Asignada)),
			IF(NEW.Cantidad_Personas = OLD.Cantidad_Personas, '', CONCAT_WS('', ', de la CANTIDAD DE PERSONAS de: ', OLD.Cantidad_Personas, ' a:', NEW.Cantidad_Personas)),
              IF(NEW.Estatus = OLD.Estatus, '', CONCAT_WS('', ', el ESTATUS de: ', IF(OLD.Estatus, '1', '0'), ' a:', IF(NEW.Estatus, '1', '0'))),
			IF(NEW.Fecha_Registro = OLD.Fecha_Registro, '', CONCAT_WS('', ', la FECHA REGISTRO de: ', OLD.Fecha_Registro, ' a:', NEW.Fecha_Registro))), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_reservas_BEFORE_DELETE` BEFORE DELETE ON `tbb_reservas` FOR EACH ROW BEGIN
declare v_usuario varchar(80) default user();
    declare MESSAGGE_TEXT varchar(255) default "";
    
    if v_usuario != "u117932138_raul@%" then
		signal sqlstate '45000'
        set	MESSAGE_TEXT = 'No tienes los privilegios para borrar la informacion de la tabla: RESERVAS';
    end if;  
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_reservas_AFTER_DELETE` AFTER DELETE ON `tbb_reservas` FOR EACH ROW BEGIN
 INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_reservas", "DELETE",
    CONCAT_WS(" ","El usuario:", USER(), "ha ELIMINADO una RESERVA con el ID:", old.ID,
    "HORARIO ESPECIFICO ID:", old.Horario_Especifico_ID, "USUARIO ID:", old.Usuario_ID,
    " MESA_ASIGNADA:", old.Mesa_Asignada, " CANTIDAD_PERSONAS:", old.Cantidad_Personas,
    "ESTATUS:",  IF(OLD.estatus,'1','0'), "FECHA REGISTRO:", OLD.Fecha_Registro), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################

--
-- Table structure for table `tbb_ubicaciones`
--

DELIMITER ;;
CREATE  TRIGGER `u117932138_bdsazonmaxico`.`tbb_ubicaciones_BEFORE_INSERT` BEFORE INSERT ON `tbb_ubicaciones` FOR EACH ROW
BEGIN
	    IF NEW.Nombre IS NULL OR NEW.Nombre = '' OR NEW.Direccion IS NULL OR NEW.Direccion = '' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Falta información por llenar en Nombre y/o Dirección';
    END IF;
END ;;
DELIMITER ;

-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_ubicaciones_AFTER_INSERT` AFTER INSERT ON `tbb_ubicaciones` FOR EACH ROW BEGIN
	INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_ubicaciones", "CREATE",
		CONCAT_WS(" ","El usuario:", USER(), "ha insertado una UBICACIÓN con el ID:", new.id, 
         " con ESPACIO ID:",new.nombre," con DIRECCIÓN:",new.direccion,
         " con DESCRIPCIÓN:",new.descripcion,
         " y con FECHA DE REGISTRO:", new.fecha_registro, "."), DEFAULT,
		DEFAULT);

END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_ubicaciones_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_ubicaciones` FOR EACH ROW BEGIN
		SET NEW.Fecha_Ultima_Actualizacion = NOW();
END ;;
DELIMITER ;
-- ############################################################################################

DELIMITER ;;
CREATE  TRIGGER `tbb_ubicaciones_AFTER_UPDATE` AFTER UPDATE ON `tbb_ubicaciones` FOR EACH ROW BEGIN
		    INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), 'tbb_ubicaciones', 'UPDATE',
        CONCAT_WS('',
            'El usuario: ', USER(), ' ha modificado la UBICACIÓN con ID: ', NEW.id,
            ' con los siguientes cambios: ',
            IF(NEW.id = OLD.id, '', CONCAT_WS('', ' el ID de: ', OLD.id, ' a: ', NEW.id)),
            IF(NEW.nombre = OLD.nombre, '', CONCAT_WS('', ', el NOMBRE de: ', OLD.nombre, ' a: ', NEW.nombre)),
			IF(NEW.Direccion = OLD.Direccion, '', CONCAT_WS('', ', la DIRECCIÓN de: ', OLD.Direccion, ' a: ', NEW.Direccion)),
            IF(NEW.Descripcion IS NOT NULL AND OLD.Descripcion IS NOT NULL AND NEW.Descripcion != OLD.Descripcion, CONCAT_WS('', ', la DESCRIPCIÓN de: ', OLD.Descripcion, ' a: ', NEW.Descripcion), ''),
            IF(NEW.fecha_registro = OLD.fecha_registro, '', CONCAT_WS('', ' la FECHA_DE_REGISTRO de: ', OLD.fecha_registro, ' a: ', NEW.fecha_registro))
        ), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_ubicaciones_BEFORE_DELETE` BEFORE DELETE ON `tbb_ubicaciones` FOR EACH ROW BEGIN
	declare v_usuario varchar(80) default user();
    declare MESSAGGE_TEXT varchar(255) default "";
    
    if v_usuario != "u117932138_raul@%" then
		signal sqlstate '45000'
        set	MESSAGE_TEXT = 'No tienes los privilegios para borrar la infromacion de la tabla: tbb_ubicaciones';
    end if;  
END ;;
DELIMITER ;

-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_ubicaciones_AFTER_DELETE` AFTER DELETE ON `tbb_ubicaciones` FOR EACH ROW BEGIN
		INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_ubicaciones", "DELETE",
		CONCAT_WS(" ","El usuario:", USER(), "ha eliminado una UBICACIÓN con el ID:", old.id, 
         " con ESPACIO ID:"," NOMBRE:",old.nombre," con DIRECCIÓN:",old.direccion,
         " con DESCRIPCIÓN:",old.descripcion,
         " y con FECHA DE REGISTRO:", old.fecha_registro, "."), DEFAULT,
		DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################

--
-- Table structure for table `tbb_usuarios`
--

DELIMITER ;;
CREATE  TRIGGER `u117932138_bdsazonmaxico`.`tbb_usuarios_BEFORE_INSERT` BEFORE INSERT ON `tbb_usuarios` FOR EACH ROW
BEGIN
    IF NEW.Edad < 18 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El usuario debe tener al menos 18 años.';
    END IF;
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_usuarios_AFTER_INSERT` AFTER INSERT ON `tbb_usuarios` FOR EACH ROW BEGIN
    INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_usuarios", "CREATE",
    CONCAT_WS(" ","El usuario:", USER(), "ha insertado un nuevo USUARIO con el ID de PERSONA:", new.Persona_ID,
    "NOMBRE USUARIO:", new.Nombre_Usuario, "EMAIL:", new.Email, "PASSWORD:", new.Password,
    "TIPO:", new.Tipo," con ESTATUS por defecto: ", IF(new.estatus,'1','0'), "Edad", new.Edad, 
    "FECHA REGISTRO:", new.Fecha_Registro), DEFAULT,
    DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_usuarios_BEFORE_UPDATE` BEFORE UPDATE ON `tbb_usuarios` FOR EACH ROW BEGIN
SET NEW.fecha_ultima_actualizacion = NOW();
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_usuarios_AFTER_UPDATE` AFTER UPDATE ON `tbb_usuarios` FOR EACH ROW BEGIN
    INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), 'tbb_usuarios', 'UPDATE',
        CONCAT_WS('',
            'El usuario: ', USER(), ' ha modificado el USUARIO con ID de PERSONA: ', NEW.Persona_ID,
            ' con los siguientes cambios: ',
            IF(NEW.Persona_ID = OLD.Persona_ID, '', CONCAT_WS('', ' el ID de PERSONA de: ', OLD.Persona_ID, ' a: ', NEW.Persona_ID)),
            IF(NEW.Nombre_Usuario IS NOT NULL AND OLD.Nombre_Usuario IS NOT NULL AND NEW.Nombre_Usuario != OLD.Nombre_Usuario, CONCAT_WS('', ', el NOMBRE USUARIO de: ', OLD.Nombre_Usuario, ' a:', NEW.Nombre_Usuario), ''),
            IF(NEW.Email = OLD.Email, '', CONCAT_WS('', ', el EMAIL de: ', OLD.Email, ' a:', NEW.Email)),
            IF(NEW.Password = OLD.Password, '', CONCAT_WS('', ', el PASSWORD de: ', OLD.Password, ' a:', NEW.Password)),
            IF(NEW.Tipo = OLD.Tipo, '', CONCAT_WS('', ', el TIPO de: ', IF(OLD.Tipo IN ('Administrador', 'Cliente'), OLD.Tipo, 'Desconocido'), ' a:', IF(NEW.Tipo IN ('Admistrador', 'Cliente'), NEW.Tipo, 'Desconocido'))),
			IF(NEW.Edad = OLD.Edad, '', CONCAT_WS('', ' de EDAD: ', OLD.Edad, ' a: ', NEW.Edad)),
            IF(NEW.Estatus = OLD.Estatus, '', CONCAT_WS('', ', el ESTATUS de: ', IF(OLD.Estatus IN ('Activo', 'Inactivo'), OLD.Estatus, 'Desconocido'), ' a:', IF(NEW.Estatus IN ('Activo', 'Inactivo'), NEW.Estatus, 'Desconocido'))) ,
            IF(NEW.Fecha_Registro = OLD.Fecha_Registro, '', CONCAT_WS('', ', la FECHA REGISTRO de: ', OLD.Fecha_Registro, ' a:', NEW.Fecha_Registro))
        ), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_usuarios_BEFORE_DELETE` BEFORE DELETE ON `tbb_usuarios` FOR EACH ROW BEGIN
	declare v_usuario varchar(80) default user();
    declare MESSAGGE_TEXT varchar(255) default "";
    
    if v_usuario != "u117932138_raul@%" then
		signal sqlstate '45000'
        set	MESSAGE_TEXT = 'No tienes los privilegios para borrar la infromacion de la tabla: USUARIOS';
    end if; 
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbb_usuarios_AFTER_DELETE` AFTER DELETE ON `tbb_usuarios` FOR EACH ROW BEGIN
 INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbb_usuarios", "DELETE",
    CONCAT_WS(" ","El usuario:", USER(), "ha ELIMINADO un USUARIO con el ID de PERSONA:", old.Persona_ID,
    "NOMBRE USUARIO:", old.Nombre_Usuario, "EMAIL:", old.Email, "PASSWORD:", old.Password,
    "TIPO:", old.Tipo," con ESTATUS por defecto: ", IF(old.estatus,'1','0'), "Edad", old.Edad, 
    "FECHA REGISTRO:", old.Fecha_Registro), DEFAULT,
    DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################

--
-- Table structure for table `tbc_tipo_area`
--
DELIMITER ;;
CREATE  TRIGGER `tbc_tipo_area_AFTER_INSERT` AFTER INSERT ON `tbc_tipo_area` FOR EACH ROW BEGIN
		INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbc_tipo_area", "CREATE",
		CONCAT_WS(" ","El usuario:", USER(), "ha insertado un Tipo de Area con el ID:", new.id, 
         " NOMBRE:",new.nombre, " con DESCRIPCIÓN:",new.descripcion,
        " y con FECHA DE REGISTRO:", new.fecha_registro, "."), DEFAULT,
		DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbc_tipo_area_BEFORE_UPDATE` BEFORE UPDATE ON `tbc_tipo_area` FOR EACH ROW BEGIN
	SET NEW.Fecha_Ultima_Actualizacion = NOW();
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbc_tipo_area_AFTER_UPDATE` AFTER UPDATE ON `tbc_tipo_area` FOR EACH ROW BEGIN
		INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), 'tbc_tipo_area', 'UPDATE',
        CONCAT_WS('',
            'El usuario: ', USER(), ' ha modificado el TIPO DE ÁREA con ID: ', NEW.id,
            ' con los siguientes cambios: ',
            IF(NEW.id = OLD.id, '', CONCAT_WS('', ' el ID de: ', OLD.id, ' a: ', NEW.id)),
            IF(NEW.nombre = OLD.nombre, '', CONCAT_WS('', ', el NOMBRE de: ', OLD.nombre, ' a: ', NEW.nombre)),
            IF(NEW.Descripcion IS NOT NULL AND OLD.Descripcion IS NOT NULL AND NEW.Descripcion != OLD.Descripcion, CONCAT_WS('', ', la DESCRIPCIÓN de: ', OLD.Descripcion, ' a: ', NEW.Descripcion), ''),
            IF(NEW.fecha_registro = OLD.fecha_registro, '', CONCAT_WS('', ' la FECHA_DE_REGISTRO de: ', OLD.fecha_registro, ' a: ', NEW.fecha_registro))
        ), DEFAULT, DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbc_tipo_area_BEFORE_DELETE` BEFORE DELETE ON `tbc_tipo_area` FOR EACH ROW BEGIN
	declare v_usuario varchar(80) default user();
    declare MESSAGGE_TEXT varchar(255) default "";
    
    if v_usuario != "u117932138_raul@%" then
		signal sqlstate '45000'
        set	MESSAGE_TEXT = 'No tienes los privilegios para borrar la infromacion de la tabla: tbc_tipo_area';
    end if;  
END ;;
DELIMITER ;
-- ############################################################################################
DELIMITER ;;
CREATE  TRIGGER `tbc_tipo_area_AFTER_DELETE` AFTER DELETE ON `tbc_tipo_area` FOR EACH ROW BEGIN
		INSERT INTO tbi_bitacora VALUES (DEFAULT, USER(), "tbc_tipo_area", "DELETE",
		CONCAT_WS(" ","El usuario:", USER(), "ha eliminado un Tipo de Area con el ID:", old.id, 
         " NOMBRE:",old.nombre, " con DESCRIPCIÓN:",old.descripcion,
        " y con FECHA DE REGISTRO:", old.fecha_registro, "."), DEFAULT,
		DEFAULT);
END ;;
DELIMITER ;
-- ############################################################################################