$(document).ready(function() {
	$('#forgotpw').click(function() {
		$('form#login').remove();
		$('#login-container').load("users/password/new");
	});
});