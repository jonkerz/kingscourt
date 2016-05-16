angular.module 'KingsCourt'

.controller 'BuilderCardModalInstanceCtrl', ($scope, $uibModalInstance, Kingdom) ->
  $scope.card = $scope.params.card
  $scope.kingdom = Kingdom.getOrCreate 'builder'

  cardId = $scope.card.id
  $scope.isAdded = $scope.kingdom.idIsAdded cardId

  $scope.ok = -> $uibModalInstance.close()