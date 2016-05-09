angular.module("KingsCourt")
.directive "costSlider", (Randomizer, APP_CONFIG) ->
  restrict: "A"
  link: (scope, element, attrs) ->
    element.slider
      range: true
      min: APP_CONFIG.CARD_MIN_COST
      max: APP_CONFIG.CARD_MAX_COST
      values: [
        Randomizer.minCost
        Randomizer.maxCost
      ]
      slide: (event, ui) ->
        scope.$apply ->
          Randomizer.minCost = ui.values[0]
          Randomizer.maxCost = ui.values[1]