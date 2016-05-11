angular.module 'KingsCourt'

.controller 'CardModalInstanceCtrl', ($scope, $modalInstance, Kingdom) ->
  $scope.card = $scope.params.card
  $scope.kingdom = Kingdom.getOrCreate 'builder'

  $scope.ok = -> $modalInstance.close()