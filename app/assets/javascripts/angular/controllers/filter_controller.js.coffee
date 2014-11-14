App.controller 'FilterController', ['$scope',($scope) ->

  init = () ->
    params = $.deparam.querystring()
    color = params.color
    $('#'+color).addClass('active')
    $(document).ready( ->
      $('#price').val(window.index_of($scope.items, params.price)) if !!params.price
      if !!params.sort_by
        $('#sort_by').val(params.sort_by)
      else
        $('#sort_by').val(0)
      $('#per').val(window.index_of($scope.pers, params.per))
    )

  rebuild_query = (newparam={}) ->
    params = $.deparam.querystring()
    params = $.extend(params, newparam);
    str = jQuery.param( params )
    new_location = window.location.pathname.toString()
    if(str.length > 0)
      new_location = new_location+"?"+str
    window.location.replace(new_location)

  $scope.items = ['0-50' ,'50-100', '100-250', '250-500', '>500']
  $scope.sortings = $('#sort_by').attr('values').split('#') if $('#sort_by').length
  $scope.pers = ['12', '24', '36', '48', '60']
  $scope.colorSelect = (colorSelect) ->
    rebuild_query({color: colorSelect})

  $scope.changeSelect = (key, selectedItem) ->
    store={}
    if key == 'price' || key == 'per'
      store[key] = selectedItem
    else
      value = window.index_of($scope.sortings, selectedItem)
      store[key] = value
    rebuild_query(store)

  window.rebuild=init()
  init()
]