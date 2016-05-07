angular.module('KingsCourt')
.controller 'PublicKingdomsCtrl', ($scope, $controller) ->
  $controller 'KingdomCtrl',
    $scope: $scope

  $scope.subtitle = 'Browsing kingdoms'
  $scope.pageChanged 1