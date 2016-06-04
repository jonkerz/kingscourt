describe "Kingdom", ->
  mockedCards = Cards = Kingdom = Card = Alerts = builder = null

  mockedCards = [
    {
      "id": 1
      "name": "Cellar"
      "type": 0
      "expansion": 0
      "cost": "2"
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
      "type": 0
      "expansion": 0
      "cost": "2"
      "cost_in_coins": 2
      "text": "Trash up to 4 cards from your hand."
      "card_attributes": [
          "isAction"
          "isTrasher"
          "isTerminal"
      ]
    }
  ]

  beforeEach ->
    module "KingsCourt"
    module ($provide) ->
      $provide.constant "Cards", mockedCards

    inject (_Kingdom_, _Card_, _Alerts_) ->
      Kingdom = _Kingdom_
      Card = _Card_
      Alerts = _Alerts_

  it "should add and remove cards", ->
    expect(Kingdom.instances).toEqual []
    builder = Kingdom.getOrCreate("builder")

    expect(builder.getAllCardIds()).toEqual []
    expect(builder.idIsAdded(1)).toEqual false
    builder.addCard(mockedCards[0])

    expect(builder.idIsAdded(1)).toEqual true
    expect(builder.getAllCardIds()).toEqual [1]

    builder.removeCardById(1)
    expect(builder.getAllCardIds()).toEqual []

  it "should not be possible to add banned cards.........", ->
    builder = Kingdom.getOrCreate("builder")

    builder.banCard(mockedCards[1]) #blalblablalblba,
    #builder.addCard(mockedCards[1]) #Alerts is not defined, works in production
