describe "KingdomsCtrl", ->
  $location = scope = createController = Auth = null

  mockedCards = [
    {
      "id": 1
      "name": "Cellar"
      "type": 0
      "expansion": 0
      "cost": "2"
      "cost_in_coins": 2
      "text": "+1 Action<br />Discard any number of cards.<br />+1 Card per card discarded."
      "card_attributes": [
        "isAction"
        "givesActions"
        "givesOneCard"
      ]
    }
    {
      "id": 2
      "name": "Chapel"
      "type": 0
      "expansion": 0
      "cost": "2"
      "cost_in_coins": 2
      "text": "Trash up to 4 cards from your hand."
      "card_attributes": [
        "isAction"
        "isTrasher"
        "isTerminal"
      ]
    }
  ]

  beforeEach ->
    module "KingsCourt"
    module ($provide) ->
      $provide.constant "Cards", mockedCards

    inject ($rootScope, $controller) ->
      scope = $rootScope.$new()

      createController = ->
        $controller "KingdomsCtrl", "$scope": scope

  it "zzzzzzzz..", ->
      controller = createController()
      expect(scope.username).toBe null
