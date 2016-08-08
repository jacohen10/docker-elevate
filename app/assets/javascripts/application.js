// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function() {
  $('#selectAll').click(function() {
    if (this.checked) {
      $('.unpaid:checkbox').each(function() {
        this.checked = true;
      });
    } else {
      $('.unpaid:checkbox').each(function() {
        this.checked = false;
      });
    }
  });



  $('#meal_submit_form').submit(function() {
    return confirm('Are you sure?');
  });

  $('.payment-errors').bind("DOMSubtreeModified",function(){
    $('#loader').hide()
  });

  $('.pay-by-card').on('click', function(e){
    $('#amountToCharge').val($(this).data('amounttocharge'))
    $('#selectedPlan').val($(this).data('plan'))
    $('#payByCardPlan').text($(this).data('plan') + ' Meals')

  })

  $('.pay-by-check').on('click', function(e){
    $('#check-meals').text($(this).data('meals'))
    $('#check-base').text($(this).data('base'))
    $('.check-price').text($(this).data('price'))
  })


  $('#payment-form').submit(function(event) {
      $('#loader').show()
      var $form = $(this);

      // Disable the submit button to prevent repeated clicks
      $form.find('button').prop('disabled', true);

      Stripe.card.createToken($form, stripeResponseHandler);

      // Prevent the form from submitting with the default action
      return false;
      $('#loader').hide()
      $('#payByCard15').modal('hide')
    });

  function stripeResponseHandler(status, response) {
    var $form = $('#payment-form');

    if (response.error) {
      // Show the errors on the form
      $form.find('.payment-errors').text(response.error.message);
      $form.find('button').prop('disabled', false);
    } else {
      // response contains id and card, which contains additional card details
      var token = response.id;
      // Insert the token into the form so it gets submitted to the server
      $form.append($('<input type="hidden" name="stripeToken" />').val(token));
      // and submit
      $form.get(0).submit();
    }
  };

});
