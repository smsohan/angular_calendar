main = angular.module('Main', [])

main.factory 'Events', ->
  [
    {date: new Date(2013, 1, 1), start: '10:00 AM', end: '11:00 AM', name: 'Coffee&Code'}
  ]

main.controller 'CalendarController', ($scope, Events)->

  $scope.calendar =
    month: 'January'
    year: 2013

  $scope.events = Events


main.directive 'calendar', ->

  restrict: 'E'

  transclude: true

  scope:
    month: '@'
    year: '@'

  templateUrl: 'calendar.html'
