(function() {
  var app;

  app = angular.module('saul', ['ngRoute', 'templates']);

  app.config(function($routeProvider) {
    return $routeProvider.when('/', {
      templateUrl: 'main.html',
      controller: 'MainCtrl'
    }).when("/call", {
      templateUrl: 'saul.html',
      controller: 'SaulCtrl'
    }).when("/wrong_number", {
      templateUrl: 'walt.html',
      controller: 'WaltCtrl'
    }).otherwise({
      redirectTo: '/'
    });
  });

}).call(this);

(function() {
  angular.module('saul').controller("MainCtrl", ['$scope', function($scope) {}]).controller("SaulCtrl", ['$scope', function($scope) {}]).controller("WaltCtrl", ['$scope', function($scope) {}]);

}).call(this);
