$('.area').hover(->
  infobox = $(this).attr('data-information')
  $('#'+infobox).show()

).mouseout(->
  infobox = $(this).attr('data-information')
  $('#'+infobox).hide()
).mousemove( (event)->
  x = event.clientX + 10;
  y = event.clientY + 10;
  infobox = $(this).attr('data-information')
  $('#'+infobox).css('left', x + "px")
  $('#'+infobox).css('top', y + "px")
)