angular.module('Dominion')

.controller 'NavbarCtrl', ($scope, $location, AuthService) ->
  $scope.isActive = (viewLocation) -> viewLocation is $location.path()
  $scope.authService = AuthService