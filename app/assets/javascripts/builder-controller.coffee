angular.module('KingsCourt')

.controller 'BuilderCtrl', ($scope, APIService, DeckService, ExpansionSelectorService, RandomizerService, AlertsService, KingdomService) ->
  $scope.randomizerService = RandomizerService # min_cost & max_cost
  $scope.expansionSelectorService = ExpansionSelectorService
  $scope.kingdom = KingdomService.getOrCreate 'builder'
  $scope.all_cards = DeckService.cards

  $scope.currentPage = 1
  $scope.pageSize = 25

  $scope.tab = 'randomizer-tab'

  $scope.setTab = (tab) -> $scope.tab = tab

  $scope.filterByExpansion = (card) -> _.contains ExpansionSelectorService.selectedExpansions, card.expansion

  $scope.cardStatus = (card) ->
    if $scope.kingdom.idIsAdded card.id
      'btn-primary'
    else if $scope.kingdom.idIsBanned card.id
      'btn-danger'
    else
      'btn-success'

  $scope.randomCard = ->
    deck = DeckService
    collectAttributes()
    deck.resetDeck $scope.kingdom.cards, $scope.kingdom.bannedCards
    deck.excludeByExpansion ExpansionSelectorService.unselectedExpansions()
    deck.excludeByCost RandomizerService.costs_not()
    deck.excludeByAttributes RandomizerService.card_attributes_yes, RandomizerService.card_attributes_no
    card = deck.getRandomCard()
    if card
      $scope.kingdom.addCard card

  $scope.cardAttributes = {}

  expansionAttributes = {}

  setupAttributes = ->
    APIService.getCardAttributes().then (response) ->
      expansionAttributes = response
      updateAttributesToDisplay()

  setupAttributes()

  $scope.$watchCollection 'expansionSelectorService.selectedExpansions', -> updateAttributesToDisplay()

  updateAttributesToDisplay = ->
    active = expansionAttributes.shared
    for expansion_id in ExpansionSelectorService.selectedExpansions
      active = _.union active, expansionAttributes[expansion_id]

    activeExpansionAttributes = {}
    activeExpansionAttributes[key] = true for key in active
    $scope.activeExpansionAttributes = activeExpansionAttributes

  collectAttributes = ->
    no_ = []; yes_ = []

    for key of $scope.activeExpansionAttributes
      yes_.push key if $scope.cardAttributes[key] is 'yes'
      no_.push key  if $scope.cardAttributes[key] is 'no'

    RandomizerService.card_attributes_yes = yes_
    RandomizerService.card_attributes_no = no_