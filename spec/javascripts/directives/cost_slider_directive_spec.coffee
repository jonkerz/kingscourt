describe "testing sliderDir", ->
  beforeEach angular.mock.module("KingsCourt")
  element = undefined
  $scope = undefined

  beforeEach angular.mock.inject ($compile, $rootScope) ->
    $scope = $rootScope.$new()
    validTemplate = angular.element('<div class="slider" cost-slider></div>')
    element = $compile(validTemplate)($scope)

  it "has correct values", ->
    expect($(element).slider("value")).toEqual 0
    expect($(element).slider("option", "disabled")).toBe false
    expect($(element).slider("option", "max")).toEqual 8
