/**
  $(document).ready(function(){

  AND

  $(function() {

  are the SAME THING.

  Essentially you have 2 nested document readys. Why?

  All of these events have lost their context.
  I would suggest taking the callbacks and extracting
  the functions to named methods for clarity.
**/

$(document).ready(function(){
  $(function() {
    var menu = $('#navigation-menu');
    var menuToggle = $('#js-mobile-menu');
    var signUp = $('.sign-up');

    $(menuToggle).on('click', function(e) {
      e.preventDefault();
      menu.slideToggle(function(){
        if(menu.is(':hidden')) {
          menu.removeAttr('style');
        }
      });
    });

    // underline under the active nav item
    $(".nav .nav-link").click(function() {
      $(".nav .nav-link").each(function() {
        $(this).removeClass("active-nav-item");
      });
      $(this).addClass("active-nav-item");
      $(".nav .more").removeClass("active-nav-item");
    });
  });

  $("a[href='#move']").click(function() {
    $("html, body").animate({ scrollTop: $(document).height() }, "slow");
  });

  $("#address_submit").click(function() {
    $("html, body").animate({ scrollTop: $(document).height() }, "slow");
  });
});