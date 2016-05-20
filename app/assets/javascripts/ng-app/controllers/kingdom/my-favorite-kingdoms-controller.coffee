angular.module 'KingsCourt'

.controller 'MyFavoriteKingdomsCtrl', ($controller, $scope) ->
  $controller 'KingdomCtrl', $scope: $scope

  $scope.kingdomsUrl += '&my_favorites=true'
  $scope.subtitle = "Browsing my favorite kingdoms"