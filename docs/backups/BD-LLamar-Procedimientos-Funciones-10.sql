-- Procedimientos
call u117932138_bdsazonmaxico.sp_Actualizar_Menu_Del_Dia();

call sp_Agregar_Usuarios_Aleatorios(cantidad);

call sp_Confirmar_Reserva_EnviarCorreo(reservaid);

call sp_estatus_bd();

call sp_inserta_usuarios(cuantos);

call sp_insertar_personas(cuantos);

call sp_Insertar_Puntuacion_Comentario(nombre_usuario, platilloID, Calificacion, Comentario);

call sp_Insertar_Usuario_Aleatorio(id);

call sp_limpia_bd();

call sp_ReservarMesa(reservaID);

-- Funciones
SELECT fn_bandera_porcentaje(porcentaje);

SELECT fn_bloquear_platillo(id);

SELECT fn_calcula_edad(fecha);

SELECT fn_genera_apellido();

SELECT fn_genera_email();

SELECT fn_genera_fecha_nacimiento(fecha_inicio, fecha_fin);

SELECT fn_genera_nombre();

SELECT fn_genera_nombre_simple();

SELECT fn_genera_nombre_usuario();

SELECT fn_generar_numero_telefonico();

SELECT fn_numero_aleatorio_rangos(limite_inferior, limite_superior);

SELECT fn_password_aleatorio(min_caracteres, max_caracteres);

SELECT fn_remplaza_caracteres();