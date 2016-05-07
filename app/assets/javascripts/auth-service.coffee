angular.module('KingsCourt')
.factory 'AuthService', ($rootScope, $http, $q, API_SERVER, AlertsService, $localStorage) ->
  new class AuthService
    constructor: ->
      @loggedIn = false
      @username = null
      @favoriteKingdoms = []

      if $localStorage.username
        @loggedIn = true
        @username = $localStorage.username
        @favoriteKingdoms = ($localStorage.favoriteKingdoms).toString().split(',').map (x) -> parseInt x

    addToFavoriteKingdomsList: (id) ->
      if not _.contains @favoriteKingdoms, id
        @favoriteKingdoms.push id
        $localStorage.favoriteKingdoms = @favoriteKingdoms

    removeFromFavoriteKingdomsList: (id) ->
      if _.contains @favoriteKingdoms, id
        @favoriteKingdoms = _.without @favoriteKingdoms, id
        $localStorage.favoriteKingdoms = @favoriteKingdoms

    login: (username, password) -> @authenticate username, password, 'login/'

    register: (username, password) -> @authenticate username, password, 'register/'

    authenticate: (username, password, endpoint) ->
      console.log "in authenticate"
      url = API_SERVER + endpoint
      deferred = $q.defer()

      $http.post(url, "username=#{username}&password=#{password}",
        headers:
          'Content-Type': 'application/x-www-form-urlencoded'
      ).then ((response) =>

        token = response.data.token
        username = response.data.username
        favoriteKingdoms = response.data.favorite_kingdoms

        if token and username
          @loggedIn = true
          @username = username

          if favoriteKingdoms is undefined
            favoriteKingdoms = []

          @favoriteKingdoms = favoriteKingdoms.map (x) -> parseInt x
          $localStorage.token = token
          $localStorage.username = username
          $localStorage.favoriteKingdoms = favoriteKingdoms

          $rootScope.$broadcast 'loggedIn', 'logged in'
          console.log "in broadcast"
          return deferred.resolve
        else
            deferred.reject 'Invalid data received from server'
      ), (response) =>
          deferred.reject response.data.error

      return deferred.promise

    logout: ->
      deferred = $q.defer()
      url = "#{API_SERVER}logout/"

      $http.post(url).then (=>
        $localStorage.$reset()
        @loggedIn = false
        AlertsService.clearAlerts()
        deferred.resolve()
      ), (error) =>
        $localStorage.$reset()
        @loggedIn = false
        AlertsService.clearAlerts()
        deferred.reject error.data.error

      return deferred.promise