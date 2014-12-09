sha512 = require 'sha512'

module.exports = ['$http', ($http) ->

  getHash = (string) ->
    sha512(string).toString 'hex'
  
  getUserObject = (user) ->
    firstname: user.firstname
    lastname: user.lastname
    password: getHash user.password

  this.saveUser = (user) ->
    $http.post '/adduser', user: getUserObject user
  
  this
]
