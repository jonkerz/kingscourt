angular.module('KingsCourt')
.controller 'PublicKingdomsCtrl', ($scope, $controller, CardService) ->
  $controller 'KingdomCtrl',
    $scope: $scope

  $scope.subtitle = 'Browsing kingdoms'