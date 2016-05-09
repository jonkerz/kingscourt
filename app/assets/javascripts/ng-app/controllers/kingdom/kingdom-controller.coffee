angular.module('KingsCourt')
.controller 'KingdomCtrl', ($scope, $location, $timeout, Alerts, API, ExpansionSelector, Card) ->
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
    expansions: ExpansionSelector.selected.join(",")

  $scope.reloadPage = ->
    returnTo = $location.path()
    $timeout (-> $location.path returnTo), 0
    $location.path "/kings_court" # "loading..."

  $scope.toggleFavorite = (kingdom) ->
    return if $scope.isSaving

    $scope.isSaving = true
    $scope.savingKingdomId = kingdom.id

    if kingdom.favorite
      API.favorites.delete { id: kingdom.id }, (data) ->
        kingdom.favorite_count--
        kingdom.favorite = not kingdom.favorite
        $scope.isSaving = false
    else
      API.favorites.save { kingdom_id: kingdom.id }, (data) ->
        kingdom.favorite_count++
        kingdom.favorite = not kingdom.favorite
        $scope.isSaving = false