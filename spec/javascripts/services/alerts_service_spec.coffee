describe "Alerts", ->
  Alerts = null

  beforeEach ->
    module "KingsCourt"
    inject (_Alerts_) -> Alerts = _Alerts_

  beforeEach ->
    expect(Alerts.alerts).toEqual []

  describe "#add", ->
    it "adds", ->
      Alerts.add "Important alert"
      expect(Alerts.alerts[0].message).toEqual "Important alert"

      Alerts.add "Another alert"
      expect(Alerts.alerts[1].message).toEqual "Another alert"

      expect(Alerts.alerts.length).toEqual 2

  describe "#remove", ->
    it "removes by index", ->
      Alerts.add "Important alert"
      Alerts.add "Another alert"
      Alerts.add "Yet another alert"

      expect(Alerts.alerts.length).toEqual 3

      Alerts.remove 2
      expect(Alerts.alerts.length).toEqual 2
