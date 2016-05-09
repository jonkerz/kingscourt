angular.module('KingsCourt')
.controller 'BuilderCardModalInstanceCtrl', ($scope, $modalInstance, Kingdom) ->
  $scope.card = $scope.params.card
  $scope.kingdom = Kingdom.getOrCreate 'builder'

  cardId = $scope.card.id
  $scope.isBanned = $scope.kingdom.idIsBanned cardId
  $scope.isAdded = $scope.kingdom.idIsAdded cardId

  $scope.ok = -> $modalInstance.close()