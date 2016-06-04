describe "Auth", ->
  Auth = null
  $httpBackend = API_SERVER = $localStorage = null

  beforeEach ->
    module "KingsCourt"
    localStorage.clear()
    module ($provide) ->
      $provide.constant "API_SERVER", "http://API_SERVER/"

    inject (_$httpBackend_, _$localStorage_, _Auth_) ->
      $httpBackend = _$httpBackend_
      $localStorage = _$localStorage_
      Auth = _Auth_
      API_SERVER = "http://API_SERVER/"

  it "check default values", ->
    expect(Auth.loggedIn).toBe false
    expect(Auth.username).toBe null
    expect(angular.isArray Auth.favoriteKingdoms).toBeTruthy()
    expect(Auth.favoriteKingdoms.length).toBe 0
    expect($localStorage.username).toBe undefined

  it "should login", ->
    $httpBackend.expectPOST("#{API_SERVER}login/").respond 200,
      username: "usernamez"
      favoriteexpansions: []
      token: "e4dfb313f0014a0ed552ecf6f0030832304253e3"
      favorite_kingdoms: [5]

    Auth.login("doesnt", "matter")
    $httpBackend.flush()
    expect(Auth.username).toBe "usernamez"

  it "should not log in on with bad credentials", ->
    $httpBackend.expectPOST("#{API_SERVER}login/").respond 400,
      error: "Looks like your username or password is wrong"

    Auth.login("doesnt", "matter")
    $httpBackend.flush()
    expect(Auth.loggedIn).toBe false

  it "localStorage should remember the login credentials but remove them on logout", ->
    $httpBackend.expectPOST("#{API_SERVER}login/").respond 200,
      username: "usernamez"
      favoriteexpansions: []
      token: "e4dfb313f0014a0ed552ecf6f0030832304253e3"
      favorite_kingdoms: [5]

    Auth.login("doesnt", "matter")
    $httpBackend.flush()

    expect($localStorage.username).toBe "usernamez"

    $httpBackend.expectPOST("#{API_SERVER}logout/").respond(200, {doesnt: "matter" })
    Auth.logout()
    $httpBackend.flush()

    expect($localStorage.username).toBe undefined

  it "should get user's favorites and add new, but no dups", ->
    $httpBackend.expectPOST("#{API_SERVER}login/").respond 200,
      username: "usernamez"
      favoriteexpansions: []
      token: "e4dfb313f0014a0ed552ecf6f0030832304253e3"
      favorite_kingdoms: [5]

    Auth.login("doesnt", "matter")
    $httpBackend.flush()

    expect(Auth.favoriteKingdoms).toEqual [5]
    Auth.addToFavoriteKingdomsList 10
    expect(Auth.favoriteKingdoms).toEqual [5, 10]
    Auth.addToFavoriteKingdomsList 10
    expect(Auth.favoriteKingdoms).toEqual [5, 10]
    Auth.removeFromFavoriteKingdomsList 5
    expect(Auth.favoriteKingdoms).toEqual [10]

    expect($localStorage.favoriteKingdoms).toEqual [10]

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()
