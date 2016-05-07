angular.module('Dominion.Common')
.directive 'hoverCard', ->
  restrict: 'E'
  templateUrl: 'app/common/directives/dominion-card-text.tpl.html'
  scope:
    cardName: '@'
    cardImage: '@'

  link: (scope, element, attrs) -> scope.showCard = false

.directive 'hoverCardImage', ->
  restrict: 'E'
  templateUrl: 'app/common/directives/dominion-card-image.tpl.html'
  scope:
    cardName: '@'
    cardImage: '@'

  link: (scope, element, attrs) -> scope.showCard = false

.directive 'hoverCardZoom', ->
  restrict: 'E'
  templateUrl: 'app/common/directives/dominion-card-zoom.tpl.html'
  scope:
    cardName: '@'
    cardImage: '@'

  link: (scope, element, attrs) -> scope.showCard = false