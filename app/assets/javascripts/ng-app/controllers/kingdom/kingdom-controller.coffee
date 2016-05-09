angular.module('KingsCourt')
.controller 'KingdomCtrl', ($scope, $location, $timeout, Auth, Alerts, API, ExpansionSelector, Card) ->
  $scope.auth = Auth
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
    _.map cards, (card_id) -> Card.getCardById parseInt card_id, 10

  $scope.kingdomsUrl = '/api/v1/kingdoms?format=json'

  $scope.kingdom_params =
    expansions: ExpansionSelector.selectedExpansions.join(",")

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
      expansions: ExpansionSelector.unselectedExpansions().join '_'

    API.kingdoms.query params, (data) ->
      kingdoms = data.results
      favoriteKingdoms = Auth.favoriteKingdoms

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
      API.favorites.delete { id: kingdom.id }, (data) ->
        Auth.removeFromFavoriteKingdomsList kingdom.id
        kingdom.favorites_count--
        kingdom.favorite = not kingdom.favorite
        $scope.isSaving = false
    else
      API.favorites.save { id: kingdom.id }, (data) ->
        Auth.addToFavoriteKingdomsList kingdom.id
        kingdom.favorites_count++
        kingdom.favorite = not kingdom.favorite
        $scope.isSaving = false
  ###