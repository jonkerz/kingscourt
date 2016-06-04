angular.module "KingsCourt"

.factory "ExpansionSelector", ($location) ->
  new class ExpansionSelector
    constructor: ->
      @selected = [1..11]
      @_all = [1..11]
      @expansions = [
        { id: 1, text: "Dominion" }
        { id: 2, text: "Intrigue" }
        { id: 3, text: "Seaside" }
        { id: 4, text: "Alchemy" }
        { id: 5, text: "Prosperity" }
        { id: 6, text: "Cornucopia" }
        { id: 7, text: "Hinterlands" }
        { id: 8, text: "Dark Ages" }
        { id: 9, text: "Guilds" }
        { id: 11, text: "Adventures" }
        { id: 10, text: "Promo" }
      ]

    unselected: -> _.difference @_all, @selected

    isSelected: (id) -> _.includes @selected, id

    checkAll: -> @selected = @_all.slice 0

    uncheckAll: -> @selected = []

    _areAllSelected: -> _.isEqual @selected, @_all

    setParams: ->
      expansions = if @_areAllSelected() then null else @selected.join(",")
      $location.search "expansions", expansions

    setFromParams: ->
      if $location.search().expansions?
        expansions = $location.search().expansions.split(",")
        expansions = _.map expansions, (expansion) -> parseInt(expansion, 10)
        @selected = expansions
