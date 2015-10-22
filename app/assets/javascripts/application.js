// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui-1.10.2.custom.min
//= require jquery_ujs
//= require jquery.alphanum
//= require jquery.maskedinput
//= require bootstrap3/bootstrap.min

$(function(){         
  $(".numeric-integer").numeric({allowDecSep :false});
  $(".numeric-float").numeric({maxDecimalPlaces :2, max :10000});
  $(".phone").mask("99-9-999-999");
  $(".idcard").mask("999999999-9");
  $(".date").mask("99/99/9999");
  $(".hour").mask("99:99");
  // function set setup datepicker
  $.datepicker.setDefaults({
    showOn: "both",
    buttonImage: "/assets/calendar.gif",
    buttonImageOnly: true,
    dateFormat:'yy/mm/dd',
    defaultDate: new Date(),
    dayNames: [ "Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado'" ],
    dayNamesMin: [ "Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa" ],
    monthNames: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
  });
});


