describe 'cards:', ->

    mockedCards = Cards = CardService = null

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
        module 'Dominion.CardResource'
        module ($provide) ->
            $provide.constant 'Cards', mockedCards

        inject (_CardService_) ->
            CardService = _CardService_

    it 'card with id "2" should have the name "Chapel"', ->
        expect(CardService.getCardById(2).name).toEqual 'Chapel'

    it 'card with name "Cellar" should have id "1"', ->
        expect(CardService.getCardByName('Cellar').id).toEqual 1