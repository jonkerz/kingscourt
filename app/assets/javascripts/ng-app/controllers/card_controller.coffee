angular.module "KingsCourt"

.controller "CardCtrl", ($scope, $http, ExpansionSelector, Card, API_SERVER) ->
  $scope.allCards = Card.cards

  # TODO Caching breaks dir-paginate
  $http.get("/api/v1/cards?non_randomizers_only=true").then (response) ->
    $scope.allCards = $scope.allCards.concat response.data

  $scope.currentPage = 1
  $scope.displayMode = "image"

  $scope.orderByField = "name"
  $scope.reverseSort = false

  $scope.filterByExpansion = (card) ->
    ExpansionSelector.selected.indexOf(card.expansion_id) isnt -1

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
