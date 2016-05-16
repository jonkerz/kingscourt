class KingdomHack
  Alerts = APP_CONFIG = null

  constructor: ($injector) ->
    Alerts = $injector.get 'Alerts'
    APP_CONFIG = $injector.get 'APP_CONFIG'

    @cards = []
    @name = ''
    @description = ''

  removeCard: (card) -> @cards.splice _(@cards).findIndex(card), 1

  removeCardById: (id) -> @cards = _.reject @cards, id: id

  removeAllCards: -> @cards = []

  getAllCardIds: -> _.map @cards, 'id'

  addCard: (card) ->
    if @cards.length >= APP_CONFIG.KINGDOM_SIZE
      return Alerts.add 'Kingdom full. Card not added.'
    else if _(@cards).find { name: card.name }
      return Alerts.add 'Duplicate. Card not added.'
    else
      @cards.push card

  idIsAdded: (id) -> !!_(@cards).find id: id

angular.module 'KingsCourt'

.factory 'Kingdom', ($injector) ->
  new class Kingdom
    constructor: ->
      @instances = []

    getOrCreate: (id) ->
      instance = _(@instances).find id: id
      if instance
        return instance.kingdom
      else
        kingdom = new KingdomHack $injector
        @instances.push
          id: id
          kingdom: kingdom
        return kingdom