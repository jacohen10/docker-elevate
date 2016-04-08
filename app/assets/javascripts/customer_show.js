// $(document).ready(function(){
//   $('.menu_header a').click(function(e) {
//     e.preventDefault();
//     var restaurant_name = $(this).text().replace(/\s+/g, '').replace(/['"]+/g, '').replace(/[{()}]/g, '');
//     $(".restaurant_menu").hide();
//     $("#" + restaurant_name + "_menu").show();
//   });
//
//   $("a[href='#menu']").click(function() {
//     var restaurant_name = $(this).parent().parent().children().eq(0).text().replace(/\s+/g, '').replace(/['"]+/g, '').replace(/[{()}]/g, '');
//     $(".restaurant_menu").hide();
//     $("#" + restaurant_name + "_menu").show();
//   });
//
//   $("a[href='#top']").click(function() {
//     $("html, body").animate({
//       scrollTop: 0
//     }, "slow");
//     return false;
//   });
//
//   $("a[href='#menu']").click(function() {
//     $("html, body").animate({
//       scrollTop: $(document).height()
//     }, "slow");
//     return false;
//   });
//
//
//   $(".new_meal #meal_food_item").change(function() {
//     var entree_id = $(this).val();
//     var restaurant_id = $(this).closest("form").attr('id');
//
//     var form = $(this).parent().parent().eq(0);
//     var selected = $(':selected', this);
//     $.ajax({
//       dataType: "json",
//       cache: false,
//       url: '/restaurants/' + restaurant_id + '/' + 'menus/' + entree_id,
//       timeout: 2000,
//       error: function(XMLHttpRequest, errorTextStatus, error) {
//         alert("Failed to submit : " + errorTextStatus + " ;" + error);
//       },
//       success: function(data) {
//         var category_id = data.category_id;
//         $.ajax({
//           dataType: "json",
//           cache: false,
//           url: '/categories/' + category_id + '/sides/',
//           timeout: 2000,
//           error: function(XMLHttpRequest, errorTextStatus, error) {
//             alert("Failed to submit : " + errorTextStatus + " ;" + error);
//           },
//           success: function(side_data) {
//             // Clear all options from sub category select
//             $("#" + restaurant_id + "sides option").remove();
//             //put in a empty default line
//
//             // Fill sub category select
//             $.each(side_data, function(i, j) {
//               row = "<option value=\"" + j.id + "\">" + j.side_item + "</option>";
//               $(row).appendTo("#" + restaurant_id + "sides");
//             });
//           }
//         });
//
//       }
//     });
//   });
//
//   $("form").submit(function(e) {
//     var ref = $(this).find("[required]");
//     $(ref).each(function() {
//       if ($(this).val() === '') {
//         alert("Required field should not be blank.");
//         $(this).focus();
//         e.preventDefault();
//         return false;
//       }
//     });
//     return true;
//   });
//
// });
