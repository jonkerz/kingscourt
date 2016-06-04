angular.module "KingsCourt"

.config (paginationTemplateProvider) ->
  paginationTemplateProvider.setPath "directives/dir_pagination.tpl.html"

.config ($httpProvider) ->
  $httpProvider.interceptors.push "AuthInterceptor", "LoadingInterceptor"

.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"
