function forgotPassword() {
  $('#forgotpw').click(function() {
    $('form#login').remove();
    $('#login-container').load("users/password/new");
  });
}