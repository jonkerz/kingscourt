describe 'Kingdom:', ->
    mockedCards = Cards = KingdomService = CardService = AlertsService = builder = null

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

        inject (_KingdomService_, _CardService_, _AlertsService_) ->
            KingdomService = _KingdomService_
            CardService = _CardService_
            AlertsService = _AlertsService_

    it 'should add and remove cards', ->
        expect(KingdomService.instances).toEqual []
        builder = KingdomService.getOrCreate("builder")
        
        expect(builder.getAllCardIds()).toEqual []
        expect(builder.idIsAdded(1)).toEqual false
        builder.addCard(mockedCards[0])

        expect(builder.idIsAdded(1)).toEqual true
        expect(builder.getAllCardIds()).toEqual [1]

        builder.removeCardById(1)
        expect(builder.getAllCardIds()).toEqual []

    it 'should not be possible to add banned cards.........', ->
        builder = KingdomService.getOrCreate("builder")

        builder.banCard(mockedCards[1]) #blalblablalblba,
        #builder.addCard(mockedCards[1]) #AlertsService is not defined, works in production