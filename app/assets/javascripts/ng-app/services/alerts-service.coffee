angular.module 'KingsCourt'

.factory 'Alerts', (growl) ->
  new class Alerts
    constructor: -> @alerts = []

    addAlert: (message, type) ->
      @alerts.push
        message: message
        type: type ? 'info'
      type = 'info'
      #growl.info "No card found!."
      growl[type] message
      console.log message, type

    clearAlerts: -> @alerts.splice 0, @alerts.length

    closeAlert: (index) -> @alerts.splice index, 1