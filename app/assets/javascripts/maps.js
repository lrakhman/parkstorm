/**
  Inconsistent implementations.

  You have binds in 'document.ready' else where in the app.
  What makes this one different?

  You call this from index.html.erb:
  $(document).ready(function() {
    $("#modal3_div").hide();
    locate(active_map);
  });

  Really you are binding 2 events and calling find user.

  Why are you waiting to bind the events in a function call?

  Make your code consistent. Really locate is doing a few things. it's binding events and and locating something.

  You have to consider SRP/Separation of concerns in your javascript as well.

  $(document).ready(function() {
    $("#modal3_div").hide();
    bindSomeEvents();
    findUser(active_map);
  });

**/
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