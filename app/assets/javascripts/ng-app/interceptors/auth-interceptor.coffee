angular.module('KingsCourt')
.factory 'AuthInterceptor', ($rootScope, $q, AlertsService) ->
  request: (config) ->
    config.headers = config.headers or {}
    headers = $rootScope.getHeaders()
    config.headers = headers if headers
    return config

  responseError: (response) ->
    if response.status is 404
      console.log 'AuthInterceptor: cannot connect...'
    #AlertsService.addAlert "responseError " + response.status + ": " + response.statusText, "danger"
    return $q.reject response