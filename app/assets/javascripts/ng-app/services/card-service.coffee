angular.module 'KingsCourt'

.factory 'Card', ($http, Cards) ->
  new class Card
    constructor: -> @cards = Cards

    getCardByName: (name) -> _.find @cards, name: name

    getCardById: (id) -> _.find @cards, id: id