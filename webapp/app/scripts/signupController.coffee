module.exports = ['$scope', '$http', 'userService', ($scope, $http, userService) ->
  $scope.user = {}

  $scope.submit = (user) ->
    userService.saveUser user

  $scope.isFormInvalid = ->
   false

  $scope.passwordsMatch = (user) ->
    user.password == user.confirmPassword

  $scope.validForm = (user, form) ->
    $scope.passwordsMatch(user) && form.$valid
]
