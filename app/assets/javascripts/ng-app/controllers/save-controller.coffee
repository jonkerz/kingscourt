angular.module('KingsCourt')
.controller 'SaveCtrl', ($scope, Alerts, API) ->
  $scope.editingKingdom = !!$scope.kingdom.id? if $scope.kingdom

  $scope.save = ->
    kingdom = $scope.kingdom
    data =
      name: kingdom.name
      card_ids: kingdom.getAllCardIds()
      description: kingdom.description

    API.kingdoms.save data, (data) ->
      Alerts.addAlert "Saved <a href=\"#!/kingdoms/#{data.id}/#{data.slug}/\">#{data.name}</a>.", 'success'

  $scope.update = ->
    kingdom = $scope.kingdom
    data =
      name: kingdom.name
      card_ids: kingdom.getAllCardIds()
      description: kingdom.description

    API.kingdoms.update { id: kingdom.id }, data, (data) ->
      console.log 'patched', data