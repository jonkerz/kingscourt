angular.module('KingsCourt')
.factory 'ExpansionSelector', ->
  new class ExpansionSelector
    constructor: ->
      @selected = [0..9]
      @all = [0..9]
      @names = [
        { id: 0, text: 'Dominion' }
        { id: 1, text: 'Intrigue' }
        { id: 2, text: 'Seaside' }
        { id: 3, text: 'Alchemy' }
        { id: 4, text: 'Prosperity' }
        { id: 5, text: 'Cornucopia' }
        { id: 6, text: 'Hinterlands' }
        { id: 7, text: 'Dark Ages' }
        { id: 8, text: 'Guilds' }
        { id: 9, text: 'Promo' }
      ]

    unselected: -> _.difference @all, @selected

    isActive: (id) -> _.contains @selected, id

    checkAll: -> @selected = @all.slice 0

    uncheckAll: ->  @selected = []