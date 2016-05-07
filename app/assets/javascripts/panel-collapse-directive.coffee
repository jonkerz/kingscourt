angular.module('Dominion.Common')
.directive 'panelCollapse', ->
  restrict: 'E'
  scope:
    title: '@'
    collapsed: '@'
  transclude: true
  templateUrl: 'app/common/directives/panel-collapse.tpl.html'
  link: (scope, element, attrs) ->
    scope.panelId = _.uniqueId 'panel'