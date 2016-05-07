angular.module("Dominion")

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

.directive "trash", ($compile) ->
  restrict: "A"
  link: (scope, element, attrs) ->
    element.droppable
      activeClass: "ui-state-default"
      hoverClass: "ui-state-hover"
      drop: (event, ui) ->
        card = angular.element(ui.draggable).data "card"

        if scope.kingdom.idIsAdded card.id
          scope.kingdom.removeCard card

        else if scope.kingdom.idIsBanned card.id
          scope.kingdom.unbanCard card

        scope.$apply()

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