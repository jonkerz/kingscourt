describe "AuthCtrl:", ->
  $location = scope = createController = AuthService = null

  beforeEach ->
    module "Dominion.Auth"
    inject ($rootScope, $controller) ->
      scope = $rootScope.$new()

      createController = ->
        $controller "AuthCtrl", "$scope": scope

  it "register() should be a function...", ->
    controller = createController()
    expect(typeof scope.register).toBe "function"
