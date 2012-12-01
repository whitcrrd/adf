// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready( function() {
  // $('position_PG').show();
  // $('.position_C').hide();
  // $('.position_SG').hide();
  // $('.position_SF').hide();
  // $('.position_PF').hide();
  $('#position_list').on('change', function(){
    console.log(event)
    $('.position_PG').hide();
    $('.position_C').hide();
    $('.position_SG').hide();
    $('.position_SF').hide();
    $('.position_PF').hide();
    $('.position_' + event.target.value).show();
  });
});
