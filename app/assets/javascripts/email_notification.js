$(document).ready(function(){
	$(document).on('submit','#email_notes', function(e) {
		e.preventDefault();
		var data = $('#email_notes').serialize();
		makeNotification(data);
	});

  $('#modal3_label div').on('click', function(e) {
    if ($('.navigation-tools').text().match(/Log Out/) !== null) {
      e.preventDefault();
      makeNotification({notification: {email: ""}});
    }
  });
});

function makeNotification(data) {
  $.post('/notifications', data, function(response) {
    if (confirm(response)) {
      location.reload();
    }
    else {
      location.reload();
      alert("You will not receive any notifications.");
    }
  });
}
