angular.module('KingsCourt')
.controller 'AlertsCtrl', ($scope, AlertsService) ->
  $scope.alertsService = AlertsService