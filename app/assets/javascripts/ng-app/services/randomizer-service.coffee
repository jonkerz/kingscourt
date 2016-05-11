angular.module "KingsCourt"

.factory "Randomizer", (APP_CONFIG) ->
  new class Randomizer
    constructor: ->
      @minCost = APP_CONFIG.CARD_MIN_COST
      @maxCost = APP_CONFIG.CARD_MAX_COST
      @cardAttributesYes = []
      @cardAttributesNo = []

    cost: ->
      if @minCost is @maxCost
        @minCost
      else
        @minCost + "-" + @maxCost

    costsNot: ->
      _.difference [APP_CONFIG.CARD_MIN_COST..APP_CONFIG.CARD_MAX_COST], [@minCost..@maxCost]