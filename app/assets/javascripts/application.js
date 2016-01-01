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

  // $('#payAll').click(function() {
  //        $(':submit').submit();
  //    });

    //  $("#payAll").click(function() {
    //    console.log("works");
    //    $('.edit_meal').each(function() {
    //      console.log(this);
    //         $(this).submit();
    //     });
    //   });

});
