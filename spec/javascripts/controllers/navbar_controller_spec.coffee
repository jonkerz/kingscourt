describe "NavbarCtrl", ->
  $location = scope = createController = null

  beforeEach ->
    module "KingsCourt"
    inject ($rootScope, $controller, _$location_) ->
      scope = $rootScope.$new()
      $location = _$location_

      createController = ->
        $controller "NavbarCtrl", "$scope": scope

  describe "#isActive", ->
    it "checks if a route is active", ->
      controller = createController()
      $location.path "builder"
      expect($location.path()).toBe "/builder"
      expect(scope.isActive "/builder").toBe true
      expect(scope.isActive "/generator").toBe false
