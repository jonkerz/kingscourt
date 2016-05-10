angular.module('KingsCourt')
.controller 'ModalCtrl', ($rootScope, $scope, $modal, $log) ->
  $scope.openLogin = ->
    modalInstance = $modal.open
      templateUrl: 'shared/login-modal.html'
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
