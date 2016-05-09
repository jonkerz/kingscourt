angular.module("KingsCourt")
.factory "Randomizer", (APP_CONFIG) ->
  new class Randomizer
    constructor: ->
      @min_cost = APP_CONFIG.CARD_MIN_COST
      @max_cost = APP_CONFIG.CARD_MAX_COST
      @card_attributes_yes = []
      @card_attributes_no = []

    cost: ->
      if @min_cost is @max_cost
        @min_cost
      else
        @min_cost + "-" + @max_cost

    costs_not: ->
      _.difference [APP_CONFIG.CARD_MIN_COST..APP_CONFIG.CARD_MAX_COST], [@min_cost..@max_cost]