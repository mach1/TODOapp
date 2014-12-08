module.exports = ['$scope', '$http', ($scope, $http) ->
  $scope.user = {}

  $scope.submit = (user) ->
    console.log(user)
    $http.post '/adduser', user: user

  $scope.isFormInvalid = ->
   false

  $scope.passwordsMatch = (user) ->
    user.password == user.confirmPassword

  $scope.validForm = (user, form) ->
    $scope.passwordsMatch(user) && form.$valid
]
