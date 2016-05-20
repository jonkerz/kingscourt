angular.module "KingsCourt"

.directive "trash", ->
  restrict: "A"
  link: (scope, element, attrs) ->
    element.droppable
      activeClass: "ui-state-default"
      hoverClass: "ui-state-hover"
      drop: (event, ui) ->
        card = angular.element(ui.draggable).data "card"

        if scope.kingdom.idIsAdded card.id
          scope.kingdom.removeCard card

        scope.$apply()