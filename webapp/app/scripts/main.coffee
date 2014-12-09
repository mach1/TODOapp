require 'angular'
require 'angular-ui-router'

coreModule = require './core/core.coffee'
signupModule = require './signup.coffee'
app = angular.module 'myApp', ['ui.router', coreModule.name, signupModule.name]

app.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider.state 'home',
    url: '/home'
    templateUrl: 'views/home.html'

  $stateProvider.state 'signup',
    url: '/signup'
    templateUrl: 'views/signup.html'
    controller: 'SignupController'
