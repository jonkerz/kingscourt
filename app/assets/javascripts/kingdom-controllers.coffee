angular.module('Dominion.KingdomBrowser', ['angularUtils.directives.dirPagination', 'Dominion.Auth', 'Dominion.Alerts', 'Dominion.API', 'Dominion.ExpansionSelector'])
.controller 'KingdomCtrl', ($scope, AuthService, AlertsService, APIService, API_KINGDOMS_PER_PAGE, ExpansionSelectorService) ->
  $scope.authService = AuthService
  $scope.expansionSelectorService = ExpansionSelectorService
  $scope.username = null
  $scope.username_faves = null
  $scope.kingdoms = []
  $scope.totalKingdoms = 'not set'
  $scope.totalKingdomsAll = 0
  $scope.kingdomsPerPage = API_KINGDOMS_PER_PAGE
  $scope.displayMode = 'images'
  $scope.pagination = current: 1

  getResultsPage = (pageNumber) ->
    params =
      page: pageNumber
      username: $scope.username
      username_faves: $scope.username_faves
      expansions: ExpansionSelectorService.unselectedExpansions().join '_'

    APIService.kingdoms.query params, (data) ->
      kingdoms = data.results
      favoriteKingdoms = AuthService.favoriteKingdoms

      for kingdom in kingdoms
        kingdom.favorite = _.contains favoriteKingdoms, kingdom.id

      $scope.kingdoms = kingdoms
      $scope.totalKingdoms = data.count
      $scope.totalKingdomsAll = data.count_all

  $scope.pageChanged = (newPage) -> getResultsPage newPage

  $scope.toggleFavorite = (kingdom) ->
    return if $scope.isSaving

    $scope.isSaving = true
    $scope.savingKingdomId = kingdom.id

    if kingdom.favorite
      APIService.favorites.delete { id: kingdom.id }, (data) ->
        AuthService.removeFromFavoriteKingdomsList kingdom.id
        kingdom.favorites_count--
        kingdom.favorite = not kingdom.favorite
        $scope.isSaving = false
    else
      APIService.favorites.save { id: kingdom.id }, (data) ->
        AuthService.addToFavoriteKingdomsList kingdom.id
        kingdom.favorites_count++
        kingdom.favorite = not kingdom.favorite
        $scope.isSaving = false

.controller 'PublicKingdomsCtrl', ($scope, $controller) ->
  $controller 'KingdomCtrl',
    $scope: $scope

  $scope.subtitle = 'Browsing kingdoms'
  $scope.pageChanged 1

.controller 'MyKingdomsCtrl', ($scope, $controller, AuthService) ->
  $controller 'KingdomCtrl',
    $scope: $scope

  $scope.username = AuthService.username
  $scope.subtitle = "Browsing #{$scope.username}'s kingdoms"
  $scope.pageChanged 1

.controller 'UserKingdomsCtrl', ($controller, $scope, $routeParams, ExpansionSelectorService) ->
  $scope.expansionSelectorService = ExpansionSelectorService
  $controller 'KingdomCtrl',
    $scope: $scope

  $scope.username = $routeParams.username
  $scope.subtitle = "Browsing #{$scope.username}'s kingdoms"
  $scope.pageChanged 1

.controller 'FavoriteKingdomsCtrl', ($controller, $scope, $routeParams, ExpansionSelectorService) ->
  $scope.expansionSelectorService = ExpansionSelectorService

  $controller 'KingdomCtrl',
    $scope: $scope

  $scope.username_faves = $routeParams.username
  $scope.subtitle = "Browsing #{$scope.username_faves}'s favorite kingdoms"
  $scope.pageChanged 1

.controller 'MyFavoriteKingdomsCtrl', ($controller, $scope, AuthService, $routeParams, ExpansionSelectorService) ->
  $scope.expansionSelectorService = ExpansionSelectorService

  $controller 'KingdomCtrl',
    $scope: $scope

  $scope.username_faves = AuthService.username
  $scope.subtitle = "Browsing #{$scope.username_faves}'s favorite kingdoms"
  $scope.pageChanged 1

.controller 'KingdomDetailCtrl', ($rootScope, $scope, $location, $routeParams, AlertsService, AuthService, KingdomService, APIService) ->
  id = $routeParams.id

  $scope.authService = AuthService

  APIService.kingdoms.get id: id, (data) ->
      $rootScope.title = $rootScope.title.replace '###', data.name
      kingdom = data
      $scope.kingdom = KingdomService.getOrCreate 'detail'

      $scope.kingdom.id = kingdom.id
      $scope.kingdom.name = kingdom.name
      $scope.kingdom.cards = kingdom.cards
      $scope.kingdom.description = kingdom.description
      $scope.kingdom.username = kingdom.username
      $scope.kingdom.created = kingdom.created

      $scope.contentLoaded = true

  $scope.deleteKingdom = (id) ->
    APIService.kingdoms.delete id: id, (data) ->
      AlertsService.addAlert "Deleted \"#{$scope.kingdom.name}\".", 'danger'
      $location.path 'my_kingdoms'

  $scope.openInBuilder = ->
    builderKingdom = KingdomService.getOrCreate 'builder'

    builderKingdom.id = $scope.kingdom.id
    builderKingdom.name = $scope.kingdom.name
    builderKingdom.cards = $scope.kingdom.cards
    builderKingdom.description = $scope.kingdom.description
    builderKingdom.public = $scope.kingdom.public

    $location.path 'builder'