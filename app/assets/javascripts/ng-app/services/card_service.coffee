angular.module "KingsCourt"

.factory "Card", (Cards) ->
  new class Card
    constructor: -> @cards = Cards

    getCardByName: (name) -> _.find @cards, name: name

    getCardById: (id) -> _.find @cards, id: parseInt(id, 10)
