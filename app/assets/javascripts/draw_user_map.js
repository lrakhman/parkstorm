$(document).ready(function() {
  $.post('/load_user_map', {date: getDateRange()}, function(response) {
    $('#personal_map').html(response);
  });
});