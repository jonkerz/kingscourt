angular.module('Dominion.Interceptors')
.factory 'AuthInterceptor', ($rootScope, $q, $localStorage, $location, AlertsService) ->
  request: (config) ->
    config.headers = config.headers or {}
    if $localStorage.token
      config.headers.Authorization = 'Token ' + $localStorage.token
    return config

  responseError: (response) ->
    if response.status is 404
      console.log 'AuthInterceptor: cannot connect...'
    #AlertsService.addAlert "responseError " + response.status + ": " + response.statusText, "danger"
    return $q.reject response