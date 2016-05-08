angular.module('KingsCourt')
.controller 'MyKingdomsCtrl', ($scope, $controller, $auth) ->
  $controller 'KingdomCtrl',
    $scope: $scope

  # TODO
  $scope.kingdom_params = username: 'ehehhehehe'

  # TODO
  username = $auth.retrieveData("auth_headers").uid
  $scope.subtitle = "Browsing #{username}'s kingdoms"