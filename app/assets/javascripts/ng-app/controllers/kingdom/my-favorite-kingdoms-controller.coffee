angular.module('KingsCourt')
.controller 'MyFavoriteKingdomsCtrl', ($controller, $scope, AuthService, $routeParams, ExpansionSelectorService) ->
  $scope.expansionSelectorService = ExpansionSelectorService

  $controller 'KingdomCtrl',
    $scope: $scope

  # TODO
  $scope.kingdom_params = username: 'ehehhehehe'
  $scope.subtitle = "Browsing #{$scope.username_faves}'s favorite kingdoms"