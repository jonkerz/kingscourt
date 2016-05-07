angular.module('Dominion.Common')
.controller 'ModalCtrl', ($rootScope, $scope, $modal, $log) ->
  $scope.openLogin = ->
    modalInstance = $modal.open
      templateUrl: 'auth/login-modal.html'
      controller: 'ModalInstanceCtrl'
      size: 'sm'

  $scope.openCard = (card) ->
    scope = $rootScope.$new()
    scope.params = card: card

    modalInstance = $modal.open
      templateUrl: 'card-modal.html'
      controller: 'CardModalInstanceCtrl'
      size: 'sm'
      scope: scope

  $scope.openBuilderCard = (card) ->
    scope = $rootScope.$new()
    scope.params = card: card

    modalInstance = $modal.open
      templateUrl: 'card-modal.html'
      controller: 'BuilderCardModalInstanceCtrl'
      size: 'sm'
      scope: scope
      animation: false

.controller 'ModalInstanceCtrl', ($scope, $modalInstance) ->
  $scope.$on 'loggedIn', (event, mass) -> $modalInstance.close()

  $scope.ok = -> $modalInstance.close()

  $scope.cancel = -> $modalInstance.dismiss 'cancel'

.controller 'CardModalInstanceCtrl', ($scope, $modalInstance, KingdomService) ->
  $scope.card = $scope.params.card
  $scope.kingdom = KingdomService.getOrCreate 'builder'

  $scope.ok = -> $modalInstance.close()

.controller 'BuilderCardModalInstanceCtrl', ($scope, $modalInstance, KingdomService) ->
  $scope.card = $scope.params.card
  $scope.kingdom = KingdomService.getOrCreate 'builder'

  cardId = $scope.card.id
  $scope.isBanned = $scope.kingdom.idIsBanned cardId
  $scope.isAdded = $scope.kingdom.idIsAdded cardId

  $scope.ok = -> $modalInstance.close()