$(document).ready(function(){
  $('#address_submit').on('click', function(event){
    event.preventDefault();
    var data;
    var address = $('#address').val() + ' chicago';
    $('#address').val('')
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({'address': address}, function(results, status){
      var lat = results[0].geometry.location.k;
      var lng = results[0].geometry.location.B;
      data = {latitude: lat, longitude: lng};
      console.log('a')
      console.log(data)
      $.post('/update_surrounding', data, function(response){ 
        $('#active_map').replaceWith(response)
        // render new map at the bottom of the page? put it on the page in the right place
      });

      $.post('/current_position', data, function(response){ 
        $('.copy p:first-child').html('Next Street Cleaning<br>For Your Location Is:<br>' + response.next_sweep);
        var days = response.sweep_days;
        str = "<h3>Street Cleaning Days</h3><ul>";
        for (var i=0; i<days.length; i++) {
          str += '<li>' + days[i] + '</li>';
        }
        $('.cleaning_col').html(str + '</ul>');
          // replace this response with something that renders new map on top of old map
      }, 'JSON');
    });
    

  })
});