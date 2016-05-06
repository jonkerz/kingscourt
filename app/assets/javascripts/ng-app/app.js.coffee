angular.module('KingsCourt', [
  'ngRoute'
  'templates'
]).config ($locationProvider) ->
  $locationProvider.hashPrefix '!'
.config ($routeProvider, $locationProvider) ->
  $routeProvider
    .when '/',
      templateUrl: 'generator.html'
      controller: 'GeneratorCtrl'
    .when '/cards',
      templateUrl: 'cards.html'
      controller: 'GeneratorCtrl'
