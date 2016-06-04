angular.module "KingsCourt"

.constant "API_SERVER", "http://127.0.0.1:5000/api/"
.constant "APP_CONFIG",
  "CARD_MIN_COST": 0
  "CARD_MAX_COST": 8
  "KINGDOM_SIZE": 10

.config (paginationTemplateProvider) ->
  paginationTemplateProvider.setPath "directives/dir_pagination.tpl.html"

.config ($httpProvider) ->
  $httpProvider.interceptors.push "AuthInterceptor", "LoadingInterceptor"

.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"
