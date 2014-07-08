function locate(map) {
  $('#address_submit').on('click', function(event){
    findAddress('#address');
  })

  $('#lower_address_submit').on('click', function(event){
    findAddress('#lower_address');
  })

  findUser(map);
}

function findUser(map) {
  if (navigator.geolocation) {  
    navigator.geolocation.getCurrentPosition(function(position) {
      var latitude  = position.coords.latitude;
      var longitude = position.coords.longitude;
      map.setView([latitude, longitude], 15);
      var data = {latitude: latitude, longitude: longitude};
      updatePage(data, 'your current location');
    }, function () {
      map.setView([41.8893288, -87.63722539999999], 15);
      var data = {latitude: 41.8893288, longitude: -87.63722539999999};
      updatePage(data, 'Dev Bootcamp');
    });
  } else {
    map.setView([41.8893288, -87.63722539999999], 15);
    var data = {latitude: 41.8893288, longitude: -87.63722539999999};
    updatePage(data, 'Dev Bootcamp');
  }
}