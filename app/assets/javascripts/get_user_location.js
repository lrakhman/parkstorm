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
        $('.copy p:first-child').html('The Next Street Cleaning<br>For Your Location Is:<br>' + response.next_sweep);
        var days = response.sweep_days;
        str = "<h3>Street Cleaning Days</h3><ul>";
        for (var i=0; i<days.length; i++) {
          str += '<li>' + days[i] + '</li>';
        }
        $('.cleaning_col').html(str + '</ul>');
          // replace this response with something that renders new map on top of old map
      }, 'JSON');

      $.post('/update_surrounding', data, function(response){ 
        $('#active_map').replaceWith(response)
        // render new map at the bottom of the page? put it on the page in the right place
      });
    };
    navigator.geolocation.getCurrentPosition(success);
  }
}
