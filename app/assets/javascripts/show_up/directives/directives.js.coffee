# show error in ui
ShowUp.directive "error", ($rootScope) ->
  restrict: "E"
  template: '<div class="alert-box alert" ng-show="isError">{{errorMsg}}</div>'