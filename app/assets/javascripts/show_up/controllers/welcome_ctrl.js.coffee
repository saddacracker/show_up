ShowUp.controller "WelcomeCtrl", ($rootScope, $scope, $location, $http, AddressService) ->
  
  $scope.selected = undefined
  
  $scope.addressService = AddressService
  
  $scope.setAddress = () ->
    $location.path('/meetings').search('search=' + $scope.addressService.address)
    
  $scope.getLocation = (val) ->
    $http.get("http://maps.googleapis.com/maps/api/geocode/json",
      params:
        address: val
        sensor: false
    ).then (res) ->
      addresses = []
      angular.forEach res.data.results, (item) ->
        addresses.push item.formatted_address

      addresses
  
  # handle if the promise to teh router wasn't fulfilled
  $rootScope.$on "$routeChangeError", (event, current, previous, rejection) ->
    $scope.isError = true
    $scope.errorMsg = rejection
    
    
    
    
