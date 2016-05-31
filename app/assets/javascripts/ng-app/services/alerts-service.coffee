angular.module "KingsCourt"

.factory "Alerts", ->
  new class Alerts
    constructor: -> @alerts = []

    add: (message) -> @alerts.push message: message

    closeAlert: (index) -> @alerts.splice index, 1
