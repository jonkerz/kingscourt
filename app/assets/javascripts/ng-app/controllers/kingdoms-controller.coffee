angular.module 'KingsCourt'

.controller 'KingdomsCtrl', ($route, $routeParams, $scope, $location, API, ExpansionSelector, Card) ->
  $scope.kingdoms = []
  $scope.totalKingdoms = 'loading...'
  $scope.displayMode = 'image'

  ExpansionSelector.setFromParams()

  getPageParam = ->
    page = $location.search().page
    return 1 unless page
    parseInt page, 10

  getMatchAllExpansionsParam = ->
    if $location.search().match_all_expansions?
      ExpansionSelector.matchAllExpansions = true

  $scope.pagination = current: getPageParam()
  getMatchAllExpansionsParam()

  getResultsPage = (pageNumber) ->
    params =
      page: pageNumber
      expansions: ExpansionSelector.selected.join ','
      match_all_expansions: ExpansionSelector.matchAllExpansions

    _.merge params, $scope.extraParams

    API.kingdoms.query params, (data) ->
      $scope.kingdoms = data.kingdoms
      $scope.totalKingdoms = data.meta.count

  setPageParams = (newPage) ->
    if newPage is 1
      $location.search 'page', null
    else
      $location.search 'page', parseInt(newPage, 10)

  setMatchAllExpansionsParam = ->
    if ExpansionSelector.matchAllExpansions
      $location.search 'match_all_expansions', "true"
    else
      $location.search 'match_all_expansions', null

  $scope.pageChanged = (newPage) ->
    # TODO refactor
    setPageParams newPage
    ExpansionSelector.setParams()
    setMatchAllExpansionsParam()

    getResultsPage newPage

  $scope.toggleFavorite = (kingdom) ->
    return if $scope.isSaving

    $scope.isSaving = true
    $scope.savingKingdomId = kingdom.id

    if kingdom.favorite
      API.favorites.delete { id: kingdom.id }, (data) ->
        kingdom.favorite_count--
        kingdom.favorite = not kingdom.favorite
        $scope.isSaving = false
    else
      API.favorites.save { kingdom_id: kingdom.id }, (data) ->
        kingdom.favorite_count++
        kingdom.favorite = not kingdom.favorite
        $scope.isSaving = false

  # "Child controllers"
  switch $route.current.$$route.params.view
    when "all_kingdoms"
      $scope.subtitle = 'Browsing kingdoms'

    when "my_kingdoms"
      $scope.subtitle = "Browsing my kingdoms"
      $scope.extraParams = my_kingdoms: true

    when "user_kingdoms"
      username = $routeParams.username
      $scope.subtitle = "Browsing #{username}'s kingdoms"
      $scope.extraParams = username: username

    when "my_favorites"
      $scope.subtitle = "Browsing my favorite kingdoms"
      $scope.extraParams = my_favorites: true

    when "user_favorites"
      favoriter = $routeParams.username
      $scope.subtitle = "Browsing #{favoriter}'s favorite kingdoms"
      $scope.extraParams = favoriter: favoriter

  do triggerInitialPageLoad = ->
    $scope.pageChanged $location.search().page || 1
