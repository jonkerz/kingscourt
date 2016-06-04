describe "Kingdom", ->
  Kingdom = null

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
    module ($provide) -> $provide.constant "Cards", mockedCards
    inject (_Kingdom_) -> Kingdom = _Kingdom_

  it "adds and removes cards...", ->
    expect(Kingdom.instances).toEqual []
    builder = Kingdom.getOrCreate("builder")

    expect(builder.getAllCardIds()).toEqual []
    expect(builder.idIsAdded(1)).toEqual false
    builder.addCard(mockedCards[0])

    expect(builder.idIsAdded(1)).toEqual true
    expect(builder.getAllCardIds()).toEqual [1]

    builder.removeCardById(1)
    expect(builder.getAllCardIds()).toEqual []
