function locateUser(map) {
  if (navigator.geolocation) {  
    navigator.geolocation.getCurrentPosition(function(position) {
      var latitude  = position.coords.latitude;
      var longitude = position.coords.longitude;
      map.setView([latitude, longitude], 15);
      var data = {latitude: latitude, longitude: longitude, date: getDateRange()};
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

function addLegend(active_map) {
  if ($('#next').length > 0) {
    addMainLegend();
  } else {
    addDateLegend();
  }
}

function addMainLegend() {
  legend.onAdd = function (map) {
    var div = L.DomUtil.create('div', 'info legend');
    div.innerHTML += '<b>Streets will next be swept in:</b><br><br>' +
            '<i style="background: red"></i> ' + 'less than a week<br><br>' + '<i style="background: green"></i> ' + 'a week or more';
    return div;
  };
  legend.addTo(active_map);
}

function addDateLegend() {
  legend.onAdd = function (map) {
    var div = L.DomUtil.create('div', 'info legend');
    div.innerHTML += '<b>Streets will next be swept:</b><br><br>' +
            '<i style="background: red"></i> ' + 'during the date range<br><br>' + '<i style="background: green"></i> ' + 'outside the date range';
    return div;
  };
  legend.addTo(active_map);
}