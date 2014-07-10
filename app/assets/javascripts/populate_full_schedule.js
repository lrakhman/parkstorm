function fullSchedule(location, sweepDays){

  var htmlString = '<h3>Street Cleaning Schedule for the Rest of 2014</h3>';

  if (sweepDays.length === 0){
    htmlString += "<p>There are no scheduled street sweepings for the remainder of the year.</p>";
    return htmlString;
  }

  htmlString += '<p>In ' + sweepDays[0][0] + ', streets will be swept at ' + location + ' on the ';

  var upcomingDays = sweepDays[0][1]

  if(upcomingDays.length === 1){
    htmlString += upcomingDays[0]
  } 
  else if(upcomingDays.length == 2){
    htmlString += upcomingDays[0] + ' and ' + upcomingDays[1]
  } 
  else {
    for(var i=0; i < sweepDays.length - 2; i++){
      htmlString += upcomingDays[i] + ', '
    }
  htmlString += 'and ' + upcomingDays[upcomingDays.length-1]
  }
  htmlString += '.</p>'
  
  for(var i=0; i < sweepDays.length; i++){
    var month = sweepDays[i][0];
    var days = sweepDays[i][1];
    htmlString += '<table><tr><th>' + month + '</th></tr>';

    for(var j=0; j < days.length; j++){
      htmlString += '<tr><td>' + days[j] + '</td></tr>';
    }
    htmlString += '</table>';
  }
  return htmlString;
}