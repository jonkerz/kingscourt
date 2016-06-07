angular.module "KingsCourt"

.controller "CardCtrl", ($scope, $http, ExpansionSelector, Card) ->
  $scope.allCards = Card.cards

  # TODO: Caching breaks dir-paginate
  $http.get("/api/v1/cards?randomizable=false").then (response) ->
    $scope.allCards = $scope.allCards.concat response.data

  $scope.currentPage = 1
  $scope.displayMode = "image"

  $scope.orderByField = "name"
  $scope.reverseSort = false

  # TODO: Super slow and duplicated in BuilderCtrl
  $scope.filterByExpansion = (card) ->
    ExpansionSelector.selected.indexOf(card.expansion_id) isnt -1

  $scope.cardDisplaySize = 110
  $scope.cardDisplaySizeSliderConfig =
    min: 50
    max: 400
    step: 1
    initial: 110
