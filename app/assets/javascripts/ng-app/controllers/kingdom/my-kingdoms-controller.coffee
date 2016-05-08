angular.module('KingsCourt')
.controller 'MyKingdomsCtrl', ($scope, $controller) ->
  $controller 'KingdomCtrl',
    $scope: $scope

  $scope.kingdom_params = my_kingdoms: true
  $scope.subtitle = "Browsing my kingdoms"