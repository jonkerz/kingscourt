angular.module 'KingsCourt'

.controller 'CardBroswerCtrl', ($scope, $http, ExpansionSelector, Card, API_SERVER) ->
  $scope.allCards = Card.cards

  $http.get('/api/get_non_randomizers', { cache: true }).then (response) -> #TODO
    cards = response.data
    for card in cards
      card.image = (card.name).replace(RegExp(' ', 'g'), '_').replace(/'/g, '') + '.jpg'
    $scope.allCards = $scope.allCards.concat cards

  $scope.currentPage = 1
  $scope.displayMode = 'images'

  $scope.selectedCard = null
  $scope.setSelectedCard = (card) -> $scope.selectedCard = card

  $scope.orderByField = 'name'
  $scope.reverseSort = false

  $scope.filterByExpansion = (card) -> ExpansionSelector.selected.indexOf(card.expansion_id) isnt -1

  $scope.cardDisplaySize = 110
  $scope.cardDisplaySizeSliderConfig =
    min: 50
    max: 500
    step: 1
    initial: 110

  $scope.cardsPerPage = 25
  $scope.cardsPerPageSliderConfig =
    min: 1
    max: 100
    step: 1
    initial: 25