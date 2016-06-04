describe "Card", ->
  Card = null

  beforeEach ->
    module "KingsCourt"
    module ($provide) -> $provide.constant "Cards", window.mockedCards
    inject (_Card_) -> Card = _Card_

  describe "#getCardById", ->
    it "returns the card", ->
      expect(Card.getCardById(2).name).toEqual "Chapel"

  describe "#getCardByName", ->
    it "returns the card", ->
      expect(Card.getCardByName("Cellar").id).toEqual 1
