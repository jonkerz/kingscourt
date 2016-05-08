angular.module('KingsCourt')
.controller 'UserKingdomsCtrl', ($controller, $scope, $routeParams, ExpansionSelectorService) ->
  $scope.expansionSelectorService = ExpansionSelectorService
  $controller 'KingdomCtrl',
    $scope: $scope

  $scope.username = $routeParams.username

  $scope.kingdom_params =
    username: $scope.username

  $scope.subtitle = "Browsing #{$scope.username}'s kingdoms"