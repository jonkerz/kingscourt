describe "Randomizer", ->
  Randomizer = null

  beforeEach ->
    module "KingsCourt"
    inject (_Randomizer_) -> Randomizer = _Randomizer_

  describe "#cost and #costsNot", ->
    it "calculates costs...", ->
      Randomizer.minCost = 2
      Randomizer.maxCost = 2
      expect(Randomizer.cost()).toEqual 2

      Randomizer.maxCost = 6
      expect(Randomizer.costsNot()).toEqual [0, 1, 7, 8]

      Randomizer.minCost = 0
      Randomizer.maxCost = 8
      expect(Randomizer.costsNot()).toEqual []
