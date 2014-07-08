function locate(map) {
  if (navigator.geolocation) {  
    function success(position) {
      var latitude  = position.coords.latitude;
      var longitude = position.coords.longitude;
      map.setView([latitude, longitude], 15);
    }
    navigator.geolocation.getCurrentPosition(success);
  }
}