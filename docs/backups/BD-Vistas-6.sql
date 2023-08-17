-- ############################################################################################
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `u117932138_raul`@`%` 
    SQL SECURITY DEFINER
VIEW `vw_eventos_programados` AS
    SELECT 
        `e`.`ID` AS `Evento_ID`,
        `e`.`Nombre` AS `Evento`,
        `e`.`Descripcion` AS `Descripcion_Evento`,
        `e`.`Tipo` AS `Tipo_Evento`,
        `r`.`Mesa_Asignada` AS `Mesa_Asignada`,
        `r`.`Cantidad_Personas` AS `Cantidad_Personas_Reserva`,
        `he`.`Fecha_Inicio` AS `Fecha`,
        CONCAT(`u`.`Nombre_Usuario`,
                ' (',
                `u`.`Email`,
                ')') AS `Usuario_Reserva`
    FROM
        (((`tbb_eventos` `e`
        JOIN `tbb_reservas` `r` ON (`e`.`Horario_Especifico_ID` = `r`.`Horario_Especifico_ID`))
        JOIN `tbb_usuarios` `u` ON (`r`.`Usuario_ID` = `u`.`Persona_ID`))
        JOIN `tbb_horario_especifico` `he` ON (`r`.`Horario_Especifico_ID` = `he`.`ID`))
    WHERE
        `e`.`Estatus` = '1'
            AND `r`.`Estatus` = '1'
            AND `he`.`Fecha_Inicio` <= CURDATE()
    ORDER BY `he`.`Fecha_Inicio`;
    
-- ############################################################################################
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `u117932138_raul`@`%` 
    SQL SECURITY DEFINER
VIEW `vw_historial_clientes_frecuentes` AS
    SELECT 
        `u`.`Persona_ID` AS `Cliente_ID`,
        `u`.`Nombre_Usuario` AS `Nombre_Cliente`,
        `u`.`Email` AS `Email_Cliente`,
        COUNT(`r`.`ID`) AS `Total_Reservas`
    FROM
        (`tbb_usuarios` `u`
        JOIN `tbb_reservas` `r` ON (`u`.`Persona_ID` = `r`.`Usuario_ID`))
    WHERE
        `u`.`Estatus` = 'Activo'
    GROUP BY `u`.`Persona_ID` , `u`.`Nombre_Usuario` , `u`.`Email`
    ORDER BY COUNT(`r`.`ID`) DESC;
    -- ############################################################################################
    
    CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `u117932138_raul`@`%` 
    SQL SECURITY DEFINER
VIEW `vw_menu_del_dia` AS
    SELECT 
        `p`.`ID` AS `Menu_ID`,
        `p`.`Platillo_ID` AS `Platillo_ID`,
        `r`.`Nombre` AS `Categoria`,
        `r`.`Nombre` AS `Nombre_Platillo`,
        `r`.`Descripcion` AS `Descripcion`,
        `r`.`Precio` AS `Precio_Platillo`,
        `r`.`Estatus` AS `Estatus`,
        `r`.`Fecha_Registro` AS `Fecha_Registro`
    FROM
        ((((((`tbb_menu_del_dia` `p`
        JOIN `tbb_platillos` `r` ON (`r`.`Nombre` = `r`.`Nombre`))
        JOIN `tbb_platillos` `c` ON (`r`.`Descripcion` = `r`.`Descripcion`))
        JOIN `tbb_platillos` `g` ON (`r`.`Precio` = `r`.`Precio`))
        JOIN `tbc_categorias_platillos` `m` ON (`r`.`Nombre` = `r`.`Nombre`))
        JOIN `tbb_platillos` `b` ON (`r`.`Estatus` = `r`.`Estatus`))
        JOIN `tbb_platillos` `d` ON (`r`.`Fecha_Registro` = `r`.`Fecha_Registro`))
    WHERE
        `r`.`Estatus` = '1';
        
-- ############################################################################################

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `u117932138_raul`@`%` 
    SQL SECURITY DEFINER
VIEW `vw_promociones_ofertas` AS
    SELECT 
        `p`.`Menu_ID` AS `Menu_ID`,
        `p`.`Platillo_ID` AS `Platillo_ID`,
        `r`.`Nombre` AS `Nombre_Platillo`,
        `r`.`Descripcion` AS `Descripcion`,
        `r`.`Estatus` AS `Estatus`
    FROM
        (((`tbb_menu_del_dia` `p`
        JOIN `tbb_platillos` `r` ON (`r`.`Nombre` = `r`.`Nombre`))
        JOIN `tbb_platillos` `c` ON (`r`.`Descripcion` = `r`.`Descripcion`))
        JOIN `tbb_platillos` `b` ON (`r`.`Estatus` = `r`.`Estatus`));
        
-- ############################################################################################
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `u117932138_raul`@`%` 
    SQL SECURITY DEFINER
VIEW `vw_reservas_en_existencia` AS
    SELECT 
        `r`.`ID` AS `Reserva_ID`,
        `a`.`Nombre` AS `Nombre_Area`,
        `he`.`Fecha_Inicio` AS `Fecha_Reserva_Inicio`,
        `he`.`Fecha_Fin` AS `Fecha_Reserva_Fin`,
        `r`.`Mesa_Asignada` AS `Mesa_Reservada`,
        `r`.`Cantidad_Personas` AS `Cantidad_Personas_Reserva`
    FROM
        ((`tbb_reservas` `r`
        JOIN `tbb_areas` `a` ON (`r`.`Mesa_Asignada` = `a`.`ID`))
        JOIN `tbb_horario_especifico` `he` ON (`r`.`Horario_Especifico_ID` = `he`.`ID`))
    WHERE
        `r`.`Estatus` = '1'
            AND `a`.`Estatus` = '1'
    ORDER BY `he`.`Fecha_Inicio`;
-- ############################################################################################