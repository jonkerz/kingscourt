angular.module "KingsCourt"

.factory "AuthInterceptor", ($rootScope, $q, Alerts) ->
  request: (config) ->
    config.headers = config.headers or {}
    _.assign config.headers, $rootScope.getAuthHeaders()
    config

  responseError: (response) ->
    if response.status is 404
      console.log "AuthInterceptor: cannot connect..."
    Alerts.add "responseError #{response.status}: #{response.statusText}"
    $q.reject response
