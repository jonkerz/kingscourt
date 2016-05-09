angular.module('KingsCourt')
.factory 'ExpansionSelector', ->
  new class ExpansionSelector
    constructor: ->
      @selectedExpansions = [0..9]
      @allExpansions = [0..9]
      @expansionNames = [
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

    unselectedExpansions: -> _.difference @allExpansions, @selectedExpansions

    isExpansionActive: (id) -> _.contains @selectedExpansions, id

    checkAllExpansions: -> @selectedExpansions = @allExpansions.slice 0

    uncheckAllExpansions: ->  @selectedExpansions = []

    noExpansionsSelected: -> @selectedExpansions.length == 0 #TODO: remove?