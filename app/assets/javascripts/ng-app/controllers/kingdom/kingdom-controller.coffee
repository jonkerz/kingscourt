angular.module('KingsCourt')
.controller 'KingdomCtrl', ($scope, AuthService, AlertsService, APIService, API_KINGDOMS_PER_PAGE, ExpansionSelectorService) ->
  $scope.authService = AuthService
  $scope.expansionSelectorService = ExpansionSelectorService
  $scope.username = null
  $scope.username_faves = null
  $scope.kingdoms = []
  $scope.totalKingdoms = 'not set'
  $scope.totalKingdomsAll = 0
  $scope.kingdomsPerPage = API_KINGDOMS_PER_PAGE
  $scope.displayMode = 'images'
  $scope.pagination = current: 1

  getResultsPage = (pageNumber) ->
    params =
      page: pageNumber
      username: $scope.username
      username_faves: $scope.username_faves
      expansions: ExpansionSelectorService.unselectedExpansions().join '_'

    APIService.kingdoms.query params, (data) ->
      kingdoms = data.results
      favoriteKingdoms = AuthService.favoriteKingdoms

      for kingdom in kingdoms
        kingdom.favorite = _.contains favoriteKingdoms, kingdom.id

      $scope.kingdoms = kingdoms
      $scope.totalKingdoms = data.count
      $scope.totalKingdomsAll = data.count_all

  $scope.pageChanged = (newPage) -> getResultsPage newPage

  $scope.toggleFavorite = (kingdom) ->
    return if $scope.isSaving

    $scope.isSaving = true
    $scope.savingKingdomId = kingdom.id

    if kingdom.favorite
      APIService.favorites.delete { id: kingdom.id }, (data) ->
        AuthService.removeFromFavoriteKingdomsList kingdom.id
        kingdom.favorites_count--
        kingdom.favorite = not kingdom.favorite
        $scope.isSaving = false
    else
      APIService.favorites.save { id: kingdom.id }, (data) ->
        AuthService.addToFavoriteKingdomsList kingdom.id
        kingdom.favorites_count++
        kingdom.favorite = not kingdom.favorite
        $scope.isSaving = false