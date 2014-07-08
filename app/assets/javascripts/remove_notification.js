$(document).ready(function() {
  $(".remove_notification").on('click', function(e) {
    e.preventDefault();
    href = $(this).attr("href");
    $(this).parent().hide();
    $.post(href, {"_method": "delete"}, function() {});
    return false;
  });
});