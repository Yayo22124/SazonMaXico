CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_estatus_bd`()
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
END
