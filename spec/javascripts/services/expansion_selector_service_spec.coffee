describe "ExpansionSelector", ->
  ExpansionSelector = null

  beforeEach ->
    module "KingsCourt"

    inject (_ExpansionSelector_) ->
      ExpansionSelector = _ExpansionSelector_

  it "should check and uncheck expansions", ->
    ExpansionSelector.uncheckAll()
    expect(ExpansionSelector.selected).toEqual []

    ExpansionSelector.checkAll()
    expect(ExpansionSelector.selected).toEqual [1..11]

  it "should tell if an expansions is currently selected", ->
    ExpansionSelector.selected = [5, 6]
    expect(ExpansionSelector.isChecked(5)).toEqual true
    expect(ExpansionSelector.isChecked(8)).toEqual false

  it "should return a list of expansions that are currently *not* selected", ->
    ExpansionSelector.selected = [5, 6]
    expect(ExpansionSelector.unselected()).toEqual [1, 2, 3, 4, 7, 8, 9, 10, 11]
