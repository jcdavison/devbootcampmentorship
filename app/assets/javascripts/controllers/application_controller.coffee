controller = ($scope) ->
  $scope.showJohn = false

  $scope.commitToMentor = (user) ->
    console.log user

controller.$inject = ['$scope']
@app.controller 'applicationController', controller
