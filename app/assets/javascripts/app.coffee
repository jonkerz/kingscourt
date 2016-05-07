# Bootstrap thing...
angular.element(document).ready ->
  initInjector = angular.injector ['ng']
  $http = initInjector.get '$http'
  API_SERVER = 'http://127.0.0.1:5000/api/'

  $http.get("#{API_SERVER}get_cards/").then (response) ->
    cards = response.data
    for card in cards
      card.image = (card.name).replace(RegExp(' ', 'g'), '_').replace(/'/g, '') + '.jpg'

    KingsCourt.constant 'Cards', cards
    angular.bootstrap document, ['KingsCourt']

KingsCourt = angular.module 'KingsCourt', [
  'templates'
  'ngResource'
  'ngRoute'
  'ngSanitize'
  'ngStorage'
  'angular-growl'
  'angularUtils.directives.dirPagination'
  'checklist-model'
  'ui.bootstrap'
]

KingsCourt.run ($location, $rootScope) ->
  $rootScope.$on '$routeChangeSuccess', (event, currentRoute, previousRoute) ->
    baseTitle = "King's Court - Dominion Kingdom Generator"
    if currentRoute.title?
      $rootScope.title = "#{currentRoute.title} | #{baseTitle}"
    else
      $rootScope.title = baseTitle

  $rootScope.loadingIsComplete = true
