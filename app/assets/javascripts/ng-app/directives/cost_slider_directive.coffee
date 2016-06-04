angular.module "KingsCourt"

.directive "costSlider", (Randomizer) ->
  restrict: "A"

  link: (scope, element, attrs) ->
    element.slider
      range: true
      min: Randomizer.GLOBAL_MIN_COST
      max: Randomizer.GLOBAL_MAX_COST
      values: [
        Randomizer.minCost
        Randomizer.maxCost
      ]
      slide: (event, ui) ->
        scope.$apply ->
          Randomizer.minCost = ui.values[0]
          Randomizer.maxCost = ui.values[1]
