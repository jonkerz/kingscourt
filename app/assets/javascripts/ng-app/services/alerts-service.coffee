angular.module 'KingsCourt'

.factory 'Alerts', ->
  new class Alerts
    constructor: -> @alerts = []

    addAlert: (message, type) ->
      @alerts.push
        message: message
        type: type ? 'info'

    clearAlerts: -> @alerts.splice 0, @alerts.length

    closeAlert: (index) -> @alerts.splice index, 1