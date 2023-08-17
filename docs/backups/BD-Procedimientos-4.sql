CREATE DATABASE  IF NOT EXISTS `u117932138_bdsazonmaxico`;
USE `u117932138_bdsazonmaxico`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 154.56.47.52    Database: u117932138_bdsazonmaxico
-- ------------------------------------------------------
-- Server version	5.5.5-10.6.14-MariaDB-cll-lve


/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Actualizar_Menu_Del_Dia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
-- #################################################################
CREATE DEFINER=`u117932138_raul`@`%` PROCEDURE `sp_Actualizar_Menu_Del_Dia`()
BEGIN
    DECLARE platilloId INT;
    DECLARE precioEspecial DECIMAL(10, 2);
    DECLARE platilloPrecio DECIMAL(10, 2);
    
    -- Escoge el ID del platillo que deseas actualizar (de acuerdo a la tabla tbb_platillos)
    SET platilloId = 123; -- ID del platillo que deseas actualizar
    
    -- Obtener el precio actual del platillo seleccionado
    SELECT Precio INTO platilloPrecio FROM tbb_platillos WHERE ID = platilloId;
    
    -- Usar el precio del platillo seleccionado como precio especial
    SET precioEspecial = platilloPrecio;
    
    -- Actualizar el menú del día con el nuevo platillo, la fecha actual y precio especial
    INSERT INTO tbb_menu_del_dia (Fecha, Platillo_ID, Precio)
    VALUES (CURDATE(), platilloId, precioEspecial)
    ON DUPLICATE KEY UPDATE Precio = precioEspecial;
    
    SELECT 'Menú actualizado correctamente' AS mensaje;

END ;;
-- #################################################################
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Agregar_Usuarios_Aleatorios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
-- #################################################################
CREATE DEFINER=`u117932138_raul`@`%` PROCEDURE `sp_Agregar_Usuarios_Aleatorios`(
    IN cantidad INT
)
BEGIN
    DECLARE contador INT DEFAULT 0;
	DECLARE personaAleatoria INT;
    
    WHILE contador < cantidad DO
        -- Generar un número aleatorio para seleccionar una persona

        SET personaAleatoria = FLOOR(RAND() * (SELECT COUNT(*) FROM tbb_personas)) + 1;

        -- Insertar un usuario aleatorio utilizando el procedimiento sp_Insertar_Usuario_Aleatorio
        CALL sp_Insertar_Usuario_Aleatorio(personaAleatoria);

        SET contador = contador + 1;
    END WHILE;

    SELECT CONCAT(cantidad, ' usuarios aleatorios insertados exitosamente.') AS mensaje;
END ;;
-- #################################################################
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Confirmar_Reserva_EnviarCorreo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
-- #################################################################
CREATE DEFINER=`u117932138_raul`@`%` PROCEDURE `sp_Confirmar_Reserva_EnviarCorreo`(
    IN reservaId INT
)
BEGIN
    DECLARE reservaEstado BIT(1);
    DECLARE clienteEmail VARCHAR(255);
        -- Obtener detalles de la reserva (puedes ajustar esta parte según tu estructura de datos)
        DECLARE reservaFecha DATE;
        DECLARE reservaHorario TIME;        
        
        -- Preparar el correo electrónico
        DECLARE emailSubject VARCHAR(255);
        DECLARE emailBody TEXT;
        -- Obtener otros detalles necesarios        
        
        DECLARE sendResult VARCHAR(50);
        SET sendResult = SEND_MAIL(clienteEmail, emailSubject, emailBody);
        
        SELECT Fecha, Hora INTO reservaFecha, reservaHorario FROM tbb_reservas WHERE ID = reservaId;
            
    -- Verificar si la reserva existe y está pendiente
    SELECT Estatus, Usuario_ID INTO reservaEstado, clienteEmail FROM tbb_reservas WHERE ID = reservaId;
    
    IF reservaEstado = 1 THEN
        -- Actualizar el estado de la reserva a confirmado (Estatus = 1)
        UPDATE tbb_reservas SET Estatus = 1 WHERE ID = reservaId;
        
        SET emailSubject = 'Confirmación de Reserva';
        SET emailBody = CONCAT('Su reserva para el ', reservaFecha, ' a las ', reservaHorario, ' ha sido confirmada. ¡Esperamos verte pronto!');
        -- Llamada a la función SEND_MAIL (simulada en este ejemplo)
        SELECT 'Reserva confirmada y correo electrónico enviado exitosamente' AS mensaje;
    ELSE
        SELECT 'No se puede confirmar una reserva que no esté pendiente' AS mensaje;
    END IF;
END ;;
-- #################################################################
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_estatus_bd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
-- #################################################################
CREATE DEFINER=`u117932138_raul`@`%` PROCEDURE `sp_estatus_bd`()
BEGIN
	(SELECT "tbb_areas" as Tabla,	 COUNT(*) as Total_Registros FROM tbb_areas)
	UNION
    (SELECT "tbc_categorias_platillos" as Tabla, COUNT(*) as Total_Registros FROM tbc_categorias_platillos)
	UNION
	(SELECT "tbb_espacios" as Tabla, COUNT(*) as Total_Registros FROM tbb_espacios)
     UNION
	(SELECT "tbb_eventos" as Tabla,  COUNT(*) as Total_Registros FROM tbb_eventos)
     UNION
	(SELECT "tbb_horario_especifico" as Tabla,	 COUNT(*) as Total_Registros FROM tbb_horario_especifico)
     UNION
	(SELECT "tbb_horario_general" as Tabla,	 COUNT(*) as Total_Registros FROM tbb_horario_general)
     UNION
	(SELECT "tbb_personas" as Tabla, COUNT(*) as Total_Registros FROM tbb_personas)
     UNION
	(SELECT "tbb_platillo" as Tabla, COUNT(*) as Total_Registros FROM tbb_platillos)
     UNION
	(SELECT "tbb_puntuación" as Tabla, COUNT(*) as Total_Registros FROM tbb_puntuacion)
	UNION
    (SELECT "tbb_reservas" as Tabla, COUNT(*) as Total_Registros FROM tbb_reservas)
	UNION
    (SELECT "tbb_ubicaciones" as Tabla, COUNT(*) as Total_Registros FROM tbb_ubicaciones)
	UNION
	(SELECT "tbb_usuarios" as Tabla, COUNT(*) as Total_Registros FROM tbb_usuarios)
	UNION
    (SELECT "tbc_tipo_area" as Tabla, COUNT(*) as Total_Registros FROM tbc_tipo_area);
	-- UNION
	-- (SELECT "tbi_bitacora" as Tabla, COUNT(*) as Total_Registros FROM tbi_bitacora);
END ;;
-- #################################################################
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_insertar_personas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
-- #################################################################
CREATE DEFINER=`u117932138_raul`@`%` PROCEDURE `sp_insertar_personas`(IN cantidad INT )
BEGIN
    DECLARE contador INT DEFAULT 0;
    DECLARE nombre_persona VARCHAR(50);
    DECLARE primer_apellido VARCHAR(50);
    DECLARE segundo_apellido VARCHAR(50);
    DECLARE genero ENUM('M', 'F');
    DECLARE numero_telefono VARCHAR(15);
    DECLARE fecha_nacimiento DATE;
	DECLARE fecha_inicio DATE;
    DECLARE fecha_fin DATE;

    SET fecha_inicio = DATE_SUB(CURRENT_DATE(), INTERVAL 40 YEAR);
    SET fecha_fin= DATE_SUB(CURRENT_DATE(), INTERVAL 18 YEAR);  

    WHILE contador < cantidad DO
		SET genero = IF(RAND() > 0.5, 'M', 'F');
        SET nombre_persona = fn_genera_nombre(genero);
        SET primer_apellido = fn_genera_apellido();
        SET segundo_apellido = fn_genera_apellido();
        SET genero = IF(RAND() > 0.5, 'M', 'F');
        SET numero_telefono = fn_generar_numero_telefonico();
       SET fecha_nacimiento = DATE_ADD(fecha_inicio, INTERVAL FLOOR(RAND() * DATEDIFF(fecha_fin, fecha_inicio)) DAY);

        INSERT INTO tbb_personas (ID,Nombre, Primer_Apellido, Segundo_Apellido, Genero, Numero_Telefonico, Fecha_nacimiento,Fecha_Registro,Fecha_Ultima_Actualizacion)
        VALUES (default,nombre_persona, primer_apellido, segundo_apellido, genero, numero_telefono, fecha_nacimiento,default,default);

        SET contador = contador + 1;
    END WHILE;
END ;;
-- #################################################################
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Insertar_Puntuacion_Comentario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
-- #################################################################
CREATE DEFINER=`u117932138_raul`@`%` PROCEDURE `sp_Insertar_Puntuacion_Comentario`(
    IN p_NombreUsuario VARCHAR(255),
    IN p_PlatilloID INT,
    IN p_Calificacion INT,
    IN p_Comentario TEXT
)
BEGIN
    DECLARE v_UsuarioID INT;
    DECLARE v_PuntuacionID INT;

    -- Validar que la calificación esté dentro del rango [0, 5]
    IF p_Calificacion < 0 THEN
        SET p_Calificacion = 0;
    ELSEIF p_Calificacion > 5 THEN
        SET p_Calificacion = 5;
    END IF;

    -- Obtener el ID del usuario basado en el nombre de usuario
    SELECT Persona_ID INTO v_UsuarioID
    FROM tbb_usuarios
    WHERE Nombre_Usuario = p_NombreUsuario;

    -- Verificar si ya existe una puntuación para este usuario y platillo
    SELECT ID INTO v_PuntuacionID
    FROM tbb_puntuacion
    WHERE Usuario_ID = v_UsuarioID AND Platillo_ID = p_PlatilloID;

    IF v_PuntuacionID IS NULL THEN
        -- Si no existe una puntuación, insertar una nueva
        INSERT INTO tbb_puntuacion (Usuario_ID, Platillo_ID, Calificacion, Comentario)
        VALUES (v_UsuarioID, p_PlatilloID, p_Calificacion, p_Comentario);
    ELSE
        -- Si ya existe una puntuación, actualizar los valores
        UPDATE tbb_puntuacion
        SET Calificacion = p_Calificacion, Comentario = p_Comentario
        WHERE ID = v_PuntuacionID;
    END IF;

    -- Manejo de errores
    IF FOUND_ROWS() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se pudo insertar/actualizar la puntuación.';
    END IF;

END ;;
-- #################################################################
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_Insertar_Usuario_Aleatorio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
-- #################################################################
CREATE DEFINER=`u117932138_raul`@`%` PROCEDURE `sp_Insertar_Usuario_Aleatorio`(vid int)
BEGIN
    DECLARE vnombre VARCHAR(50) DEFAULT '-';
    DECLARE vapellido VARCHAR(50) DEFAULT '-';
    DECLARE tipoUsuario ENUM('Cliente') DEFAULT 'Cliente';
    DECLARE contrasena VARCHAR(50);
    DECLARE edadUsuario INT;
    -- Generar el correo electrónico utilizando la función fn_genera_email
    DECLARE correoElectronico VARCHAR(60);
    SET vnombre = (SELECT nombre FROM tbb_personas WHERE id = vid);
    SET vapellido = (SELECT primer_apellido FROM tbb_personas WHERE id = vid);
    SET correoElectronico = fn_genera_email(vnombre, vapellido);
    SET contrasena = fn_password_aleatorio(5, 10);

    -- Calcular la edad utilizando la función fn_calcula_edad

    SET edadUsuario = fn_calcula_edad((SELECT fecha_nacimiento FROM tbb_personas WHERE id = vid));

    -- Insertar el nuevo usuario en la tabla tbb_usuarios
    INSERT INTO tbb_usuarios (Nombre_Usuario, Email, Password, Tipo, Edad, Estatus)
    VALUES (fn_genera_nombre_usuario(vnombre, vapellido), correoElectronico, contrasena, tipoUsuario, edadUsuario, 'Activo');
    
    SELECT CONCAT('Usuario insertado: ', vnombre, ' ', vapellido) AS mensaje;
END ;;
-- #################################################################
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_inserta_usuarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
-- #################################################################
CREATE DEFINER=`u117932138_raul`@`%` PROCEDURE `sp_inserta_usuarios`(v_cuantos INT)
BEGIN
   DECLARE i INT DEFAULT 1;
   WHILE i <= v_cuantos DO 
     /*SELECT CONCAT("Insertando al Contenido: ",i) as Mensaje;*/
   		CALL sp_Insertar_Usuario_Aleatorio();
	 SET i=i+1;
   END WHILE;
END ;;
-- #################################################################
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_limpia_bd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
-- #################################################################
CREATE DEFINER=`u117932138_raul`@`%` PROCEDURE `sp_limpia_bd`(v_passwd VARCHAR(50))
BEGIN
	-- Verificar Contraseña
    IF v_passwd != 'bd_S4z0nM4X|C0' THEN
		signal sqlstate '45000'
        set	MESSAGE_TEXT = 'Ha ingresado una CONTRASEÑA incorrecta.';
    ELSE
		-- UBICACIONES
		SELECT "Eliminando los datos en la tabla UBICACIONES" as Mensaje;
		DELETE FROM tbb_ubicaciones;
		SELECT "Seteando el ID AUTO_INCREMENT de UBICACIONES en 1" as Mensaje;
		ALTER TABLE tbb_ubicaciones AUTO_INCREMENT = 1;
    
		-- ESPACIOS
		SELECT "Eliminando los datos en la tabla ESPACIOS" as Mensaje;
		DELETE FROM tbb_espacios;
		SELECT "Seteando el ID AUTO_INCREMENT de ESPACIOS en 1" as Mensaje;
		ALTER TABLE tbb_espacios AUTO_INCREMENT = 1;
		
		-- AREAS
		SELECT "Eliminando los datos en la tabla AREAS" as Mensaje;
		DELETE FROM tbb_areas;
		SELECT "Seteando el ID AUTO_INCREMENT de AREAS en 1" as Mensaje;
		ALTER TABLE tbb_areas AUTO_INCREMENT = 1;
        
        -- EVENTOS
		SELECT "Eliminando los datos en la tabla EVENTOS" as Mensaje;
		DELETE FROM tbb_eventos;
		SELECT "Seteando el ID AUTO_INCREMENT de EVENTOS en 1" as Mensaje;
		ALTER TABLE tbb_eventos AUTO_INCREMENT = 1;
        
        -- RESERVAS
		SELECT "Eliminando los datos en la tabla RESERVAS" as Mensaje;
		DELETE FROM tbb_reservas;
		SELECT "Seteando el ID AUTO_INCREMENT de RESERVAS en 1" as Mensaje;
		ALTER TABLE tbb_reservas AUTO_INCREMENT = 1;
        
		-- HORARIO GENERAL
		SELECT "Eliminando los datos en la tabla HORARIO GENERAL" as Mensaje;
		DELETE FROM tbb_horario_general;
		SELECT "Seteando el ID AUTO_INCREMENT de HORARIO GENERAL en 1" as Mensaje;
		ALTER TABLE tbb_horario_general AUTO_INCREMENT = 1;
        
        -- HORARIO ESPECIFICO
		SELECT "Eliminando los datos en la tabla HORARIO ESPECIFICO" as Mensaje;
		DELETE FROM tbb_horario_especifico;
		SELECT "Seteando el ID AUTO_INCREMENT de HORARIO ESPECIFICO en 1" as Mensaje;
		ALTER TABLE tbb_horario_especifico AUTO_INCREMENT = 1;
		
		-- PLATILLOS
		SELECT "Eliminando los datos en la tabla PLATILLOS" as Mensaje;
		DELETE FROM tbb_platillos;
		SELECT "Seteando el ID AUTO_INCREMENT de PLATILLOS en 1" as Mensaje;
		ALTER TABLE tbb_platillos AUTO_INCREMENT = 1;
        
        -- PUNTUACION
		SELECT "Eliminando los datos en la tabla PUNTUACION" as Mensaje;
		DELETE FROM tbb_puntuacion;
		SELECT "Seteando el ID AUTO_INCREMENT de PUNTUACION en 1" as Mensaje;
		ALTER TABLE tbb_puntuacion AUTO_INCREMENT = 1;
		
		-- USUARIOS
		SELECT "Eliminando los datos en la tabla USUARIOS" as Mensaje;
		DELETE FROM tbb_usuarios;
		SELECT "Seteando el ID AUTO_INCREMENT de USUARIOS en 1" as Mensaje;
		ALTER TABLE tbb_usuarios AUTO_INCREMENT = 1;
		
		-- PERSONAS
		SELECT "Eliminando los datos de la tabla Personas" as Mensaje;
		DELETE FROM tbb_personas;
		SELECT "Seteando el ID AUTO_INCREMENT de Personas en 1" as Mensaje;
		ALTER TABLE tbb_personas AUTO_INCREMENT = 1;
		
		-- BITACORA
		SELECT "Eliminando los datos de la tabla BITACORA" as Mensaje;
		DELETE FROM tbi_bitacora;
		SELECT "Seteando el ID AUTO_INCREMENT de BITACORA en 1" as Mensaje;
		ALTER TABLE tbi_bitacora AUTO_INCREMENT = 1;
        
        SELECT "Base de Datos Limpiada Correctamente." as Mensaje_Finalizacion;
	END IF;
    
    
END ;;
-- #################################################################
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ReservarMesa` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
-- #################################################################
CREATE DEFINER=`u117932138_raul`@`%` PROCEDURE `sp_ReservarMesa`(
    IN reservaId INT
)
BEGIN
    DECLARE mesaId INT;
    DECLARE disponibleAntes BIT;
    
    -- Obtener la mesa asignada a la reserva
    SELECT Mesa_Asignada INTO mesaId FROM tbb_reservas WHERE ID = reservaId;
    
    -- Verificar si la mesa está disponible antes de la reserva
    SELECT Disponible INTO disponibleAntes FROM tbb_mesas WHERE ID = mesaId;
    
    IF disponibleAntes = 1 THEN
        -- Marcar la mesa como no disponible
        UPDATE tbb_mesas SET Disponible = 0 WHERE ID = mesaId;
        -- Marcar la reserva como confirmada (cambiar Estatus a 0)
        UPDATE tbb_reservas SET Estatus = 0 WHERE ID = reservaId;
        SELECT 'Mesa reservada exitosamente.' AS mensaje;
    ELSE
        SELECT 'La mesa ya está ocupada.' AS mensaje;
    END IF;
    
END ;;
-- #################################################################
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-17  2:33:10
