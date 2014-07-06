$(document).ready(function(){
  // $('#search').on('submit', function(event){
    // event.preventDefault();
    var address = '2550 n lakeview ave chicago'
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({'address': address}, function(results, status){
      console.log(results[0].geometry.location.toString())
    })

  // })
});