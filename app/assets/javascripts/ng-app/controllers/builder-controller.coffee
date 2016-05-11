angular.module('KingsCourt')
.controller 'BuilderCtrl', ($scope, API, Deck, ExpansionSelector, Randomizer, Kingdom) ->
  $scope.randomizer = Randomizer # minCost & maxCost
  $scope.expansionSelector = ExpansionSelector
  $scope.kingdom = Kingdom.getOrCreate 'builder'
  $scope.allCards = Deck.cards

  $scope.currentPage = 1
  $scope.pageSize = 25

  $scope.tab = 'randomizer-tab'

  $scope.setTab = (tab) -> $scope.tab = tab

  $scope.filterByExpansion = (card) -> _.contains ExpansionSelector.selected, card.expansion_id

  $scope.cardStatus = (card) ->
    if $scope.kingdom.idIsAdded card.id
      'btn-primary'
    else if $scope.kingdom.idIsBanned card.id
      'btn-danger'
    else
      'btn-success'

  $scope.randomCard = ->
    collectAttributes()
    Deck.reset $scope.kingdom.cards, $scope.kingdom.bannedCards
    Deck.excludeByExpansion ExpansionSelector.unselected()
    Deck.excludeByCost Randomizer.costsNot()
    Deck.excludeByAttributes Randomizer.cardAttributesYes, Randomizer.cardAttributesNo
    card = Deck.getRandomCard()
    if card
      $scope.kingdom.addCard card

  $scope.cardAttributes = {}

  expansionAttributes = {}

  setupAttributes = ->
    API.getCardAttributes().then (response) ->
      expansionAttributes = response
      updateAttributesToDisplay()

  setupAttributes()

  $scope.$watchCollection 'expansionSelector.selected', -> updateAttributesToDisplay()

  updateAttributesToDisplay = ->
    active = expansionAttributes.shared
    for expansionId in ExpansionSelector.selected
      active = _.union active, expansionAttributes[expansionId]

    activeExpansionAttributes = {}
    activeExpansionAttributes[key] = true for key in active
    $scope.activeExpansionAttributes = activeExpansionAttributes

  collectAttributes = ->
    no_ = []; yes_ = []

    for key of $scope.activeExpansionAttributes
      yes_.push key if $scope.cardAttributes[key] is 'yes'
      no_.push key  if $scope.cardAttributes[key] is 'no'

    Randomizer.cardAttributesYes = yes_
    Randomizer.cardAttributesNo = no_
