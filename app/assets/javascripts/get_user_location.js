$(document).ready(function(){

  geoFindUser();

});

function geoFindUser() {
 
  if (navigator.geolocation){

    function success(position) {
      var latitude  = position.coords.latitude;
      var longitude = position.coords.longitude;
      var data = {latitude: latitude, longitude: longitude};
      $.post('/current_position', data, console.log('success'));
    };

    function error() {
      
    };

    navigator.geolocation.getCurrentPosition(success, error);
  }
}