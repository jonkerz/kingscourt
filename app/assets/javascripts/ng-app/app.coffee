# Bootstrap thing...
angular.element(document).ready ->
  initInjector = angular.injector ['ng']
  $http = initInjector.get '$http'

  $http.get("/api/get_cards/").then (response) ->
    KingsCourt.constant 'Cards', response.data
    angular.bootstrap document, ['KingsCourt']

KingsCourt = angular.module 'KingsCourt', [
  'templates'
  'ngResource'
  'ngRoute'
  'ngSanitize'
  'ngStorage'
  'angularUtils.directives.dirPagination'
  'checklist-model'
  'ng-token-auth'
  'bgf.paginateAnything'
  'ui.bootstrap'
]

KingsCourt.run ($location, $rootScope, $auth, ExpansionSelector) ->
  $rootScope.expansionSelector = ExpansionSelector
  $rootScope.getHeaders = -> $auth.retrieveData('auth_headers')

  $rootScope.$on '$routeChangeSuccess', (event, currentRoute, previousRoute) ->
    baseTitle = "King's Court - Dominion Kingdom Generator"
    if currentRoute.title?
      $rootScope.title = "#{currentRoute.title} | #{baseTitle}"
    else
      $rootScope.title = baseTitle

  $rootScope.loadingIsComplete = true
