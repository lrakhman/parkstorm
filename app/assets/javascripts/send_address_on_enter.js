$(document).ready(function() {
  $("#address").keyup(function(event){
    if(event.keyCode == 13){
      $("#address_submit").click();
    }
  });

  $("#lower_address").keyup(function(event){
    if(event.keyCode == 13){
      $("#lower_address_submit").click();
    }
  });

  $('#update_from_date').on('click', function() {
    active_map.off('click');
    $.post('/load_after_date_change', {date: getDateRange()}, function(response) {
      active_map.removeLayer(everything);
      $('#map_script').remove();
      $('#active_map').append(response);
    });
  });
});