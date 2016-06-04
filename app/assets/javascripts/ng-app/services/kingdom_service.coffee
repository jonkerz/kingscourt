class KingdomHack
  Alerts = null
  KINGDOM_MAX_SIZE = 10

  constructor: ($injector) ->
    Alerts = $injector.get "Alerts"

    @cards = []
    @name = ""
    @description = ""

  removeCardById: (id) -> _.remove @cards, (card) -> card.id is id

  removeCard: (card) -> @removeCardById card.id

  removeAllCards: -> @cards = []

  getAllCardIds: -> _.map @cards, "id"

  addCard: (card) ->
    if @cards.length >= KINGDOM_MAX_SIZE
      return Alerts.add "Kingdom full. Card not added."
    else if _(@cards).find { name: card.name }
      return Alerts.add "Duplicate. Card not added."
    else
      @cards.push card

  idIsAdded: (id) -> !!_(@cards).find id: id

angular.module "KingsCourt"

.factory "Kingdom", ($injector) ->
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
