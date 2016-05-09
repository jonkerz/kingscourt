angular.module('KingsCourt')
.controller 'GeneratorCtrl', ($http, $scope, $location, ExpansionSelector, Deck, Kingdom) ->
  $scope.kingdom = Kingdom.getOrCreate 'generator'

  $scope.range = (n) -> new Array n

  $scope.openInBuilder = ->
    generatorKingdom = Kingdom.getOrCreate 'generator'
    builderKingdom = Kingdom.getOrCreate 'builder'

    builderKingdom.id = null
    builderKingdom.cards = generatorKingdom.cards
    builderKingdom.name = generatorKingdom.name
    builderKingdom.description = generatorKingdom.description

    generatorKingdom.cards = []
    generatorKingdom.name = ''
    generatorKingdom.description = ''

    $location.path 'builder'

  deck = Deck

  $scope.generate = ->
    $scope.kingdom.removeAllCards()
    for [1..10]
      deck.resetDeck $scope.kingdom.cards, $scope.kingdom.bannedCards
      deck.excludeByExpansion ExpansionSelector.unselectedExpansions()
      card = deck.getRandomCard()
      if card
        $scope.kingdom.addCard card