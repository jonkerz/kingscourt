angular.module 'KingsCourt'

.controller 'ModalCtrl', ($rootScope, $scope, $modal, $log) ->
  $scope.openLogin = ->
    modalInstance = $modal.open
      templateUrl: 'shared/_login_modal.html'
      controller: 'ModalInstanceCtrl'
      size: 'sm'

  $scope.openCard = (card) ->
    scope = $rootScope.$new()
    scope.params = card: card

    modalInstance = $modal.open
      templateUrl: 'shared/_card_modal.html'
      controller: 'CardModalInstanceCtrl'
      size: 'sm'
      scope: scope

  $scope.openBuilderCard = (card) ->
    scope = $rootScope.$new()
    scope.params = card: card

    modalInstance = $modal.open
      templateUrl: 'shared/_card_modal.html'
      controller: 'BuilderCardModalInstanceCtrl'
      size: 'sm'
      scope: scope
      animation: false
