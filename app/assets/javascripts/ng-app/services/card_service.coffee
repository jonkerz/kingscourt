angular.module "KingsCourt"

.factory "Card", (Cards) ->
  new class Card
    constructor: -> @cards = Cards

    getById: (id) -> _.find @cards, id: parseInt(id, 10)
