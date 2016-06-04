describe "Alerts", ->
  Alerts = null

  beforeEach ->
    module "KingsCourt"
    inject (_Alerts_) ->
      Alerts = _Alerts_

  it "alerts...", ->
    expect(Alerts.alerts).toEqual []

    Alerts.addAlert "Important alert"
    expect(Alerts.alerts[0].message).toEqual "Important alert"
    expect(Alerts.alerts[0].type).toEqual "info"

    Alerts.addAlert "Another alert", "warning"
    expect(Alerts.alerts[1].message).toEqual "Another alert"
    expect(Alerts.alerts[1].type).toEqual "warning"

    Alerts.addAlert "Yet another alert", "warning"
    Alerts.closeAlert 2
    expect(Alerts.alerts.length).toEqual 2

    Alerts.clearAlerts()
    expect(Alerts.alerts.length).toEqual 0
