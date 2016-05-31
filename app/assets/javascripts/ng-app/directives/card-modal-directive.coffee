angular.module "KingsCourt"

.directive "cardModal", ->
  restrict: "A"
  scope: true

  link: (scope, element, attrs) ->
    element.bind "click", ->
      card = angular.element(element).data "card"
      scope.openCard card
