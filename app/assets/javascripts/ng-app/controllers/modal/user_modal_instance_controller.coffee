angular.module "KingsCourt"

.controller "UserModalInstanceCtrl", ($scope, $uibModalInstance, $auth) ->
  $scope.$on "auth:login-success", (event, mass) -> $uibModalInstance.close()

  $scope.ok = -> $uibModalInstance.close()

  $scope.cancel = -> $uibModalInstance.dismiss "cancel"

  $scope.submitLogin = (form) ->
    onError = (response) ->
      $scope.errors = response.errors.join(", ")

    $auth.submitLogin(form).then().catch onError

  $scope.submitRegistration = (form) ->
    onSuccess = (response) ->
      $auth.submitLogin
        email: form.email,
        password: form.password

    onError = (response) ->
      errors = response.data.errors
      $scope.errors = if errors.full_messages?
        errors.full_messages.join(", ")
      else
        errors.join(", ")

    $auth.submitRegistration(form).then(onSuccess).catch onError


  $scope.requestPasswordReset = (form) ->
    onSuccess = (response) -> $scope.notice = response.data.message

    onError = (response) ->
      $scope.errors = response.errors.join(", ")

    $auth.requestPasswordReset(form).then(onSuccess).catch onError

  $scope.updatePassword = (form) ->
    onSuccess = (response) -> $scope.notice = response.data.message

    onError = (response) ->
      errors = response.data.errors
      $scope.errors = if errors.full_messages?
        errors.full_messages.join(", ")
      else
        errors.join(", ")

    $auth.updatePassword(form).then(onSuccess).catch onError
