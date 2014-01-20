# Instantiate
ShowUp = angular.module('ShowUp', ["ngResource", "ngRoute", "AngularGM"])
(exports ? this).ShowUp = ShowUp


# Routes
ShowUp.config ($routeProvider) ->
  $routeProvider
  .when('/',
    templateUrl: "/assets/show_up/views/welcome.html"
    controller: "WelcomeCtrl"
  ).when( '/meetings',
    templateUrl: "/assets/show_up/views/meetings.html"
    controller: "MeetingsCtrl"
    resolve:
      loadData: ShowUp.meetingsCtrl.loadData
  ).otherwise(
    redirectTo: "/"
  )
  