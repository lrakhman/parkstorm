$(document).ready(function() {
  $("#address").keyup(function(event){
    if(event.keyCode == 13){
      $("button#address_submit").click();
    }
  });

  $("#lower_address").keyup(function(event){
    if(event.keyCode == 13){
      $("button#lower_address_submit").click();
    }
  });

  $('#update_from_date.button').on('click', function() {
    active_map.off('click');
    $.post('/load_after_date_change', {date: getDateRange()}, function(response) {
      active_map.removeLayer(allMapElements);
      $('#map_script').remove();
      $('#active_map').append(response);
    });
  });
});