angular.module 'KingsCourt'

.controller 'CardModalInstanceCtrl', ($scope, $uibModalInstance, Kingdom) ->
  $scope.card = $scope.params.card
  $scope.kingdom = Kingdom.getOrCreate 'builder'

  $scope.ok = -> $uibModalInstance.close()