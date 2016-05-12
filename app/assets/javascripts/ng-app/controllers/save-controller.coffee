angular.module 'KingsCourt'

.controller 'SaveCtrl', ($scope, Alerts, API) ->
  $scope.editingKingdom = !!$scope.kingdom.id? if $scope.kingdom

  $scope.save = ->
    kingdom = $scope.kingdom
    data =
      name: kingdom.name
      card_ids: kingdom.getAllCardIds()
      description: kingdom.description

    API.kingdoms.save data, (data) ->
      kingdom = data.kingdom
      url = "#!/kingdoms/#{kingdom.id}/#{kingdom.slug}"
      Alerts.addAlert """Successfully saved \
        <a href="#{url}">#{kingdom.name}</a>."""

  $scope.update = ->
    kingdom = $scope.kingdom
    data =
      name: kingdom.name
      card_ids: kingdom.getAllCardIds()
      description: kingdom.description

    API.kingdoms.update { id: kingdom.id }, data, (data) ->
      console.log 'patched', data