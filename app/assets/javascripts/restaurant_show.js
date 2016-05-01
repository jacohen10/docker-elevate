$(document).ready(function(){
  function highlight_meal_requests() {
    $('.meal-requests').each(function() {
      if ($(this).html() !== '') {
        $(this).css('background', 'yellow');
      }
    });
  }

  highlight_meal_requests();
});
