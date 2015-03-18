app = angular.module('saul', ['ngRoute', 'templates'])

app.config ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: 'main.html'
      controller: 'MainCtrl'
    .when "/call",
      templateUrl: 'saul.html'
      controller: 'SaulCtrl'
    .when "/wrong_number",
      templateUrl: 'walt.html'
      controller: 'WaltCtrl'
    .otherwise
      redirectTo: '/'
