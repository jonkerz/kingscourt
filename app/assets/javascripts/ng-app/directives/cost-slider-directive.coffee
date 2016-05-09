angular.module("KingsCourt")
.directive "costSlider", (Randomizer, APP_CONFIG) ->
  restrict: "A"
  link: (scope, element, attrs) ->
    element.slider
      range: true
      min: APP_CONFIG.CARD_MIN_COST
      max: APP_CONFIG.CARD_MAX_COST
      values: [
        Randomizer.min_cost
        Randomizer.max_cost
      ]
      slide: (event, ui) ->
        scope.$apply ->
          Randomizer.min_cost = ui.values[0]
          Randomizer.max_cost = ui.values[1]