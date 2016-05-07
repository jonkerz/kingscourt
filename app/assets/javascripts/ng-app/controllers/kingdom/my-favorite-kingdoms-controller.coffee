angular.module('KingsCourt')
.controller 'MyFavoriteKingdomsCtrl', ($controller, $scope, AuthService, $routeParams, ExpansionSelectorService) ->
  $scope.expansionSelectorService = ExpansionSelectorService

  $controller 'KingdomCtrl',
    $scope: $scope

  $scope.username_faves = AuthService.username
  $scope.subtitle = "Browsing #{$scope.username_faves}'s favorite kingdoms"
  $scope.pageChanged 1