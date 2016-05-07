angular.module('Dominion.Builder')

.controller 'ImportCtrl', ($http, $scope, $location, DeckService, AlertsService, KingdomService, CardService, APIService, AuthService) ->
  $scope.kingdom = KingdomService.getOrCreate 'generator'

  #$scope.importTextarea = 'Big Money: Adventurer, Bureaucrat, Chancellor, Chapel, Feast, Laboratory, Market, Mine, Moneylender, Throne Room'

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
      kingdom_description: $scope.kingdom.description
    #console.log "in save, data:", data

    APIService.kingdoms.save data, (data) -> console.log "saved"

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
      #console.log replaceStuff kingdom

      kingdomString = replaceStuff kingdomString 
      kingdom = kingdomString.split(',')
      #console.log kingdom

      for card in kingdom
        for cardServiceCard in CardService.cards
          #cardo_namo = cardo.name.replace(' ', '')
          #cardo_namo = cardo_namo.replace("'", '')
          #cardo_namo = cardo_namo.toLowerCase()
          #console.log "BEFORE REP", cardServiceCardName
          cardServiceCardName = replaceStuff cardServiceCard.name
          #console.log "AFTER REP", cardServiceCardName
          if cardServiceCardName == card
            #card = CardService.getCardByName cardServiceCardName
            $scope.kingdom.addCard cardServiceCard
            #console.log "match!", cardServiceCardName

      unless $scope.kingdom.cards.length is 10
        console.log "FAILED????"
        console.log $scope.kingdom.cards.length
        console.log kingdomString
        console.log kingdom
      save()
      #console.log kingdom
      #console.log findKingdomName kingdom
    #importList = '' + $scope.importTextarea
    #$scope.kingdom.name = importList.match(/(.*?):/)[1]
    #importList = importList.replace(/(.*?):/, '')
    #console.log importList

    #importList = importList.replace(/^ /g, '')
    #importList = importList.replace(/, /g, ',')
    #importList = importList.replace(RegExp(' ,', 'g'), ',')
    #console.log importList

    #importList = importList.toLowerCase() #n
    #importList = importList.replace(' ', '')
    #importList = importList.replace("'", '')

    #importList = importList.split(',')
    #console.log importList
    #console.log CardService.cards, "<---"
    #for i in importList
    #    for cardo in CardService.cards
    #        cardo_namo = cardo.name.replace(' ', '')
    #        cardo_namo = cardo_namo.replace("'", '')
    #        cardo_namo = cardo_namo.toLowerCase()

    #        if cardo_namo == i
    #            console.log "match!", cardo_namo
    return

  $scope.openInBuilder = ->
    generatorKingdom = KingdomService.getOrCreate 'generator'
    builderKingdom = KingdomService.getOrCreate 'builder'
    builderKingdom.cards = generatorKingdom.cards
    builderKingdom.name = generatorKingdom.name
    builderKingdom.description = generatorKingdom.description
    generatorKingdom.cards = []
    generatorKingdom.name = ''
    generatorKingdom.description = ''
    $location.path 'builder'