angular.module "KingsCourt"

.factory "Deck", (Alerts, Card) ->
  new class Deck
    constructor: ->
      @cards = Card.cards
      for card in @cards
        card.card_attributes = _.map card.card_attributes, "name"
      @deck = angular.copy @cards

    size: -> @deck.length

    reset: (cardsInKingdom) ->
      @deck = @cards.slice()
      @removeCardById card.id for card in cardsInKingdom

    removeCardById: (id) -> _.remove @deck, (card) -> card.id is id

    removeCard: (card) -> @removeCardById card.id

    popRandomCard: ->
      if @size() is 0
        Alerts.add "No card found."
        return false
      card = _.sample @deck
      @removeCard card
      card

    excludeByAttributes: (yes_, no_) ->
      for card, i in @deck by -1
        removeCard = false

        unless yes_.length is 0
          removeCard = true unless _.intersection(card.card_attributes, yes_).length

        removeCard = true if _.intersection(card.card_attributes, no_).length isnt 0

        @deck.splice i, 1 if removeCard
      "coffee"

    excludeByExpansion: (expansions) ->
      @_excludeByX "expansion_id", expansions

    excludeByCost: (costInCoins) ->
      @_excludeByX "cost_in_coins", costInCoins

    _excludeByX: (param, values) ->
      return if values.length is 0

      for card, i in @deck by -1
        if card[param] in values
          @deck.splice i, 1
      "coffee"
