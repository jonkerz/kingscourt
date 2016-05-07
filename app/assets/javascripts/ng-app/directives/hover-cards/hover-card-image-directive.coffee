angular.module('KingsCourt')
.directive 'hoverCardImage', ->
  restrict: 'E'
  templateUrl: 'directives/dominion-card-image.tpl.html'
  scope:
    cardName: '@'
    cardImage: '@'

  link: (scope, element, attrs) -> scope.showCard = false