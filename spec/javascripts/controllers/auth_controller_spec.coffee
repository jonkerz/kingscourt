describe "AuthCtrl", ->
  $location = scope = createController = Auth = null

  beforeEach ->
    module "KingsCourt"
    inject ($rootScope, $controller) ->
      scope = $rootScope.$new()

      createController = ->
        $controller "AuthCtrl", "$scope": scope

  it "register() should be a function...", ->
    controller = createController()
    expect(typeof scope.register).toBe "function"
