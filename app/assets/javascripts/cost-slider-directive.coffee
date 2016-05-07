angular.module("Dominion")

.directive "costSlider", (RandomizerService, APP_CONFIG) ->
  restrict: "A"
  link: (scope, element, attrs) ->
    element.slider
      range: true
      min: APP_CONFIG.CARD_MIN_COST
      max: APP_CONFIG.CARD_MAX_COST
      values: [
        RandomizerService.min_cost
        RandomizerService.max_cost
      ]
      slide: (event, ui) ->
        scope.$apply ->
          RandomizerService.min_cost = ui.values[0]
          RandomizerService.max_cost = ui.values[1]