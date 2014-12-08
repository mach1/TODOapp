module.exports = ['$http', ($http) ->
  this.saveUser = (user) ->
    console.log 'saveUser', user
    $http.post '/adduser', user: user
]
