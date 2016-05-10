angular.module('KingsCourt')
.config ($routeProvider) ->
  $routeProvider.when '/',
    title: 'Generator'
    templateUrl: 'generator/index.html'

  .when '/builder',
    title: 'Builder'
    templateUrl: 'builder/builder.html'

  .when '/kingdoms/:id',
    title: 'Kingdoms'
    templateUrl: 'kingdoms/show.html'

  .when '/kingdoms/:id/:string',
    title: '###'
    templateUrl: 'kingdoms/show.html'

  .when '/cards',
    title: 'Browse Cards'
    templateUrl: 'card_browser/cards.html'

  .when '/kingdoms',
    title: 'Browse Kingdoms'
    templateUrl: 'kingdoms/index.html'
    reloadOnSearch: false
    controller: 'PublicKingdomsCtrl'

  .when '/my_kingdoms',
    title: 'My Kingdoms'
    templateUrl: 'kingdoms/index.html'
    reloadOnSearch: false
    controller: 'MyKingdomsCtrl'

  .when '/:username/kingdoms',
    title: 'User Kingdoms'
    templateUrl: 'kingdoms/index.html'
    reloadOnSearch: false
    controller: 'UserKingdomsCtrl'

  .when '/my_favorites',
    title: 'My Favorites'
    templateUrl: 'kingdoms/index.html'
    reloadOnSearch: false
    controller: 'MyFavoriteKingdomsCtrl'

  .when '/:username/favorites',
    title: 'User Favorites'
    templateUrl: 'kingdoms/index.html'
    reloadOnSearch: false
    controller: 'FavoriteKingdomsCtrl'

  .when '/kings_court',
    title: "King's Court"
    templateUrl: 'kings-court.html'

  .when '/import',
    title: 'Import'
    templateUrl: 'importer/index.html'

  .otherwise templateUrl: '404.html'
