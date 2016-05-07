angular.module('KingsCourt')
.directive 'hoverCardZoom', ->
  restrict: 'E'
  templateUrl: 'directives/dominion-card-zoom.tpl.html'
  scope:
    cardName: '@'
    cardImage: '@'

  link: (scope, element, attrs) -> scope.showCard = false