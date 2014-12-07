'use strict';

require('angular');
require('angular-ui-router');

var app = angular.module('myApp', ['ui.router', require('./signup.js').name]);

app.controller('WelcomeCtrl', function($scope) {
  $scope.test = 'world';
});  

app.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider.state('home', {
    url: '/home',
    templateUrl: 'views/home.html'
  });

  $stateProvider.state('signup', {
    url: '/signup',
    templateUrl: 'views/signup.html',
    controller: 'SignupController'
  });

});
