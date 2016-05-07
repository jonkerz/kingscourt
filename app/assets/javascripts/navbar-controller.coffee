angular.module('Dominion.Navbar', ['Dominion.Auth'])

.controller 'NavbarCtrl', ($scope, $location, AuthService) ->
  $scope.isActive = (viewLocation) -> viewLocation is $location.path()
  $scope.authService = AuthService