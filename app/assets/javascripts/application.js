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

  $('#menu_form').click(function(e) {
    e.preventDefault();
    $(".new_menu").show();
  });

  // $(".new_meal #meal_food_item").change(function(){
  //   var selected = $(':selected', this);
  //   var category = selected.closest('optgroup').attr('label')
  //   var restaurant = $(this).closest("form").attr('id');
  //   var form = $(this).parent().parent().eq(0)
  //   var id_value_string = $(this).val();
  // });



  //   $("select#gallery_section_id").change(function(){
  //     var id_value_string = $(this).val();
      // if (id_value_string === "") {
      //   // if the id is empty remove all the sub_selection options from being selectable and do not do any ajax
      //   $("select#gallery_sub_section_id option").remove();
      //   var row = "<option value=\"" + "" + "\">" + "" + "</option>";
      //   $(row).appendTo("select#gallery_sub_section_id");
      // }
      // else {
      //   // Send the request and update sub category dropdown
      //   $.ajax({
      //     dataType: "json",
      //     cache: false,
      //     url: '/sub_sections/for_sectionid/' + id_value_string,
      //     timeout: 2000,
      //     error: function(XMLHttpRequest, errorTextStatus, error){
      //       alert("Failed to submit : "+ errorTextStatus+" ;"+error);
      //     },
      //     success: function(data){
      //       // Clear all options from sub category select
      //       $("select#gallery_sub_section_id option").remove();
      //       //put in a empty default line
      //       var row = "<option value=\"" + "" + "\">" + "" + "</option>";
      //       $(row).appendTo("select#gallery_sub_section_id");
      //       // Fill sub category select
      //       $.each(data, function(i, j){
      //         row = "<option value=\"" + j.sub_section.id + "\">" + j.sub_section.name + "</option>";
      //         $(row).appendTo("select#gallery_sub_section_id");
      //       });
      //     }
      //   });
      // }
  //   });


});
