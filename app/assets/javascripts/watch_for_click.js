function watchForClick(marker) {    
  var marker = marker;
  active_map.on('click', function(e) {
    active_map.off('click');
    if(typeof(marker)==='undefined') {
      marker = L.marker(e.latlng,{ draggable: true});       
    } else {
      marker.setLatLng(e.latlng);         
    }
    var data = { latitude: e.latlng.lat, longitude: e.latlng.lng, date: getDateRange() }
    postCurrentLocation(data, 'your selected location', clickPost);
  });
}
function clickPost(data) {
  $.post('/load_region', data, function(response){
    active_map.removeLayer(everything);
    $('#map_script').remove();
    $('#active_map').append(response);
  });
}