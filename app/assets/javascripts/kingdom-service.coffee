class Kingdom
  AlertsService = APP_CONFIG = null

  constructor: ($injector) ->
    AlertsService = $injector.get 'AlertsService'
    APP_CONFIG = $injector.get 'APP_CONFIG'

    @cards = []
    @name = 'Kingdom  ' + Math.random().toString(36).replace(/[^a-z]+/g, '').substr 0, 5
    @description = ''
    @bannedCards = []

  removeCard: (card) -> @cards.splice _(@cards).findIndex(card), 1

  removeCardById: (id) -> @cards = _.reject @cards, id: id

  removeAllCards: -> @cards = []

  getAllCardIds: -> _.pluck @cards, 'id'

  addCard: (card) ->
    if @cards.length >= APP_CONFIG.KINGDOM_SIZE
      AlertsService.addAlert 'Kingdom full. Card not added.', 'danger'
      return false
    else if _(@bannedCards).find { name: card.name }
      AlertsService.addAlert 'Card banned. Card not added.', 'danger'
      return false
    else if _(@cards).find { name: card.name }
      AlertsService.addAlert 'Duplicate. Card not added.', 'danger'
      return false
    else
      @cards.push card

  banCard: (card) ->
    return if @idIsBanned card.id
    @removeCard card if @idIsAdded card.id
    @bannedCards.push card

  unbanCard: (card) -> @bannedCards.splice _(@bannedCards).findIndex(card), 1

  idIsAdded: (id) -> !!_(@cards).find id: id

  idIsBanned: (id) -> !!_(@bannedCards).find id: id

angular.module('Dominion.Builder')

.factory 'KingdomService', ($injector) ->
  new class KingdomService
    constructor: ->
      @instances = []

    getOrCreate: (id) ->
      instance = _(@instances).find id: id
      if instance
        return instance.kingdom
      else
        kingdom = new Kingdom $injector
        @instances.push
          id: id
          kingdom: kingdom
        return kingdom