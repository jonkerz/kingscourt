describe "Randomizer", ->
  Randomizer = null

  beforeEach ->
    module "KingsCourt"

    inject (_Randomizer_) ->
      Randomizer = _Randomizer_

  it "member fields", ->
    expect(Randomizer.minCost).toBeDefined()
    expect(Randomizer.maxCost).toBeDefined()
    expect(Randomizer.cardAttributesYes).toBeDefined()
    expect(Randomizer.cardAttributesNo).toBeDefined()

  it "should calculate costs...", ->
    Randomizer.minCost = 2
    Randomizer.maxCost = 2
    expect(Randomizer.cost()).toEqual 2

    Randomizer.maxCost = 6
    expect(Randomizer.costsNot()).toEqual [0,1,7,8]

    Randomizer.minCost = 0
    Randomizer.maxCost = 8
    expect(Randomizer.costsNot()).toEqual []
