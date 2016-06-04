describe "ExpansionSelector", ->
  ExpansionSelector = null

  beforeEach ->
    module "KingsCourt"
    inject (_ExpansionSelector_) -> ExpansionSelector = _ExpansionSelector_

  beforeEach ->
    ExpansionSelector.selected = [5, 6]

  describe "#uncheckAll", ->
    it "unchecks all expansions", ->
      ExpansionSelector.uncheckAll()
      expect(ExpansionSelector.selected).toEqual []

  describe "#checkAll", ->
    it "checks all expansions", ->
      ExpansionSelector.checkAll()
      expect(ExpansionSelector.selected).toEqual [1..11]

  describe "#isChecked", ->
    it "tells if an expansions is currently selected", ->
      expect(ExpansionSelector.isChecked 5).toBe true
      expect(ExpansionSelector.isChecked 8).toBe false

  describe "#unselected", ->
    it "returns a list of expansions that are currently *not* selected", ->
      expect(ExpansionSelector.unselected())
        .toEqual [1, 2, 3, 4, 7, 8, 9, 10, 11]
