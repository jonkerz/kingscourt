angular.module('KingsCourt')
.controller 'FavoriteKingdomsCtrl', ($controller, $scope, $routeParams) ->
  $controller 'KingdomCtrl', $scope: $scope

  # TODO
  $scope.username_faves = $routeParams.username
  $scope.subtitle = "Browsing #{$scope.username_faves}'s favorite kingdoms"