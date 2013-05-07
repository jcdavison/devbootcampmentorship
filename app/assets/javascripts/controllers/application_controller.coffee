controller = ($scope) ->
  $scope.showJohn = false

  $scope.toggleCheckbox = ->
    if $scope.showJohn
      $scope.showJohn = false
    else
      $scope.showJohn = true

  $scope.hiJohn = ->
    $scope.showJohn

controller.$inject = ['$scope']
@app.controller 'applicationController', controller
