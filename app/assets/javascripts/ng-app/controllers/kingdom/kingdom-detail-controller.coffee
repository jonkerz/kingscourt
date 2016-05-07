angular.module('KingsCourt')
.controller 'KingdomDetailCtrl', ($rootScope, $scope, $location, $routeParams, AlertsService, AuthService, KingdomService, APIService) ->
  id = $routeParams.id

  $scope.authService = AuthService

  APIService.kingdoms.get id: id, (data) ->
      $rootScope.title = $rootScope.title.replace '###', data.name
      kingdom = data
      $scope.kingdom = KingdomService.getOrCreate 'detail'

      $scope.kingdom.id = kingdom.id
      $scope.kingdom.name = kingdom.name
      $scope.kingdom.cards = kingdom.cards
      $scope.kingdom.description = kingdom.description
      $scope.kingdom.username = kingdom.username
      $scope.kingdom.created = kingdom.created

      $scope.contentLoaded = true

  $scope.deleteKingdom = (id) ->
    APIService.kingdoms.delete id: id, (data) ->
      AlertsService.addAlert "Deleted \"#{$scope.kingdom.name}\".", 'danger'
      $location.path 'my_kingdoms'

  $scope.openInBuilder = ->
    builderKingdom = KingdomService.getOrCreate 'builder'

    builderKingdom.id = $scope.kingdom.id
    builderKingdom.name = $scope.kingdom.name
    builderKingdom.cards = $scope.kingdom.cards
    builderKingdom.description = $scope.kingdom.description
    builderKingdom.public = $scope.kingdom.public

    $location.path 'builder'