describe 'RandomizerService:', ->
  RandomizerService = null

  beforeEach ->
    module 'Dominion.Builder'

    inject (_RandomizerService_) ->
      RandomizerService = _RandomizerService_

  it 'member fields', ->
    expect(RandomizerService.min_cost).toBeDefined()
    expect(RandomizerService.max_cost).toBeDefined()
    expect(RandomizerService.card_attributes_yes).toBeDefined()
    expect(RandomizerService.card_attributes_no).toBeDefined()

  it 'should calculate costs...', ->
    RandomizerService.min_cost = 2
    RandomizerService.max_cost = 2
    expect(RandomizerService.cost()).toEqual 2

    RandomizerService.max_cost = 6
    expect(RandomizerService.costs_not()).toEqual [0,1,7,8]

    RandomizerService.min_cost = 0
    RandomizerService.max_cost = 8
    expect(RandomizerService.costs_not()).toEqual []
