function findAddress(selector){
  var address = $(selector).val();
  $(selector).val('')
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode({'address': address + 'chicago'}, function(results, status){
    if(status === 'OK'){
      buildAddress(results);
    }
    else{
      buildSidebarNotFound();
    }    
  });
}

function buildAddress(results){
  if(isNaN(results[0].address_components[0].short_name)){
    address = results[0].address_components[0].short_name
  }
  else{
    address = results[0].address_components[0].short_name + " " + results[0].address_components[1].short_name
  } 
  var lat = results[0].geometry.location.k;
  var lng = results[0].geometry.location.B;
  data = {latitude: lat, longitude: lng, date: getDateRange()};
  updatePageFromAddress(data, address);
}

function updatePage(data, location) {
  postLocation(data, location, pagePost);
}

function updatePageFromAddress(data, location) {
  postLocation(data, location, addressPost);
}

function postLocation(data, location, regionFunction) {
  $.post('/current_position', data, function(response){
    var days = response.sweep_days;
    if (days.length > 0) {
      buildSidebarWithDate(location, response);
      $('.monthly_schedule').html(fullSchedule(location, days));
    } else {
      buildSidebarNoDate(location);
      $('.monthly_schedule').html("");
    }
    regionFunction(data);
  }, 'JSON');
}

function addressSubmit() {

  $('#lower_address_submit').on('click', function(event){
    findAddress('#lower_address');
  })
}

function addressPost(data) {
  $.post('/load_region_from_address', data, function(response){ 
    $('#active_map').replaceWith(response)
    addLegend(active_map);
  });
}

function pagePost(data) {
  $.post('/load_region', data, function(response){ 
    $('#active_map').append(response);
  });
}

function renderDate(date){
  var response = date.split(" ")
  if (isNaN(response[1])) {
    return "<div>No sweeping scheduled for this location</div>";
  } else {
    return "<div id = 'date_icon'><div id = 'month'>" + response[0] + "</div><div id = 'day'>" + response[1]  + "</div></div>"
  }
}

function buildSidebarNotFound(){
  $('.next p').html('<h3>Location not found</h3><p>Please enter another address.</p>');
  $(".modal3_div").hide();
  $('.notify_exp').html('');
  $('.monthly_schedule').html('');
}

function buildSidebarWithDate(location, response) {
  $('.next p').html('<h3>Next street cleaning for ' + location + ':</h3><br>' + renderDate(response.next_sweep));
  $(".modal3_div").show();
  $('.notify_exp').html('Want email or SMS notifications for street sweeping at this location?  Sign up here.');
}

function buildSidebarNoDate(location) {
  $('.next p').html('<h3>There is no scheduled street sweeping<br>for ' + location + '.</h3><p>Please select another location to see street sweeping dates.</p>');
  $(".modal3_div").hide();
  $('.monthly_schedule').html('');
  $('.notify_exp').html('');
}