$(document).ready(function() {
  $("#address").keyup(function(event){
    if(event.keyCode == 13){
      $("#address_submit").click();
    }
  });
});