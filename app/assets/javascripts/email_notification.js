function makeNotification(data) {
  $.post('/notifications', data, function(response) {
    if (data.logged_in != true) {  
      if (confirm(response)) {
        location.reload();
      } else {
        location.reload();
        alert("You will not receive any notifications.");
      }
    } else {
      alert(response);
    }
  });
}

function instantNotificationWhenLoggedIn () {
  $('.modal3_label div').on('click', function(e) {
    if ($('.navigation-tools').text().match(/Log Out/) !== null) {
      e.preventDefault();
      makeNotification({notification: {email: ""}, logged_in: true});
    }
  });
}

function watchForNotificationSubmit() {
  $(document).on('submit','#email_notes', function(e) {
    e.preventDefault();
    var data = $('#email_notes').serialize();
    makeNotification(data);
  });
}