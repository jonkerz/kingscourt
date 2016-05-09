angular.module('KingsCourt')
.controller 'SaveCtrl', ($scope, AlertsService, APIService) ->
  $scope.editingKingdom = !!$scope.kingdom.id? if $scope.kingdom

  $scope.save = ->
    data =
      name: $scope.kingdom.name
      #card_ids: $scope.kingdom.getAllCardIds() # TODO
      card_ids: [1,2,3]
      description: $scope.kingdom.description

    APIService.kingdoms.save data, (data) ->
      AlertsService.addAlert "Saved <a href=\"#!/kingdoms/#{data.id}/#{data.slug}/\">#{data.name}</a>.", 'success'

  $scope.update = ->
    kingdom = $scope.kingdom

    data =
      name: kingdom.name
      #card_ids: kingdom.getAllCardIds() # TODO
      card_ids: [1,2,3]
      description: kingdom.description

    APIService.kingdoms.update { id: kingdom.id }, data, (data) ->
      console.log 'patched', data