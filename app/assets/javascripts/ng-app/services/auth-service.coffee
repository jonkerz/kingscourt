# TODO
angular.module('KingsCourt')
.factory 'Auth', ($rootScope, $http, $q, Alerts, $localStorage) ->
  new class Auth
    constructor: ->
      @favoriteKingdoms = []

      if $localStorage.username
        @favoriteKingdoms = ($localStorage.favoriteKingdoms).toString().split(',').map (x) -> parseInt x

    addToFavoriteKingdomsList: (id) ->
      if not _.contains @favoriteKingdoms, id
        @favoriteKingdoms.push id
        $localStorage.favoriteKingdoms = @favoriteKingdoms

    removeFromFavoriteKingdomsList: (id) ->
      if _.contains @favoriteKingdoms, id
        @favoriteKingdoms = _.without @favoriteKingdoms, id
        $localStorage.favoriteKingdoms = @favoriteKingdoms

###
    authenticate: ...
        #...
        favoriteKingdoms = response.data.favorite_kingdoms
          if favoriteKingdoms is undefined
            favoriteKingdoms = []

          @favoriteKingdoms = favoriteKingdoms.map (x) -> parseInt x
          $localStorage.favoriteKingdoms = favoriteKingdoms

    logout: ->
      # ...
        $localStorage.$reset()
        Alerts.clearAlerts()
###