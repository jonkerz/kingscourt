angular.module 'KingsCourt'

.directive 'hoverCard', ->
  restrict: 'E'
  templateUrl: 'directives/dominion-card-text.tpl.html'
  scope: true

  link: (scope, element, attrs) -> scope.showCard = false