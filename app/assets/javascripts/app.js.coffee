window.App = angular.module('FashionFly', ['ngResource'])
window.index_of = (array, value) ->
  counter = 0
  result = 0
  for item in array
    if item == value
      result = counter
    counter+=1
  result