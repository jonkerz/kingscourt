describe "Card", ->
  Card = null

  beforeEach ->
    module "KingsCourt"
    module ($provide) -> $provide.constant "Cards", window.mockedCards
    inject (_Card_) -> Card = _Card_

  describe "#getById", ->
    it "returns the card", ->
      expect(Card.getById(2).name).toEqual "Chapel"
