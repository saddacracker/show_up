# Instantiate
ShowUp = angular.module('ShowUp', ["ngResource", "ngRoute", "AngularGM"])
(exports ? this).ShowUp = ShowUp

# Routes
ShowUp.config ($routeProvider) ->
  $routeProvider
  .when('/',
    templateUrl: "/assets/show_up/views/welcome.html"
    controller: "WelcomeCtrl"
    # resolve:
      # this promise from ViewCtrl has to be resolved before loading
      # loadData: Raffler.potpourriCtrl.loadData 
  ).when( '/meetings',
    templateUrl: "/assets/show_up/views/meetings/index.html"
    controller: "MeetingsCtrl"
  ).otherwise(
    redirectTo: "/"
  )