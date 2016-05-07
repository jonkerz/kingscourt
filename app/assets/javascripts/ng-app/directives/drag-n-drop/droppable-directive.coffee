angular.module("KingsCourt")
.directive "droppable", ($compile) ->
  restrict: "A"
  link: (scope, element, attrs) ->
    element.droppable
      activeClass: "ui-state-default"
      hoverClass: "ui-state-hover"
      drop: (event, ui) ->
        card = angular.element(ui.draggable).data "card"
        dropElement = angular.element this

        isAdded = scope.kingdom.idIsAdded card.id
        isBanned = scope.kingdom.idIsBanned card.id

        if isAdded and dropElement.hasClass "banned-cards-droppable"
          scope.kingdom.banCard card

        else if isBanned and dropElement.hasClass "cards-droppable"
          scope.kingdom.unbanCard card
          scope.kingdom.addCard card

        scope.$apply()