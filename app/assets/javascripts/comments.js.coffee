$(document).ready(->
  $('.comment_edit').click(->
    id = $(this).attr('data')
    $('#comment'+id).hide()
    $('#destroy'+id).hide()
    $('#edit'+id).hide()
    $('#cancel'+id).show()
    $('#comment_form'+id).show()
  )
  $('.comment_edit_cancel').click(->
    id = $(this).attr('data')
    $('#comment'+id).show()
    $('#destroy'+id).show()
    $('#edit'+id).show()
    $('#cancel'+id).hide()
    $('#comment_form'+id).hide()
  )
)