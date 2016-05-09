angular.module('KingsCourt')
.controller 'MyFavoriteKingdomsCtrl', ($controller, $scope, $routeParams) ->
  $controller 'KingdomCtrl', $scope: $scope

  # TODO
  $scope.kingdom_params = username: 'ehehhehehe'
  $scope.subtitle = "Browsing #{$scope.username_faves}'s favorite kingdoms"