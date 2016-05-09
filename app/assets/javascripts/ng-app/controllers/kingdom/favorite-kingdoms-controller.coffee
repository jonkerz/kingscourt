angular.module('KingsCourt')
.controller 'FavoriteKingdomsCtrl', ($controller, $scope, $routeParams) ->
  $controller 'KingdomCtrl', $scope: $scope

  favoriter = $routeParams.username
  $scope.kingdomsUrl += "&favoriter=#{favoriter}"
  $scope.subtitle = "Browsing #{favoriter}'s favorite kingdoms"