angular.module 'KingsCourt'

.factory 'AuthInterceptor', ($rootScope, $q, Alerts) ->
  request: (config) ->
    config.headers = config.headers or {}
    _.assign config.headers, $rootScope.getHeaders()
    return config

  responseError: (response) ->
    if response.status is 404
      console.log 'AuthInterceptor: cannot connect...'
    #Alerts.addAlert "responseError " + response.status + ": " + response.statusText, "danger"
    return $q.reject response