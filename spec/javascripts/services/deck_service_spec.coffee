describe "Deck", ->
  Deck = null

  beforeEach ->
    module "KingsCourt"
    module ($provide) -> $provide.constant "Cards", window.mockedCards
    inject (_Deck_) -> Deck = _Deck_

  describe "#removeCardById", ->
    it "removes the card", ->
      Deck.removeCardById 1
      expect(Deck.deckSize()).toEqual 1

  describe "#removeCard", ->
    it "removes the card (by equality)", ->
      Deck.removeCard window.mockedCards[0]
      expect(Deck.deckSize()).toEqual 1

  describe "#deckSize", ->
    it "return the size", ->
      expect(Deck.deckSize()).toEqual 2

  describe "#popRandomCard", ->
    it "return a random card, and removed it from the deck", ->
      card = Deck.popRandomCard()
      expect(card.cost_in_coins).toEqual 2
      expect(Deck.deckSize()).toEqual 1
