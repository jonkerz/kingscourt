describe "auth service:", ->
  AuthService = null
  $httpBackend = API_SERVER = $localStorage = null

  beforeEach ->
    module "Dominion.Auth"
    localStorage.clear()
    module ($provide) ->
      $provide.constant "API_SERVER", "http://API_SERVER/"

    inject (_$httpBackend_, _$localStorage_, _AuthService_) ->
      $httpBackend = _$httpBackend_
      $localStorage = _$localStorage_
      AuthService = _AuthService_
      API_SERVER = "http://API_SERVER/"

  it "check default values", ->
    expect(AuthService.loggedIn).toBe false
    expect(AuthService.username).toBe null
    expect(angular.isArray AuthService.favoriteKingdoms).toBeTruthy()
    expect(AuthService.favoriteKingdoms.length).toBe 0
    expect($localStorage.username).toBe undefined


  it "should login", ->
    $httpBackend.expectPOST("#{API_SERVER}login/").respond 200,
      username: "usernamez"
      favoriteexpansions: []
      token: "e4dfb313f0014a0ed552ecf6f0030832304253e3"
      favorite_kingdoms: [5]

    AuthService.login("doesnt", "matter")
    $httpBackend.flush()
    expect(AuthService.username).toBe "usernamez"

  it "should not log in on with bad credentials", ->
    $httpBackend.expectPOST("#{API_SERVER}login/").respond 400,
      error: "Looks like your username or password is wrong"

    AuthService.login("doesnt", "matter")
    $httpBackend.flush()
    expect(AuthService.loggedIn).toBe false

  it "localStorage should remember the login credentials but remove them on logout", ->
    $httpBackend.expectPOST("#{API_SERVER}login/").respond 200,
      username: "usernamez"
      favoriteexpansions: []
      token: "e4dfb313f0014a0ed552ecf6f0030832304253e3"
      favorite_kingdoms: [5]

    AuthService.login("doesnt", "matter")
    $httpBackend.flush()

    expect($localStorage.username).toBe "usernamez"

    $httpBackend.expectPOST("#{API_SERVER}logout/").respond(200, {doesnt: "matter" })
    AuthService.logout()
    $httpBackend.flush()

    expect($localStorage.username).toBe undefined


  it "should get user\"s favorites and add new, but no dups", ->
    $httpBackend.expectPOST("#{API_SERVER}login/").respond 200,
      username: "usernamez"
      favoriteexpansions: []
      token: "e4dfb313f0014a0ed552ecf6f0030832304253e3"
      favorite_kingdoms: [5]

    AuthService.login("doesnt", "matter")
    $httpBackend.flush()

    expect(AuthService.favoriteKingdoms).toEqual [5]
    AuthService.addToFavoriteKingdomsList 10
    expect(AuthService.favoriteKingdoms).toEqual [5, 10]
    AuthService.addToFavoriteKingdomsList 10
    expect(AuthService.favoriteKingdoms).toEqual [5, 10]
    AuthService.removeFromFavoriteKingdomsList 5
    expect(AuthService.favoriteKingdoms).toEqual [10]

    expect($localStorage.favoriteKingdoms).toEqual [10]

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()
