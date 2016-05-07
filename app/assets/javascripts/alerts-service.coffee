angular.module('Dominion')
.factory 'AlertsService', (growl) ->
  new class AlertsService
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

angular.module('Dominion')
.controller 'AlertsCtrl', ($scope, AlertsService) ->
  $scope.alertsService = AlertsService