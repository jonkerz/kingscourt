describe "ExpansionSelector", ->
  ExpansionSelector = null

  beforeEach ->
    module "KingsCourt"

    inject (_ExpansionSelector_) ->
      ExpansionSelector = _ExpansionSelector_

  it "should check and uncheck expansions", ->
    ExpansionSelector.uncheckAll()
    expect(ExpansionSelector.selected).toEqual []

    ExpansionSelector.checkAllExpansions()
    expect(ExpansionSelector.selected).toEqual [0..9]

  it "should tell if an expansions is currently selected", ->
    ExpansionSelector.selected = [5, 6]
    expect(ExpansionSelector.isActive(5)).toEqual true
    expect(ExpansionSelector.isActive(8)).toEqual false

  it "should return a list of expansions that are currently *not* selected", ->
    ExpansionSelector.selected = [5, 6]
    expect(ExpansionSelector.unselected()).toEqual [0, 1, 2, 3, 4, 7, 8, 9]

describe "ExpansionSelector template...", ->
  ExpansionSelector = null
  templateHtml = undefined
  $templateCache = $compile = element = scope = createController = null

  beforeEach ->
    module "KingsCourt", "templates"

  beforeEach inject ($rootScope, $controller, _$templateCache_, _$compile_) ->
    $templateCache = _$templateCache_
    $compile = _$compile_
    scope = $rootScope.$new()

    createController = ->
      $controller "ExpansionSelectorCtrl", "$scope": scope

  it "should check and uncheck expansions", ->
      controller = createController()

      element = $compile("<input type="checkbox" checklist-model="ExpansionSelector.selected" checklist-value="0">")(scope)
      scope.ExpansionSelector.selected = [0, 1, 2]
      scope.$digest()
      expect(scope.ExpansionSelector.selected).toEqual [0, 1, 2]

      element.click()
      expect(scope.ExpansionSelector.selected).toEqual [1, 2]

      element.click()
      expect(scope.ExpansionSelector.selected.sort()).toEqual [0, 1, 2]

  it "buttons should work...", ->
    controller = createController()
    templateHtml = $templateCache.get("dist/app/components/expansion_selector/expansions.tpl.html")
    view = $compile(angular.element(templateHtml))(scope)

    selectAllButton =  angular.element(view).find("button:contains("All")").first()
    selectNoneButton =  angular.element(view).find("button:contains("None")").first()

    selectAllButton.click()
    expect(scope.ExpansionSelector.selected).toEqual [0..9]

    selectNoneButton.click()
    expect(scope.ExpansionSelector.selected).toEqual []
