// this should be called when 
// sweepDays should be the result of calling future_cleaning_days_formatted

fullSchedule('current location', [["July", [16, 17, 18]], ["August", [21, 22]], ["September", [29, 30]], ["November", [5, 6]]])
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
  } else if(upcomingDays.length == 2){
    htmlString += upcomingDays[0] + ' and ' + upcomingDays[1]
  } else{
    for(var i=0; i < sweepDays.length - 2; i++){
      htmlString += upcomingDays[i] + ', '
    }
  htmlString += 'and ' + upcomingDays[upcomingDays.length-1]
  }
  htmlString += '.</p>'
  console.log(htmlString)
}