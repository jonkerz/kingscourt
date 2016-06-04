describe "Kingdom", ->
  Kingdom = null

  beforeEach ->
    module "KingsCourt"
    module ($provide) -> $provide.constant "Cards", window.mockedCards
    inject (_Kingdom_) -> Kingdom = _Kingdom_

  it "adds and removes cards...", ->
    expect(Kingdom.instances).toEqual []

    builder = Kingdom.getOrCreate "builder"
    expect(builder.getAllCardIds()).toEqual []
    expect(builder.idIsAdded 1).toBe false

    builder.addCard window.mockedCards[0]
    expect(builder.idIsAdded 1).toBe true
    expect(builder.getAllCardIds()).toEqual [1]

    builder.removeCardById 1
    expect(builder.getAllCardIds()).toEqual []
