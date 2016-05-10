angular.module('KingsCourt')
.factory 'API', ($resource, $http, $q, API_SERVER, Card) ->
  new class API
    deserializeCards = (cards) ->
      _.map cards, (cardId) -> Card.getCardById parseInt cardId, 10

    deserializeKingdom = (data, _header) ->
      transformedData = angular.fromJson(data)["kingdom"]
      transformedData.cards = deserializeCards transformedData.cards
      transformedData

    kingdoms: $resource "api/v1/kingdoms/:id", { id: '@id' },
      get:
        transformResponse: deserializeKingdom
      update:
        method: 'PUT'

    favorites: $resource "api/v1/u/my/favorites/:id", { id: '@id' }

    getCardAttributes: ->
      deferred = $q.defer()
      url =  "api/get_all_expansion_attributes/"
      $http.get(url, { cache: true }).success (response) ->
        deferred.resolve response

      return deferred.promise