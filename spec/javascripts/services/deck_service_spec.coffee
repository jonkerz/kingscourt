describe "Deck", ->
  mockedCards = Cards = Deck = null

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

    inject (_Deck_) ->
      Deck = _Deck_

  it "decksize should equal 2", ->
    expect(Deck.deckSize()).toEqual 2

  it "decksize should equal after removing a card (by id)", ->
    expect(Deck.deckSize()).toEqual 2
    Deck.removeCardById(1)
    expect(Deck.deckSize()).toEqual 1

  it "should be possible to reset the deck (after removing a card by reference)", ->
    expect(Deck.deckSize()).toEqual 2
    card = mockedCards[0]
    Deck.removeCard(card)
    expect(Deck.deckSize()).toEqual 1

  it "randomizing a card should decrease decksize by 1", ->
    deckSize = Deck.deckSize()
    Deck.getRandomCard()
    expect(Deck.deckSize()).toEqual deckSize - 1
