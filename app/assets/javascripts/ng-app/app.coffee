# Bootstraping the app like this because all screens depend on the JSON cards.
angular.element(document).ready ->
  initInjector = angular.injector ["ng"]
  $http = initInjector.get "$http"

  $http.get("/api/v1/cards?randomizable=true").then (response) ->
    KingsCourt.constant "Cards", response.data
    angular.bootstrap document, ["KingsCourt"]

KingsCourt = angular.module "KingsCourt", [
  "templates"
  "ngResource"
  "ngRoute"
  "ngSanitize"
  "ngStorage"
  "angularUtils.directives.dirPagination"
  "checklist-model"
  "ng-token-auth"
  "ui.bootstrap"
  "angularLazyImg"
  "mwl.confirm"
  "angularUtils.directives.dirDisqus"
]

KingsCourt.run ($location, $rootScope, $auth, ExpansionSelector) ->
  $rootScope.expansionSelector = ExpansionSelector
  $rootScope.getAuthHeaders = -> $auth.retrieveData("auth_headers")

  $rootScope.$on "$routeChangeSuccess", (event, currentRoute, previousRoute) ->
    baseTitle = "King's Court - Dominion Kingdom Generator"
    if currentRoute.title?
      $rootScope.title = "#{currentRoute.title} | #{baseTitle}"
    else
      $rootScope.title = baseTitle

  $rootScope.loadingIsComplete = true
