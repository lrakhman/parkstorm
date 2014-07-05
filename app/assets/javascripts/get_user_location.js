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
        console.log(response);
          // replace this response with something that renders new map
      }, 'JSON');

      $.post('/update_surrounding', data, function(response){ 
        console.log(response);
          // replace this response with something that renders new map
      }, 'JSON');
    };
    navigator.geolocation.getCurrentPosition(success);
  }
}



