angular.module('KingsCourt')

.controller 'GeneratorCtrl', ($http, $scope, $location, ExpansionSelectorService, DeckService, AlertsService, KingdomService) ->
  $scope.expansionSelectorService = ExpansionSelectorService
  $scope.kingdom = KingdomService.getOrCreate 'generator'

  $scope.range = (n) -> new Array n

  $scope.openInBuilder = ->
    generatorKingdom = KingdomService.getOrCreate 'generator'
    builderKingdom = KingdomService.getOrCreate 'builder'

    builderKingdom.id = null
    builderKingdom.cards = generatorKingdom.cards
    builderKingdom.name = generatorKingdom.name
    builderKingdom.description = generatorKingdom.description

    generatorKingdom.cards = []
    generatorKingdom.name = ''
    generatorKingdom.description = ''

    $location.path 'builder'

  deck = DeckService

  $scope.generate = ->
    $scope.kingdom.removeAllCards()
    for [1..10]
      deck.resetDeck $scope.kingdom.cards, $scope.kingdom.bannedCards
      deck.excludeByExpansion ExpansionSelectorService.unselectedExpansions()
      card = deck.getRandomCard()
      if card
        $scope.kingdom.addCard card