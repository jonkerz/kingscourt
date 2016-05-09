angular.module('KingsCourt')
.controller 'KingdomCtrl', ($scope, $location, $timeout, AuthService, AlertsService, APIService, ExpansionSelectorService, CardService) ->
  $scope.authService = AuthService
  $scope.expansionSelectorService = ExpansionSelectorService
  $scope.username = null
  $scope.username_faves = null
  $scope.kingdoms = []
  $scope.totalKingdoms = 'not set'
  $scope.totalKingdomsAll = 0
  $scope.displayMode = 'images'

  # TODO DRY
  $scope.deserializeKingdoms = (data) ->
    for kingdom in data
      kingdom.cards = deserializeCards kingdom.cards
    data

  deserializeCards = (cards) ->
    _.map cards, (card_id) -> CardService.getCardById parseInt card_id, 10

  $scope.kingdomsUrl = '/api/v1/kingdoms?format=json'

  $scope.kingdom_params =
    expansions: ExpansionSelectorService.selectedExpansions.join(",")

  $scope.reloadPage = ->
    returnTo = $location.path()
    $timeout (-> $location.path returnTo), 0
    $location.path "/kings_court" # "loading..."

  ### TODO
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
  ###

  # TODO
  ###
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
  ###