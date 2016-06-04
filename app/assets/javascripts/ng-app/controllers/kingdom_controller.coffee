angular.module "KingsCourt"

.controller "KingdomCtrl", ($rootScope, $scope, $location, $routeParams, Alerts, Kingdom, API) ->
  id = $routeParams.id

  API.kingdoms.get id: id, (data) ->
    $rootScope.title = $rootScope.title.replace "###", data.name
    kingdom = data
    $scope.kingdom = Kingdom.getOrCreate "detail"

    $scope.kingdom.id = kingdom.id
    $scope.kingdom.name = kingdom.name
    $scope.kingdom.cards = kingdom.cards
    $scope.kingdom.description = kingdom.description
    $scope.kingdom.username = kingdom.username
    $scope.kingdom.created_at = kingdom.created_at

    $scope.contentLoaded = true

  $scope.deleteKingdom = (id) ->
    API.kingdoms.delete id: id, (data) ->
      Alerts.add "Successfully deleted #{$scope.kingdom.name}."
      $location.path "my_kingdoms"

  $scope.openInBuilder = ->
    builderKingdom = Kingdom.getOrCreate "builder"

    builderKingdom.id = $scope.kingdom.id
    builderKingdom.name = $scope.kingdom.name
    builderKingdom.cards = $scope.kingdom.cards
    builderKingdom.description = $scope.kingdom.description

    $location.path "builder"
