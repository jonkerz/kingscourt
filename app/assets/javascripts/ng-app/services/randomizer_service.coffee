angular.module "KingsCourt"

.factory "Randomizer", ->
  new class Randomizer
    constructor: ->
      @GLOBAL_MIN_COST = 0
      @GLOBAL_MAX_COST = 8

      @minCost = @GLOBAL_MIN_COST
      @maxCost = @GLOBAL_MAX_COST
      @cardAttributesYes = []
      @cardAttributesNo = []

    cost: ->
      if @minCost is @maxCost
        @minCost
      else
        @minCost + "-" + @maxCost

    costsNot: ->
      allCosts = [@GLOBAL_MIN_COST..@GLOBAL_MAX_COST]
      _.difference allCosts, [@minCost..@maxCost]
