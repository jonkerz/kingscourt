angular.module('Dominion')
.factory 'CardService', ($http, Cards) ->
  new class CardService
    constructor: -> @cards = Cards

    getCardByName: (name) -> _.find @cards, name: name

    getCardById: (id) -> _.find @cards, id: id