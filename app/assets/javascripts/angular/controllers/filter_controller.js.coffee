App.controller 'FilterController', ['$scope',($scope) ->

  rebuild_query = (newparam={}) ->
    params = $.deparam.querystring()
    params = $.extend(params, newparam);
    str = jQuery.param( params )
    new_location = window.location.pathname.toString()
    if(str.length > 0)
      new_location = new_location+"?"+str
    window.location.replace(new_location)

  $scope.colorSelect = (colorSelect) ->
    rebuild_query({color: colorSelect})
]