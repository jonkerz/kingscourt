angular.module('KingsCourt')
.controller 'AuthCtrl', ($scope, AuthService) ->
  $scope.register = ->
    username = $scope.registerUsername
    password = $scope.registerPassword
    if username and password
      AuthService.register(username, password).then (->
      ), (error) -> $scope.registerError = error
    else
      $scope.registerError = 'Username and password required'

  $scope.login = ->
    console.log "loggin in from controll"
    username = $scope.loginUsername
    password = $scope.loginPassword
    if username and password
      console.log "has uname an p"
      AuthService.login(username, password).then ((data) ->
        console.log "auth success"
        'coffee??'
      ), (error) ->
        console.log "authfail"
        $scope.loginError = error
    else
      console.log "failed"
      $scope.loginError = 'Username and password required'

  $scope.logout = -> AuthService.logout()