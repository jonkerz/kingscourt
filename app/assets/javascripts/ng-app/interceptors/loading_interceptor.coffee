angular.module "KingsCourt"

.factory "LoadingInterceptor", ($q, $timeout) ->
  request: (config) ->
    angular.element(".loading-spinner").show()
    angular.element(".three-bars").hide()
    config

  response: (response) ->
    $timeout ->
      angular.element(".loading-spinner").hide()
      angular.element(".three-bars").show()
    , 250
    response

  responseError: (response) ->
    angular.element(".loading-spinner").hide()
    angular.element(".three-bars").show()
    $q.reject response
