describe "Randomizer", ->
  Randomizer = null

  beforeEach ->
    module "KingsCourt"
    inject (_Randomizer_) -> Randomizer = _Randomizer_

  describe "#cost", ->
    it "return a range [string] if min and max are different", ->
      Randomizer.minCost = 2
      Randomizer.maxCost = 3
      expect(Randomizer.cost()).toEqual "2-3"

    it "return the cost if min and max are equal", ->
      Randomizer.minCost = 2
      Randomizer.maxCost = 2
      expect(Randomizer.cost()).toEqual 2

  describe "#costsNot", ->
    it "returns an array of costs *not* selected", ->
      Randomizer.minCost = 2
      Randomizer.maxCost = 6
      expect(Randomizer.costsNot()).toEqual [0, 1, 7, 8]

      Randomizer.minCost = 0
      Randomizer.maxCost = 8
      expect(Randomizer.costsNot()).toEqual []
