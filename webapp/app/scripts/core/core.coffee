userService = require './userService.coffee'

module.exports = angular.module 'core', []
  .service 'UserService', userService
