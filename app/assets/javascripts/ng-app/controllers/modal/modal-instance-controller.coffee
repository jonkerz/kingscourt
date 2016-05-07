angular.module('KingsCourt')
.controller 'ModalInstanceCtrl', ($scope, $modalInstance) ->
  $scope.$on 'loggedIn', (event, mass) -> $modalInstance.close()

  $scope.ok = -> $modalInstance.close()

  $scope.cancel = -> $modalInstance.dismiss 'cancel'