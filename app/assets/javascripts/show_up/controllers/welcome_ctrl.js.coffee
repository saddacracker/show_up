ShowUp.controller "WelcomeCtrl", ($rootScope, $scope, $location, AddressService) ->
  
  $scope.addressService = AddressService
  
  $scope.setAddress = () ->
    $location.path('/meetings').search('search=' + $scope.addressService.address)
  
  # handle if the promise to teh router wasn't fulfilled
  $rootScope.$on "$routeChangeError", (event, current, previous, rejection) ->
    $scope.isError = true
    $scope.errorMsg = rejection
    
    
    
    
