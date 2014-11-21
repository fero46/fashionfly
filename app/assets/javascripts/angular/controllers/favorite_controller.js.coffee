App.controller 'FavoriteController', ['$scope',($scope) ->
  $scope.clickFavorite = (prefix,id) ->
    fav=$("#"+prefix+id)
    active = "likeon"
    path = fav.attr('path')
    if fav.hasClass(active)
      fav.removeClass(active)
      $.ajax(
        url:path+'/'+id,
        type: 'DELETE'
      )
    else
      $.ajax(
        url:path,
        type: 'POST'
      )
      fav.addClass(active)
  $scope.callForm = (id) ->
    $('#callForm'+id).submit()
]