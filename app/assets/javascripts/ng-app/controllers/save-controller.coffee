angular.module('KingsCourt')
.controller 'SaveCtrl', ($scope, AlertsService, APIService, AuthService) ->
  $scope.authService = AuthService
  $scope.editingKingdom = !!$scope.kingdom.id? if $scope.kingdom

  $scope.save = ->
    data =
      name: $scope.kingdom.name
      cards: $scope.kingdom.getAllCardIds()
      kingdom_description: $scope.kingdom.description

    console.log "in save, data:", data

    APIService.kingdoms.save data, (data) ->
      AlertsService.addAlert "Saved <a href=\"#!/kingdoms/#{data.id}/#{data.slug}/\">#{data.name}</a>.", 'success'

  $scope.update = ->
    kingdom = $scope.kingdom

    data =
      name: kingdom.name
      cards: kingdom.getAllCardIds()
      kingdom_description: kingdom.description

    APIService.kingdoms.update { id: kingdom.id }, data, (data) ->
      console.log 'patched', data