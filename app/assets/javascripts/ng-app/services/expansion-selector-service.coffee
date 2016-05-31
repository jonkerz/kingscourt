angular.module 'KingsCourt'

.factory 'ExpansionSelector', ($location) ->
  new class ExpansionSelector
    constructor: ->
      @selected = [1..11]
      @all = [1..11]
      @names = [
        { id: 1, text: 'Dominion' }
        { id: 2, text: 'Intrigue' }
        { id: 3, text: 'Seaside' }
        { id: 4, text: 'Alchemy' }
        { id: 5, text: 'Prosperity' }
        { id: 6, text: 'Cornucopia' }
        { id: 7, text: 'Hinterlands' }
        { id: 8, text: 'Dark Ages' }
        { id: 9, text: 'Guilds' }
        { id: 11, text: 'Adventures' }
        { id: 10, text: 'Promo' }
      ]

    unselected: -> _.difference @all, @selected

    isActive: (id) -> _.includes @selected, id

    allChecked:  -> _.isEqual @selected, @all

    checkAll: -> @selected = @all.slice 0

    uncheckAll: ->  @selected = []

    setParams: ->
      expansions = if @allChecked() then null else @selected.join(',')
      $location.search 'expansions', expansions

    setFromParams: ->
      if $location.search().expansions?
        expansions = $location.search().expansions.split(",")
        expansions = _.map expansions, (expansion) -> parseInt(expansion, 10)
        @selected = expansions
