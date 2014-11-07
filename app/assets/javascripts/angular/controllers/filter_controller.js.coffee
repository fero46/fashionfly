App.controller 'FilterController', ['$scope',($scope) ->

  init = () ->
    params = $.deparam.querystring()
    color = params.color
    $('#'+color).addClass('active')
    $(document).ready(->
      counter = 0
      result = 0
      for item in $scope.items
        if item == params.price
          result = counter
        counter+=1
      $('#price').val(result)
    )

    
  rebuild_query = (newparam={}) ->
    params = $.deparam.querystring()
    params = $.extend(params, newparam);
    str = jQuery.param( params )
    new_location = window.location.pathname.toString()
    if(str.length > 0)
      new_location = new_location+"?"+str
    window.location.replace(new_location)

  $scope.items = ['0-50' ,'50-100', '100-250', '250-500', '>500'];

  $scope.colorSelect = (colorSelect) ->
    rebuild_query({color: colorSelect})

  $scope.changeSelect = (selectedItem) ->
    rebuild_query({price: selectedItem})

  init()
]