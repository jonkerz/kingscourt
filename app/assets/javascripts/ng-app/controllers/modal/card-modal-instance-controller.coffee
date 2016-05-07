angular.module('KingsCourt')
.controller 'CardModalInstanceCtrl', ($scope, $modalInstance, KingdomService) ->
  $scope.card = $scope.params.card
  $scope.kingdom = KingdomService.getOrCreate 'builder'

  $scope.ok = -> $modalInstance.close()