userService = require './userService.coffee'

coreModule = angular.module 'core', []
coreModule.service 'userService', userService
 
module.exports = coreModule
