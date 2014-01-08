ShowUp.controller "WelcomeCtrl", ($rootScope, $scope) ->
  # handle if the promise to teh router wasn't fulfilled
  $rootScope.$on "$routeChangeError", (event, current, previous, rejection) ->
    $scope.isError = true
    $scope.errorMsg = rejection