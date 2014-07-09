function getDateRange() {
  var start_date = $('input[name=start_date]').val();
  var end_date = $('input[name=end_date]').val();
  return [start_date, end_date];
}