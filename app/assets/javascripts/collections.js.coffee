$('.area').hover(->
  infobox = $(this).attr('data-information')
  $('#'+infobox).show()

).mouseout(->
  infobox = $(this).attr('data-information')
  $('#'+infobox).hide()
).mousemove( (event)->
  x = event.pageX;
  y = event.pageY;
  infobox = $(this).attr('data-information')
  $('#'+infobox).css('left', x)
  $('#'+infobox).css('top', y)
)