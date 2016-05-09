angular.module('KingsCourt')
.controller 'BuilderCtrl', ($scope, API, Deck, ExpansionSelector, Randomizer, Kingdom) ->
  $scope.randomizer = Randomizer # min_cost & max_cost
  $scope.expansionSelector = ExpansionSelector
  $scope.kingdom = Kingdom.getOrCreate 'builder'
  $scope.all_cards = Deck.cards

  $scope.currentPage = 1
  $scope.pageSize = 25

  $scope.tab = 'randomizer-tab'

  $scope.setTab = (tab) -> $scope.tab = tab

  $scope.filterByExpansion = (card) -> _.contains ExpansionSelector.selectedExpansions, card.expansion

  $scope.cardStatus = (card) ->
    if $scope.kingdom.idIsAdded card.id
      'btn-primary'
    else if $scope.kingdom.idIsBanned card.id
      'btn-danger'
    else
      'btn-success'

  $scope.randomCard = ->
    deck = Deck
    collectAttributes()
    deck.resetDeck $scope.kingdom.cards, $scope.kingdom.bannedCards
    deck.excludeByExpansion ExpansionSelector.unselectedExpansions()
    deck.excludeByCost Randomizer.costs_not()
    deck.excludeByAttributes Randomizer.card_attributes_yes, Randomizer.card_attributes_no
    card = deck.getRandomCard()
    if card
      $scope.kingdom.addCard card

  $scope.cardAttributes = {}

  expansionAttributes = {}

  setupAttributes = ->
    API.getCardAttributes().then (response) ->
      expansionAttributes = response
      updateAttributesToDisplay()

  setupAttributes()

  $scope.$watchCollection 'expansionSelector.selectedExpansions', -> updateAttributesToDisplay()

  updateAttributesToDisplay = ->
    active = expansionAttributes.shared
    for expansion_id in ExpansionSelector.selectedExpansions
      active = _.union active, expansionAttributes[expansion_id]

    activeExpansionAttributes = {}
    activeExpansionAttributes[key] = true for key in active
    $scope.activeExpansionAttributes = activeExpansionAttributes

  collectAttributes = ->
    no_ = []; yes_ = []

    for key of $scope.activeExpansionAttributes
      yes_.push key if $scope.cardAttributes[key] is 'yes'
      no_.push key  if $scope.cardAttributes[key] is 'no'

    Randomizer.card_attributes_yes = yes_
    Randomizer.card_attributes_no = no_