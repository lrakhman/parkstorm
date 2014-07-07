$(document).ready(function(){
	$(document).on('submit','#email_notes', function(e) {
		e.preventDefault();
		var data = $('#email_notes').serialize();
		$.post('/notifications', data, function(response) {
			alert(response);
		});
	});
});