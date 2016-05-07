angular.module('Dominion.Filters', [])

.filter 'expansionToString', ->
  ExpansionEnum =
    0: 'Dominion'
    1: 'Intrigue'
    2: 'Seaside'
    3: 'Alchemy'
    4: 'Prosperity'
    5: 'Cornucopia'
    6: 'Hinterlands'
    7: 'Dark Ages'
    8: 'Guilds'
    9: 'Promo'

  (exp) ->
    ExpansionEnum[exp]

.filter 'replaceSpaces', ->
  (str) ->
    return str    if str is undefined
    str = str.replace(/'/g, '')
    str.replace RegExp(' ', 'g'), '_'