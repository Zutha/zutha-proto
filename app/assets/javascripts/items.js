$(function(){
 // Events
  $('.vote').live('ajax:success', function(event, data){
    var parent = $(this).parent('.voting');
    parent.replaceWith(data);
    // parent.fadeOut('fast', function() {
    //   parent.html(data);
    //   parent.fadeIn();
    // });
  });

});