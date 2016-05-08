angular.module('KingsCourt')
.controller 'ModalInstanceCtrl', ($scope, $modalInstance) ->
  $scope.$on 'auth:login-success', (event, mass) -> $modalInstance.close()

  $scope.ok = -> $modalInstance.close()

  $scope.cancel = -> $modalInstance.dismiss 'cancel'