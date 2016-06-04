angular.module "KingsCourt"

.factory "API", ($resource, $http, $q, Card) ->
  new class API
    _deserializeCards = (cards) -> _.map cards, (id) -> Card.getById id

    _deserializeKingdom = (data, _header) ->
      transformedData = angular.fromJson(data)["kingdom"]
      transformedData.cards = _deserializeCards transformedData.cards
      transformedData

    _deserializeKingdoms = (data, _header) ->
      transformedData = angular.fromJson(data)
      kingdoms = transformedData["kingdoms"]
      return transformedData unless kingdoms

      for kingdom in kingdoms
        kingdom.cards = _deserializeCards kingdom.cards
      transformedData

    kingdoms: $resource "api/v1/kingdoms/:id/", { id: "@id" },
      query:
        transformResponse: _deserializeKingdoms
      get:
        transformResponse: _deserializeKingdom
      update:
        method: "PUT"

    favorites: $resource "api/v1/u/my/favorites/:id", { id: "@id" }

    getCardAttributes: ->
      deferred = $q.defer()

      url =  "api/v1/expansions?card_attributes=true"
      $http.get(url, cache: true).success (response) ->
        deferred.resolve response

      deferred.promise
