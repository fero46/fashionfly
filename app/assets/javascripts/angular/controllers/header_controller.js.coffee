App.controller 'HeaderController', ['$scope',($scope) ->
  $scope.selectCountry = () ->
    $('#country_select').show()
]