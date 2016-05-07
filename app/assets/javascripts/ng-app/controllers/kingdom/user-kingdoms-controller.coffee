angular.module('KingsCourt')
.controller 'UserKingdomsCtrl', ($controller, $scope, $routeParams, ExpansionSelectorService) ->
  $scope.expansionSelectorService = ExpansionSelectorService
  $controller 'KingdomCtrl',
    $scope: $scope

  $scope.username = $routeParams.username
  $scope.subtitle = "Browsing #{$scope.username}'s kingdoms"
  $scope.pageChanged 1