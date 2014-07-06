$(document).ready(function(){

  findUser();

});

function findUser() {
 
  if (navigator.geolocation){

    function success(position) {
      var latitude  = position.coords.latitude;
      var longitude = position.coords.longitude;
      var data = {latitude: latitude, longitude: longitude};
      $.post('/current_position', data, function(response){ 
        $('.copy :first-child').html('Next Street Cleaning<br>For Your Location Is:<br>' + response.next_sweep);
        var days = response.sweep_days;
        str = "<h3>Next Cleaning: " + response.next_sweep + "</h3><h3>Street Cleaning Days</h3><ul>";
        for (var i=0; i<days.length; i++) {
          str += '<li>' + days[i] + '</li>';
        }
        $('.cleaning_col').html(str + '</ul>');
      }, 'JSON');
      $.post('/load_region', data, function(response){
        $('#active_map').append(response);
      })
      // $.post('/update_surrounding', data, function(response){ 
      //   $('#active_map').replaceWith(response);
      // });
    };
    navigator.geolocation.getCurrentPosition(success);
  }
}
