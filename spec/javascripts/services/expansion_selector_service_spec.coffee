describe "ExpansionSelectorService:", ->
  ExpansionSelectorService = null

  beforeEach ->
    module "Dominion.ExpansionSelector"

    inject (_ExpansionSelectorService_) ->
      ExpansionSelectorService = _ExpansionSelectorService_

  it "should check and uncheck expansions", ->
    ExpansionSelectorService.uncheckAllExpansions()
    expect(ExpansionSelectorService.selectedExpansions).toEqual []

    ExpansionSelectorService.checkAllExpansions()
    expect(ExpansionSelectorService.selectedExpansions).toEqual [0..9]

  it "should tell if an expansions is currently selected", ->
    ExpansionSelectorService.selectedExpansions = [5, 6]
    expect(ExpansionSelectorService.isExpansionActive(5)).toEqual true
    expect(ExpansionSelectorService.isExpansionActive(8)).toEqual false

  it "should return a list of expansions that are currently *not* selected", ->
    ExpansionSelectorService.selectedExpansions = [5, 6]
    expect(ExpansionSelectorService.unselectedExpansions()).toEqual [0, 1, 2, 3, 4, 7, 8, 9]

  it "test noExpansionsSelected", ->
    ExpansionSelectorService.selectedExpansions = [5, 6]
    expect(ExpansionSelectorService.noExpansionsSelected()).toEqual false

    ExpansionSelectorService.selectedExpansions = []
    expect(ExpansionSelectorService.noExpansionsSelected()).toEqual true

describe "ExpansionSelector template...:", ->

  ExpansionSelectorService = null
  templateHtml = undefined
  $templateCache = $compile = element = scope = createController = null

  beforeEach ->
    module "Dominion.ExpansionSelector", "templates"

  beforeEach inject ($rootScope, $controller, _$templateCache_, _$compile_) ->
    $templateCache = _$templateCache_
    $compile = _$compile_
    scope = $rootScope.$new()

    createController = ->
      $controller "ExpansionSelectorCtrl", "$scope": scope

  it "should check and uncheck expansions", ->
      controller = createController()

      element = $compile("<input type="checkbox" checklist-model="expansionSelectorService.selectedExpansions" checklist-value="0">")(scope)
      scope.expansionSelectorService.selectedExpansions = [0, 1, 2]
      scope.$digest()
      expect(scope.expansionSelectorService.selectedExpansions).toEqual [0, 1, 2]

      element.click()
      expect(scope.expansionSelectorService.selectedExpansions).toEqual [1, 2]

      element.click()
      expect(scope.expansionSelectorService.selectedExpansions.sort()).toEqual [0, 1, 2]

  it "buttons should work...", ->
    controller = createController()
    templateHtml = $templateCache.get("dist/app/components/expansion_selector/expansions.tpl.html")
    view = $compile(angular.element(templateHtml))(scope)

    selectAllButton =  angular.element(view).find("button:contains("All")").first()
    selectNoneButton =  angular.element(view).find("button:contains("None")").first()

    selectAllButton.click()
    expect(scope.expansionSelectorService.selectedExpansions).toEqual [0..9]

    selectNoneButton.click()
    expect(scope.expansionSelectorService.selectedExpansions).toEqual []
