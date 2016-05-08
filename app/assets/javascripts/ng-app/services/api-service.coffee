angular.module('KingsCourt')
.factory 'APIService', ($resource, $http, $q, API_SERVER, CardService) ->
  new class APIService
    deserializeCards = (cards) ->
      _.map cards, (card_id) -> CardService.getCardById parseInt card_id, 10

    deserializeKingdom = (data, _header) ->
      transformedData = angular.fromJson data
      transformedData.cards = deserializeCards transformedData.cards
      transformedData

    kingdoms: $resource "api/v1/kingdoms/:id/", { id: '@id' },
      get:
        transformResponse: deserializeKingdom
      update:
        method: 'PUT'

    favorites: $resource "#{API_SERVER}u/username/favorites/:id/", { id: '@id' },
      save:
        method: 'GET'

    getCardAttributes: ->
      deferred = $q.defer()

      url =  "#{API_SERVER}get_all_expansion_attributes/"

      $http.get(url, { cache: true }).success (response) ->
        deferred.resolve response

      return deferred.promise