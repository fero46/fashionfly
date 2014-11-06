App.controller 'FavoriteController', ['$scope',($scope) ->
  $scope.clickFavorite = (product_id) ->
    fav=$("#fav"+product_id)
    active = "likeon"
    path = fav.attr('path')
    if fav.hasClass(active)
      fav.removeClass(active)
      $.ajax(
        url:path+'/'+product_id,
        type: 'DELETE'
      )
    else
      $.ajax(
        url:path,
        type: 'POST'
      )
      fav.addClass(active)
  $scope.callForm = () ->
    $('.callForm').submit()
]