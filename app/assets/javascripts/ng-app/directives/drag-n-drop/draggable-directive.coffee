angular.module "KingsCourt"

.directive "draggable", ->
  restrict: "A"
  link: (scope, element, attrs) ->
    element.bind 'mouseup', (e) ->
      unless element.data('dragging')
        card = angular.element(element).data "card"
        scope.openBuilderCard(card)

    element.draggable
      revert: true
      zIndex: 2000
      start: (event, ui) -> element.data('dragging', true)
      stop: (event, ui) -> element.data('dragging', false)