angular.module "KingsCourt"

.directive "panelCollapse", ->
  restrict: "E"
  scope:
    title: "@"
    collapsed: "@"
  transclude: true
  templateUrl: "directives/panel_collapse.tpl.html"
  link: (scope, element, attrs) ->
    scope.panelId = _.uniqueId "panel"
