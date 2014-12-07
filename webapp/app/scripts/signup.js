"use strict";

var signupController = require('./signupController.js');
module.exports = angular.module('signup', [])
  .controller('SignupController', signupController);

