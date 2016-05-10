angular.module('KingsCourt')
.config ($routeProvider) ->
  $routeProvider.when '/',
    title: 'Generator'
    templateUrl: 'generator/generator.html'

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
    templateUrl: 'importer/import.html'

  .otherwise templateUrl: '404.html'
