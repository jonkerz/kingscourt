angular.module('KingsCourt')
.controller 'MyKingdomsCtrl', ($scope, $controller, AuthService) ->
  $controller 'KingdomCtrl',
    $scope: $scope

  $scope.username = AuthService.username
  $scope.subtitle = "Browsing #{$scope.username}'s kingdoms"
  $scope.pageChanged 1