window.App.directive "mySrc", ->
  link: (scope, element, attrs) ->
    img = undefined
    loadImage = undefined
    img = null
    element[0].src = window.image_path('spinner.gif')
    $(element).addClass('spinner');
    loadImage = ->
      img = new Image()
      img.src = attrs.mySrc
      img.onload = ->
        $(element).addClass('image');
        $(element).removeClass('spinner');

        element[0].src = attrs.mySrc
        return

      return
    scope.$watch (->
      attrs.mySrc
    ), (newVal, oldVal) ->
      loadImage()
      return

    return
