describe 'Deck:', ->

    mockedCards = Cards = DeckService = null

    mockedCards = [
        {
            'id': 1
            'name': 'Cellar'
            'type': 0
            'expansion': 0
            'cost': '2'
            'cost_in_coins': 2
            'text': '+1 Action<br />Discard any number of cards.<br />+1 Card per card discarded.'
            'card_attributes': [
                'isAction'
                'givesActions'
                'givesOneCard'
            ]
        }
        {
            'id': 2
            'name': 'Chapel'
            'type': 0
            'expansion': 0
            'cost': '2'
            'cost_in_coins': 2
            'text': 'Trash up to 4 cards from your hand.'
            'card_attributes': [
                'isAction'
                'isTrasher'
                'isTerminal'
            ]
        }
    ]

    beforeEach ->
        module 'Dominion.Builder'
        module ($provide) ->
            $provide.constant 'Cards', mockedCards

        inject (_DeckService_) ->
            DeckService = _DeckService_

    it 'decksize should equal 2', ->
        expect(DeckService.deckSize()).toEqual 2

    it 'decksize should equal after removing a card (by id)', ->
        expect(DeckService.deckSize()).toEqual 2
        DeckService.removeCardById(1)
        expect(DeckService.deckSize()).toEqual 1

    it 'should be possible to reset the deck (after removing a card by reference)', ->
        expect(DeckService.deckSize()).toEqual 2
        card = mockedCards[0]
        DeckService.removeCard(card)
        expect(DeckService.deckSize()).toEqual 1

    it 'randomizing a card should decrease decksize by 1', ->
        deckSize = DeckService.deckSize()
        DeckService.getRandomCard()
        expect(DeckService.deckSize()).toEqual deckSize - 1