angular.module('KingsCourt')
.controller 'UserKingdomsCtrl', ($controller, $scope, $routeParams) ->
  $controller 'KingdomCtrl', $scope: $scope

  username = $routeParams.username
  $scope.kingdomsUrl += "&username=#{username}"
  $scope.subtitle = "Browsing #{username}'s kingdoms"