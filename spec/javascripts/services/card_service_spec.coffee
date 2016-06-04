describe "Card", ->
  mockedCards = Cards = Card = null

  mockedCards = [
    {
      "id": 1
      "name": "Cellar"
      "cost_in_text": "2"
      "cost_in_coins": 2
      "text": "+1 Action<br />Discard any number of cards.<br />+1 Card per card discarded."
      "card_attributes": [
        "isAction"
        "givesActions"
        "givesOneCard"
      ]
    }
    {
      "id": 2
      "name": "Chapel"
      "cost_in_text": "2"
      "cost_in_coins": 2
      "text": "Trash up to 4 cards from your hand."
      "card_attributes": [
        "isAction"
        "trasher"
        "terminal"
      ]
    }
  ]

  beforeEach ->
    module "KingsCourt"
    module ($provide) ->
      $provide.constant "Cards", mockedCards

    inject (_Card_) ->
      Card = _Card_

  it "card with id '2' should have the name 'Chapel'", ->
    expect(Card.getCardById(2).name).toEqual "Chapel"

  it "card with name 'Cellar' should have id '1'", ->
    expect(Card.getCardByName("Cellar").id).toEqual 1
