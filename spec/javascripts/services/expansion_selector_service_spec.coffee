describe "ExpansionSelector", ->
  ExpansionSelector = null

  beforeEach ->
    module "KingsCourt"
    inject (_ExpansionSelector_) -> ExpansionSelector = _ExpansionSelector_

  describe "#uncheckAll & #checkAll", ->
    it "checks and unchecks expansions", ->
      ExpansionSelector.uncheckAll()
      expect(ExpansionSelector.selected).toEqual []

      ExpansionSelector.checkAll()
      expect(ExpansionSelector.selected).toEqual [1..11]

  describe "#isChecked", ->
    it "tells if an expansions is currently selected", ->
      ExpansionSelector.selected = [5, 6]
      expect(ExpansionSelector.isChecked(5)).toEqual true
      expect(ExpansionSelector.isChecked(8)).toEqual false

  describe "#unselected", ->
    it "returns a list of expansions that are currently *not* selected", ->
      ExpansionSelector.selected = [5, 6]
      expect(ExpansionSelector.unselected()).toEqual [1, 2, 3, 4, 7, 8, 9, 10, 11]
