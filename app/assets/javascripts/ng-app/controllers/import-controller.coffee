angular.module 'KingsCourt'

.controller 'ImportCtrl', ($scope, $location, Kingdom, Card, API) ->
  $scope.kingdom = Kingdom.getOrCreate 'generator'

  $scope.importTextarea = """
Big Money: Adventurer, Bureaucrat, Chancellor, Chapel, Feast, Laboratory, Market, Mine, Moneylender, Throne Room

Reach for Tomorrow: Adventurer, Cellar, Council Room, Cutpurse, Ghost Ship, Lookout, Sea Hag, Spy, Treasure Map, Village

Adventures Abroad: Adventurer, Chancellor, Festival, Laboratory, Remodel, Crossroads, Farmland, Fool's Gold, Oracle, Spice Merchant

Potion Mixers: Alchemist, Apothecary, Golem, Herbalist, Transmute, Cellar, Chancellor, Festival, Militia, Smithy

Chemistry Lesson: Alchemist, Golem, Philosopher's Stone, University, Bureaucrat, Market, Moat, Remodel, Witch, Woodcutter
  """

  $scope.range = (n) -> new Array n

  save = ->
    data =
      name: $scope.kingdom.name
      cards: $scope.kingdom.getAllCardIds()
      description: $scope.kingdom.description

    API.kingdoms.save data, (data) -> console.log "saved"

  $scope.import = ->
    findKingdomName = (kingdomString) -> kingdomString.match(/(.*?):/)[1]

    replaceStuff = (string) ->
      string = string.replace(/(.*?):/, '')
      string = string.replace(/^ /g, '')
      string = string.replace(/, /g, ',')
      string = string.replace(RegExp(' ,', 'g'), ',')

      string = string.toLowerCase() #n
      string = string.replace(/ /g, '')
      string = string.replace(/'/g, '')
      string

    importTextarea = '' + $scope.importTextarea

    importTextarea = importTextarea.replace(/\n\n\n/g, '\n\n')
    importTextarea = importTextarea.replace(/\n\n/g, '\n')
    kingdoms = importTextarea.split '\n'

    for kingdomString in kingdoms
      $scope.kingdom.name = "UNKNOWN"
      $scope.kingdom.removeAllCards()
      $scope.kingdom.name = findKingdomName kingdomString

      kingdomString = replaceStuff kingdomString
      kingdom = kingdomString.split(',')

      for card in kingdom
        for cardServiceCard in Card.cards
          cardServiceCardName = replaceStuff cardServiceCard.name
          if cardServiceCardName == card
            $scope.kingdom.addCard cardServiceCard

      unless $scope.kingdom.cards.length is 10
        console.log "FAILED????"
        console.log $scope.kingdom.cards.length
        console.log kingdomString
        console.log kingdom
      save()

  $scope.openInBuilder = ->
    generatorKingdom = Kingdom.getOrCreate 'generator'
    builderKingdom = Kingdom.getOrCreate 'builder'
    builderKingdom.cards = generatorKingdom.cards
    builderKingdom.name = generatorKingdom.name
    builderKingdom.description = generatorKingdom.description
    generatorKingdom.cards = []
    generatorKingdom.name = ''
    generatorKingdom.description = ''
    $location.path 'builder'