$(document).ready ->
  $('.add_button').click(->
    $(this).parent().parent().children('.formular').toggle()
    return false
  )
  $('.arrow_right').click(->
    $(this).hide()
    $(this).parent().children('.arrow_down').show()
    $(this).parent().parent().children('.subcat').show()
  )
  $('.arrow_down').click(->
    $(this).hide()
    $(this).parent().children('.arrow_right').show()
    $(this).parent().parent().children('.subcat').hide()
  )