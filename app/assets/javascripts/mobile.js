$(document).ready(function(){
  $('#toggle').on('click', function(){
    var $toggle = $(this),
        $mobile = $('#mobile'),
        mobileHeight = $mobile.height(),
        windowHeight = $(window).height();
    
    if ($mobile.css('display') === 'none'){
      $mobile.addClass('slide-up')
      $mobile.css({
        'display': 'block'
      });

      $toggle.css({
        'bottom': (mobileHeight) + 'px'
      })
    }
    else {
      $mobile.css({
        'display': 'none'
      });
      $toggle.css({
        'bottom': 0
      })  
    }
    
  });
});