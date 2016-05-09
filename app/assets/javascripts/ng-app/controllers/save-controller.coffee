angular.module('KingsCourt')
.controller 'SaveCtrl', ($scope, Alerts, API) ->
  $scope.editingKingdom = !!$scope.kingdom.id? if $scope.kingdom

  $scope.save = ->
    data =
      name: $scope.kingdom.name
      #card_ids: $scope.kingdom.getAllCardIds() # TODO
      card_ids: [1,2,3]
      description: $scope.kingdom.description

    API.kingdoms.save data, (data) ->
      Alerts.addAlert "Saved <a href=\"#!/kingdoms/#{data.id}/#{data.slug}/\">#{data.name}</a>.", 'success'

  $scope.update = ->
    kingdom = $scope.kingdom

    data =
      name: kingdom.name
      #card_ids: kingdom.getAllCardIds() # TODO
      card_ids: [1,2,3]
      description: kingdom.description

    API.kingdoms.update { id: kingdom.id }, data, (data) ->
      console.log 'patched', data