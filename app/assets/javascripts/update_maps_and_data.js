$(document).ready(function(){

  findUser();

  $('#address_submit').on('click', function(event){
    findAddress();
  })
});


function findUser() {
  if (navigator.geolocation){
    function success(position) {
      var latitude  = position.coords.latitude;
      var longitude = position.coords.longitude;
      var data = {latitude: latitude, longitude: longitude};

      updatePage(data, 'Your Current Location')
    };
    navigator.geolocation.getCurrentPosition(success);
  }
}

function findAddress(){
  var data;
  var address = $('#address').val();
  $('#address').val('')
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode({'address': address + 'chicago'}, function(results, status){
    var lat = results[0].geometry.location.k;
    var lng = results[0].geometry.location.B;
    data = {latitude: lat, longitude: lng};
    
    updatePage(data, address);
  });
}

function updatePage(data, location) {
  $.post('/update_surrounding', data, function(response){ 
    $('#active_map').replaceWith(response)
  });

  $.post('/current_position', data, function(response){ 
    $('.copy p:first-child').html('Next Street Cleaning<br>For ' + location + ' Is:<br>' + response.next_sweep);
    var days = response.sweep_days;
    str = "<h3>Street Cleaning Days</h3><ul>";
    for (var i=0; i<days.length; i++) {
      str += '<li>' + days[i] + '</li>';
    }
    $('.cleaning_col').html(str + '</ul>');
  }, 'JSON');
}