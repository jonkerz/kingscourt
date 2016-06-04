describe "CardCtrl", ->
  $location = scope = createController = null

  mockedCards = [
    {
      "id": 1
      "name": "Cellar"
      "cost_in_text": "2"
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
      "cost_in_text": "2"
      "cost_in_coins": 2
      "text": "Trash up to 4 cards from your hand."
      "card_attributes": [
        "isAction"
        "trasher"
        "terminal"
      ]
    }
  ]

  beforeEach ->
    module "KingsCourt"
    module ($provide) ->
      $provide.constant "Cards", mockedCards

    inject ($rootScope, $controller, _$location_) ->
      scope = $rootScope.$new()
      $location = _$location_

      createController = ->
        $controller "CardCtrl", "$scope": scope

  it "isActive should work...", ->
    controller = createController()
    expect(scope.selectedCard).toBe null
    scope.setSelectedCard mockedCards[0]
    expect(scope.selectedCard.name).toBe "Cellar"
