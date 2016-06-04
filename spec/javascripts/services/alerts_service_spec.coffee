describe "Alerts", ->
  Alerts = null

  beforeEach ->
    module "KingsCourt"
    inject (_Alerts_) ->
      Alerts = _Alerts_

  it "alerts...", ->
    expect(Alerts.alerts).toEqual []

    Alerts.add "Important alert"
    expect(Alerts.alerts[0].message).toEqual "Important alert"

    Alerts.add "Another alert"
    expect(Alerts.alerts[1].message).toEqual "Another alert"

    Alerts.add "Yet another alert"
    Alerts.closeAlert 2
    expect(Alerts.alerts.length).toEqual 2
