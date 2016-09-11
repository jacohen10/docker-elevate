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
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function() {
  appFunctions()
});
  function appFunctions() {

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

    $('.restaurant_menu').hide();
    $("select[name='meal[food_item]'] option:eq(0)").attr("disabled", "disabled");
    $("#customer_phone").mask("(000) 000-0000", {
      placeholder: '(___) ___-____'
    });
    $('.menu-header a').click(function(e) {
      var restaurant_name;
      e.preventDefault();
      restaurant_name = $(this).text().replace(/\s+/g, '').replace(/['"]+/g, '').replace(/[{()}]/g, '');
      $('.restaurant_menu').hide();
      $("#" + restaurant_name + "_menu").show();
    });
    $('a[href=\'#menu\']').click(function() {
      var restaurant_name;
      restaurant_name = $(this).parent().parent().children().eq(0).text().replace(/\s+/g, '').replace(/['"]+/g, '').replace(/[{()}]/g, '');
      $('.restaurant_menu').hide();
      $("#" + restaurant_name + "_menu").show();
    });
    $('a[href=\'#top\']').click(function() {
      $('html, body').animate({
        scrollTop: 0
      }, 'slow');
      return false;
    });
    $('a[href=\'#menu\']').click(function() {
      $('html, body').animate({
        scrollTop: $(document).height()
      }, 'slow');
      return false;
    });
    $('.new_meal #meal_food_item').change(function() {
      var entree_id, form, restaurant_id, selected;
      entree_id = $(this).val();
      restaurant_id = $(this).closest('form').attr('id');
      form = $(this).parent().parent().eq(0);
      selected = $(':selected', this);
      $.ajax({
        dataType: 'json',
        cache: false,
        url: '/restaurants/' + restaurant_id + '/' + 'menus/' + entree_id,
        timeout: 2000,
        error: function(XMLHttpRequest, errorTextStatus, error) {
          alert('Failed to submit : ' + errorTextStatus + ' ;' + error);
        },
        success: function(data) {
          var category_id;
          category_id = data.category_id;
          $.ajax({
            dataType: 'json',
            cache: false,
            url: '/categories/' + category_id + '/sides/',
            timeout: 2000,
            error: function(XMLHttpRequest, errorTextStatus, error) {
              alert('Failed to submit : ' + errorTextStatus + ' ;' + error);
            },
            success: function(side_data) {
              $('#' + restaurant_id + 'sides option').remove();
              $.each(side_data, function(i, j) {
                var row;
                row = '<option value="' + j.id + '">' + j.side_item + '</option>';
                $(row).appendTo('#' + restaurant_id + 'sides');
              });
            }
          });
        }
      });
    });
    $('form').submit(function(e) {
      var ref;
      ref = $(this).find('[required]');
      $(ref).each(function() {
        if ($(this).val() === '') {
          alert('Required field should not be blank.');
          $(this).focus();
          e.preventDefault();
          return false;
        }
      });
      return true;
    });

  }
