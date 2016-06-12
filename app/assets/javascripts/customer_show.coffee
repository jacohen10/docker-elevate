$(document).ready ->
  $('.restaurant_menu').hide()

  $('.menu-header a').click (e) ->
    e.preventDefault()
    restaurant_name = $(this).text().replace(/\s+/g, '').replace(/['"]+/g, '').replace(/[{()}]/g, '')
    $('.restaurant_menu').hide()
    $("##{restaurant_name}_menu").show()
    return
  $('a[href=\'#menu\']').click ->
    restaurant_name = $(this).parent().parent().children().eq(0).text().replace(/\s+/g, '').replace(/['"]+/g, '').replace(/[{()}]/g, '')
    $('.restaurant_menu').hide()
    $("##{restaurant_name}_menu").show()
    return
  $('a[href=\'#top\']').click ->
    $('html, body').animate { scrollTop: 0 }, 'slow'
    false
  $('a[href=\'#menu\']').click ->
    $('html, body').animate { scrollTop: $(document).height() }, 'slow'
    false
  $('.new_meal #meal_food_item').change ->
    entree_id = $(this).val()
    restaurant_id = $(this).closest('form').attr('id')
    form = $(this).parent().parent().eq(0)
    selected = $(':selected', this)
    $.ajax
      dataType: 'json'
      cache: false
      url: '/restaurants/' + restaurant_id + '/' + 'menus/' + entree_id
      timeout: 2000
      error: (XMLHttpRequest, errorTextStatus, error) ->
        alert 'Failed to submit : ' + errorTextStatus + ' ;' + error
        return
      success: (data) ->
        category_id = data.category_id
        $.ajax
          dataType: 'json'
          cache: false
          url: '/categories/' + category_id + '/sides/'
          timeout: 2000
          error: (XMLHttpRequest, errorTextStatus, error) ->
            alert 'Failed to submit : ' + errorTextStatus + ' ;' + error
            return
          success: (side_data) ->
            # Clear all options from sub category select
            $('#' + restaurant_id + 'sides option').remove()
            #put in a empty default line
            # Fill sub category select
            $.each side_data, (i, j) ->
              row = '<option value="' + j.id + '">' + j.side_item + '</option>'
              $(row).appendTo '#' + restaurant_id + 'sides'
              return
            return
        return
    return
  $('form').submit (e) ->
    ref = $(this).find('[required]')
    $(ref).each ->
      if $(this).val() == ''
        alert 'Required field should not be blank.'
        $(this).focus()
        e.preventDefault()
        return false
      return
    true
  return
