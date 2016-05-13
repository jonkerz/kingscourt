angular.module 'KingsCourt'

.controller 'ModalInstanceCtrl', ($scope, $modalInstance, $auth) ->
  $scope.$on 'auth:login-success', (event, mass) -> $modalInstance.close()

  $scope.ok = -> $modalInstance.close()

  $scope.cancel = -> $modalInstance.dismiss 'cancel'

  $scope.login = (form) ->
    onError = (response) ->
      $scope.authErrors =
        "#{response.reason}: #{response.errors.join(", ")}"

    $auth.submitLogin(form).then().catch onError

  $scope.register = (form) ->
    onSuccess = (response) ->
      $auth.submitLogin
        email: form.email,
        password: form.password

    onError = (response) ->
      errors = response.data.errors
      $scope.authErrors = if errors.full_messages?
        errors.full_messages.join(", ")
      else
        errors.join(", ")

    $auth.submitRegistration(form).then(onSuccess).catch onError


  $scope.toggleLoginRegistration = ->
    $('#login-modal #login, #login-modal #register').toggle()
    return "coffee"