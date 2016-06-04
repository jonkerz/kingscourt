describe "Filters", ->
  $filter = null

  beforeEach ->
    module "KingsCourt"
    inject (_$filter_) ->
      $filter = _$filter_

  it "should convert from expansion id to expansion name", ->
    expect($filter("expansionToString")(1)).toEqual "Dominion"
    expect($filter("expansionToString")(2)).not.toEqual "Dominion"
