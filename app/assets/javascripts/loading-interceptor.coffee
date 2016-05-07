angular.module('Dominion')
.factory 'LoadingInterceptor', ($q, $timeout) ->
  request: (config) ->
    angular.element('.loading-spinner').show()
    angular.element('.three-bars').hide()
    return config

  response: (response) ->
    $timeout ->
      angular.element('.loading-spinner').hide()
      angular.element('.three-bars').show()
    , 250
    return response

  responseError: (response) ->
    angular.element('.loading-spinner').hide()
    angular.element('.three-bars').show()
    return $q.reject response