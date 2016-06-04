describe 'Alerts:', ->

    AlertsService = null

    beforeEach ->
        module 'Dominion.Common'
        inject (_AlertsService_) ->
            AlertsService = _AlertsService_

    it 'alerts...', ->
        expect(AlertsService.alerts).toEqual []

        AlertsService.addAlert "Important alert"
        expect(AlertsService.alerts[0].message).toEqual "Important alert"
        expect(AlertsService.alerts[0].type).toEqual "info"

        AlertsService.addAlert "Another alert", "warning"
        expect(AlertsService.alerts[1].message).toEqual "Another alert"
        expect(AlertsService.alerts[1].type).toEqual "warning"

        AlertsService.addAlert "Yet another alert", "warning"
        AlertsService.closeAlert 2
        expect(AlertsService.alerts.length).toEqual 2

        AlertsService.clearAlerts()
        expect(AlertsService.alerts.length).toEqual 0