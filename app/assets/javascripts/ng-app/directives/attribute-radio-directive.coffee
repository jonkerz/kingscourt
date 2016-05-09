angular.module("KingsCourt")
.directive "attributeRadio", ->
  restrict: "E"
  replace: true
  scope: true
  templateUrl: "directives/attribute-radio-directive.tpl.html"

  link: (scope, element, attrs) ->
    scope.displayName = attrs.displayName
    scope.attributeName = attrs.attributeName

  controller: ($scope) ->
    $scope.active = "whatever"
    $scope.activate = (option, $event) ->
      $scope.active = option
      $event.stopPropagation?()

    $scope.isActive = (option) ->
      option is $scope.active