$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();

  $('#city_id').change(function(){
    $('#calendar').fullCalendar('refetchEvents');
  });
	
	$('#calendar').fullCalendar({
		editable: false,
		header: {
      left: 'today',
      center: 'prev,next title',
      right: 'month, agendaWeek, agendaDay'
    },
    defaultView: 'month',
    height: 500,
    slotMinutes: 15,

    loading: function(bool){
      if (bool)
          $('#loading').show();
      else
          $('#loading').hide();
    },
    /*
    // a future calendar might have many sources.
    eventSources: [{
      url: '/calendar',
      //color: 'yellow',
      //textColor: 'black',
      ignoreTimezone: false,
      data: { city_id: get_city() }
    }],
    */

    events: {
      url: '/calendar',
      data: function() {
        return { city_id: $('#city_id').val() };
      }
    },

    timeFormat: 'h:mm t{ - h:mm t} ',
    dragOpacity: "0.5",

        // language options
        monthNames: ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" ],
        monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'],
        dayNames: [ 'Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
        dayNamesShort: ['Dom','Lun','Mar','Mié','Jue','Vie','Sáb'],
        buttonText: {
            today: 'Hoy',
            month: ' Mes ',
            week: ' Semana ',
            day: ' Día '
        },
        allDayText: 'todo el día'
	});
});
