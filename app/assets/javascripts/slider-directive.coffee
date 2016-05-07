angular.module('Dominion')
.directive 'slider', ->
  restrict: 'A'
  scope:
    config: '=config'
    price: '=model'
  link: (scope, element, attrs) ->
    setModel = (value) -> scope.model = value

    element.slider
      range: false
      min: scope.config.min
      max: scope.config.max
      step: scope.config.step
      value: scope.config.initial
      slide: (event, ui) ->
        scope.$apply ->
          scope.price = ui.value