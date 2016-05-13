angular.module 'KingsCourt'

.controller 'SaveCtrl', ($scope, Alerts, API) ->
  $scope.editingKingdom = !!$scope.kingdom.id? if $scope.kingdom

  $scope.save = ->
    kingdom = $scope.kingdom
    data =
      name: kingdom.name
      card_ids: kingdom.getAllCardIds()
      description: kingdom.description

    onSuccess = (response, _header) ->
      kingdom = response.kingdom
      url = "#!/kingdoms/#{kingdom.id}/#{kingdom.slug}"
      Alerts.addAlert """Successfully saved \
        <a href="#{url}">#{kingdom.name}</a>."""

    onError = (response) ->
      Alerts.addAlert response.data.errors

    API.kingdoms.save data, onSuccess, onError

  $scope.update = ->
    kingdom = $scope.kingdom
    data =
      name: kingdom.name
      card_ids: kingdom.getAllCardIds()
      description: kingdom.description

    API.kingdoms.update { id: kingdom.id }, data, (data) ->
      console.log 'patched', data