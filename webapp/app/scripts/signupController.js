'use strict';

module.exports = function($scope, $http) {
  $scope.user = {};

  $scope.submit = function(user) {
    $http.post('/adduser', {user : user});
  };

  $scope.isFormInvalid = function() {
    return true;
  };

  $scope.passwordsMatch = function(user) {
    return user.password === user.confirmPassword; 
  };

  $scope.validForm = function(user, form) {
    return $scope.passwordsMatch(user) && form.$valid;
  };
};
