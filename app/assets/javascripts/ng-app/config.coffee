angular.module('KingsCourt')
.constant 'API_SERVER', 'http://127.0.0.1:5000/api/'
.constant 'API_KINGDOMS_PER_PAGE', 5
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