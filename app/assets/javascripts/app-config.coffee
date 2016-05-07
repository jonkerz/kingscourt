angular.module('Dominion')
.constant 'API_SERVER', 'http://127.0.0.1:5000/api/'
.constant 'API_KINGDOMS_PER_PAGE', 5

angular.module('Dominion')
.constant 'APP_CONFIG',
  'CARD_MIN_COST': 0
  'CARD_MAX_COST': 8
  'KINGDOM_SIZE': 10

.config (growlProvider) ->
  growlProvider.globalTimeToLive 2000
  growlProvider.globalDisableCountDown true
  growlProvider.globalDisableIcons true

# ui-bootstrap tooltip animation is broken using angular 1.3
# https://github.com/angular-ui/bootstrap/issues/2828#issuecomment-60379389
.config ($tooltipProvider) ->
  $tooltipProvider.options animation: false

.config (paginationTemplateProvider) ->
  paginationTemplateProvider.setPath 'directives/dir-pagination.tpl.html'

.config ($resourceProvider) ->
  $resourceProvider.defaults.stripTrailingSlashes = false

.config ($httpProvider) ->
  $httpProvider.interceptors.push 'AuthInterceptor', 'LoadingInterceptor'

.config ($locationProvider) ->
  $locationProvider.hashPrefix '!'

.config ($routeProvider) ->
  $routeProvider.when '/',
    title: 'Generator'
    templateUrl: 'builder/generator.html'

  .when '/builder',
    title: 'Builder'
    templateUrl: 'builder/builder.html'

  .when '/kingdoms/:id',
    title: 'Kingdoms'
    templateUrl: 'kingdom_browser/kingdom-detail.html'

  .when '/kingdoms/:id/:string',
    title: '###'
    templateUrl: 'kingdom_browser/kingdom-detail.html'

  .when '/cards',
    title: 'Browse Cards'
    templateUrl: 'card_browser/cards.html'

  .when '/kingdoms',
    title: 'Browse Kingdoms'
    templateUrl: 'kingdom_browser/kingdoms.html'
    reloadOnSearch: false
    controller: 'PublicKingdomsCtrl'

  .when '/my_kingdoms',
    title: 'My Kingdoms'
    templateUrl: 'kingdom_browser/kingdoms.html'
    reloadOnSearch: false
    controller: 'MyKingdomsCtrl'

  .when '/:username/kingdoms',
    title: 'User Kingdoms'
    templateUrl: 'kingdom_browser/kingdoms.html'
    reloadOnSearch: false
    controller: 'UserKingdomsCtrl'

  .when '/my_favorites',
    title: 'My Favorites'
    templateUrl: 'kingdom_browser/kingdoms.html'
    reloadOnSearch: false
    controller: 'MyFavoriteKingdomsCtrl'

  .when '/:username/favorites',
    title: 'User Favorites'
    templateUrl: 'kingdom_browser/kingdoms.html'
    reloadOnSearch: false
    controller: 'FavoriteKingdomsCtrl'

  .when '/kings_court',
    title: "King's Court"
    templateUrl: 'kings-court.html'

  .when '/import',
    title: 'Import'
    templateUrl: 'builder/import.html'

  .otherwise templateUrl: '404.html'