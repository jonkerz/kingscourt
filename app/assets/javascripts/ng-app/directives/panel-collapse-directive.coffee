angular.module 'KingsCourt'

.directive 'panelCollapse', ->
  restrict: 'E'
  scope:
    title: '@'
    collapsed: '@'
  transclude: true
  templateUrl: 'directives/panel-collapse.tpl.html'
  link: (scope, element, attrs) ->
    scope.panelId = _.uniqueId 'panel'