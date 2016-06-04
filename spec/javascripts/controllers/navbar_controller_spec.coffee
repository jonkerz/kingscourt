describe "Navbar:", ->
  $location = scope = createController = AuthService = null

  beforeEach ->
    module "Dominion.Navbar"
    inject ($rootScope, $controller, _$location_) ->
      scope = $rootScope.$new()
      $location = _$location_

      createController = ->
        $controller "NavbarCtrl", "$scope": scope

  it "isActive should work...", ->
    controller = createController()
    $location.path "builder"
    expect($location.path()).toBe "/builder"
    expect(scope.isActive("/builder")).toBe true
    expect(scope.isActive("/generator")).toBe false

  it "make sure that the authService is on the scope", ->
    controller = createController()
    expect(!!scope.authService).toBe true
