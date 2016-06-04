angular.module "KingsCourt"

.controller "KingdomCtrl", ($rootScope, $scope, $location, $routeParams, Alerts, Kingdom, API) ->
  id = $routeParams.id

  setTitle = (name) ->
    $rootScope.title = $rootScope.title.replace /^A kingdom/, name

  setupKingdom = (kingdom) ->
    $scope.kingdom = Kingdom.getOrCreate "detail"

    $scope.kingdom.id = kingdom.id
    $scope.kingdom.name = kingdom.name
    $scope.kingdom.cards = kingdom.cards
    $scope.kingdom.description = kingdom.description
    $scope.kingdom.username = kingdom.username
    $scope.kingdom.created_at = kingdom.created_at

  setupDisqus = (kingdom) ->
    $scope.disqusConfig =
      disqus_shortname: "kingscourt"
      disqus_identifier: "kingdoms/#{kingdom.id}"
      disqus_url: "http://kingscourt.io/#!/kingdoms/#{kingdom.id}"

  API.kingdoms.get id: id, (data) ->
    kingdom = data
    setTitle kingdom.name
    setupKingdom kingdom
    setupDisqus kingdom

  $scope.deleteKingdom = (id) ->
    API.kingdoms.delete id: id, (data) ->
      Alerts.add "Successfully deleted #{$scope.kingdom.name}."
      $location.path "my_kingdoms"

  $scope.openInBuilder = ->
    builderKingdom = Kingdom.getOrCreate "builder"

    builderKingdom.id = $scope.kingdom.id
    builderKingdom.name = $scope.kingdom.name
    builderKingdom.cards = $scope.kingdom.cards
    builderKingdom.description = $scope.kingdom.description

    $location.path "builder"
