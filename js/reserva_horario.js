document.addEventListener("DOMContentLoaded", function() {
  // Inicializar el calendario
  $("#fecha_reserva").datepicker({
      dateFormat: "yy-mm-dd",
      minDate: 0
  });

  // Inicializar el selector de hora
  $("#hora_reserva").attr("min", "09:00");
  $("#hora_reserva").attr("max", "23:00");

  // Resto del código para enviar la reserva y mostrar la confirmación
});
