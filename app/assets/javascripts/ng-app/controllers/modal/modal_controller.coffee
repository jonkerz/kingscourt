angular.module "KingsCourt"

.controller "ModalCtrl", ($rootScope, $scope, $uibModal) ->
  $scope.openLogin = ->
    modalInstance = $uibModal.open
      templateUrl: "shared/_login_modal.html"
      controller: "UserModalInstanceCtrl"
      size: "sm"

  $scope.openUpdatePassword = ->
    modalInstance = $uibModal.open
      templateUrl: "shared/_change_password_modal.html"
      controller: "UserModalInstanceCtrl"
      size: "sm"

  $scope.openCard = (card) ->
    scope = $rootScope.$new()
    scope.params = card: card

    modalInstance = $uibModal.open
      templateUrl: "shared/_card_modal.html"
      controller: "CardModalInstanceCtrl"
      size: "sm"
      scope: scope
      animation: false
