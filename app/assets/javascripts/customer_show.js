// $(document).ready(function() {
//   $('.restaurant_menu').hide();
//   $("select[name='meal[food_item]'] option:eq(0)").attr("disabled", "disabled");
//   $("#customer_phone").mask("(000) 000-0000", {
//     placeholder: '(___) ___-____'
//   });
//   $('.menu-header a').click(function(e) {
//     var restaurant_name;
//     e.preventDefault();
//     restaurant_name = $(this).text().replace(/\s+/g, '').replace(/['"]+/g, '').replace(/[{()}]/g, '');
//     $('.restaurant_menu').hide();
//     $("#" + restaurant_name + "_menu").show();
//   });
//   $('a[href=\'#menu\']').click(function() {
//     var restaurant_name;
//     restaurant_name = $(this).parent().parent().children().eq(0).text().replace(/\s+/g, '').replace(/['"]+/g, '').replace(/[{()}]/g, '');
//     $('.restaurant_menu').hide();
//     $("#" + restaurant_name + "_menu").show();
//   });
//   $('a[href=\'#top\']').click(function() {
//     $('html, body').animate({
//       scrollTop: 0
//     }, 'slow');
//     return false;
//   });
//   $('a[href=\'#menu\']').click(function() {
//     $('html, body').animate({
//       scrollTop: $(document).height()
//     }, 'slow');
//     return false;
//   });
//   $('.new_meal #meal_food_item').change(function() {
//     var entree_id, form, restaurant_id, selected;
//     entree_id = $(this).val();
//     restaurant_id = $(this).closest('form').attr('id');
//     form = $(this).parent().parent().eq(0);
//     selected = $(':selected', this);
//     $.ajax({
//       dataType: 'json',
//       cache: false,
//       url: '/restaurants/' + restaurant_id + '/' + 'menus/' + entree_id,
//       timeout: 2000,
//       error: function(XMLHttpRequest, errorTextStatus, error) {
//         alert('Failed to submit : ' + errorTextStatus + ' ;' + error);
//       },
//       success: function(data) {
//         var category_id;
//         category_id = data.category_id;
//         $.ajax({
//           dataType: 'json',
//           cache: false,
//           url: '/categories/' + category_id + '/sides/',
//           timeout: 2000,
//           error: function(XMLHttpRequest, errorTextStatus, error) {
//             alert('Failed to submit : ' + errorTextStatus + ' ;' + error);
//           },
//           success: function(side_data) {
//             $('#' + restaurant_id + 'sides option').remove();
//             $.each(side_data, function(i, j) {
//               var row;
//               row = '<option value="' + j.id + '">' + j.side_item + '</option>';
//               $(row).appendTo('#' + restaurant_id + 'sides');
//             });
//           }
//         });
//       }
//     });
//   });
//   $('form').submit(function(e) {
//     var ref;
//     ref = $(this).find('[required]');
//     $(ref).each(function() {
//       if ($(this).val() === '') {
//         alert('Required field should not be blank.');
//         $(this).focus();
//         e.preventDefault();
//         return false;
//       }
//     });
//     return true;
//   });
// });
