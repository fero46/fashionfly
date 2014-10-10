class @Designer

  @counter = 0

  constructor: ->
    myself = this
    $(window).resize( ->
      myself.resize()
    )
    this.resize()
    $(".objectDrag").draggable({helper:'clone'})
    $("#droparea").droppable(
      accept: ".objectDrag",
      drop: (e,ui) ->
          element = null
          $(this).append(
            element = $(ui.draggable).clone().css(
              position:"absolute",
              top: e.clientY-e.offsetY,
              left: e.clientX-e.offsetX
              zIndex: myself.new_counter
            ).addClass("draging_product")
          )
          myself.make_clickable(element)
    )
    $('.design_canvas').click( -> 


    )


  new_counter: =>
    @counter = @counter + 1
    @counter


  resize: =>
    viewportWidth = $(window).width()
    viewportHeight = $(window).height()
    newWidth = viewportWidth - 420
    $('.design_canvas').width(newWidth)
    $('.design_canvas').height(viewportHeight)
    $('.design_canvas .area').width(newWidth-60)
    $('.design_canvas .area').height(viewportHeight-60)

  make_clickable: (element)=>
    element.attr('tabindex', -1)
    myself = this
    element.click( (e)->
      $(this).zIndex(myself.new_counter)
      myself.add_special($(this))
    )
    element.focusin( (e) ->
      $(this).resizable("enable")
      $(this).parent().draggable("enable")
    )
    element.focusout( (e) ->
      $(this).resizable("disable")
      $(this).parent().draggable("disable")
    )
    this.add_special(element)


  add_special: (element)=>
    element.resizable(
      handles: 'ne, se, sw, nw',
      aspectRatio: true
      resize: (event, ui) ->
        console.log('ui')
    )
    element.parent().draggable(
      containment: "parent",
      stack: ".product_in_front",
      cursor: "crosshair"
    )
    topZ = self.new_counter;
    $('.click-to-top').each(()->
        thisZ = parseInt($(this).parent().css('z-index'), 10);
        if (thisZ > topZ)
          topZ = thisZ;
        
    )
    element.parent().css('z-index', self.new_counter);
    element.focus()


