angular.module 'KingsCourt'

.controller 'ModalInstanceCtrl', ($scope, $modalInstance, $auth) ->
  $scope.$on 'auth:login-success', (event, mass) -> $modalInstance.close()

  $scope.ok = -> $modalInstance.close()

  $scope.cancel = -> $modalInstance.dismiss 'cancel'

  $scope.login = (form) ->
    $auth.submitLogin(form).then((resp) ->
      # OK
    ).catch (resp) ->
      $scope.authErrors = "#{resp.reason}: #{resp.errors.join(", ")}"

  $scope.register = (form) ->
    $auth.submitRegistration(form).then((resp) ->
      $auth.submitLogin
        email: form.email,
        password: form.password
    ).catch (resp) ->
      errors = resp.data.errors
      $scope.authErrors = if errors.full_messages?
        errors.full_messages.join(", ")
      else
        errors.join(", ")

  $scope.toggleLoginRegistration = ->
    $('#login-modal #login, #login-modal #register').toggle()
    return "coffee"