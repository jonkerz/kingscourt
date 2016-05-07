angular.module('KingsCourt')
.factory 'APIService', ($resource, $http, $q, API_SERVER, CardService) ->
  new class APIService
    deserialize_cards = (cards) -> _.map cards, (card_id) -> CardService.getCardById parseInt card_id, 10

    deserialize_cards_in_kingdom = (data, header) ->
      transformedData = angular.fromJson data
      transformedData.cards = deserialize_cards transformedData.cards
      return transformedData

    deserialize_cards_in_all_kingdoms = (data, header) ->
      transformedData = angular.fromJson data
      for kingdom in transformedData.results
        kingdom.cards = deserialize_cards kingdom.cards
      return transformedData

    kingdoms: $resource "#{API_SERVER}kingdoms/:id/", { id: '@id' },
      query:
        isArray: false
        transformResponse: deserialize_cards_in_all_kingdoms
      get:
        transformResponse: deserialize_cards_in_kingdom
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