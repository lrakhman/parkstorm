function navToggle() {
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
}

function navActivation() {
  $(".nav .nav-link").click(function() {
    $(".nav .nav-link").each(function() {
      $(this).removeClass("active-nav-item");
    });
    $(this).addClass("active-nav-item");
    $(".nav .more").removeClass("active-nav-item");
  });  
}

function animateElements() {
  $("a[href='#move']").click(function() {
    $("html, body").animate({ scrollTop: $(document).height() }, "slow");
  });

  $("#address_submit").click(function() {
    $("html, body").animate({ scrollTop: $(document).height() }, "slow");
  });
}