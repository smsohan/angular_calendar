main = angular.module('Main', [])

main.factory 'Events', ->
  [
    {day: 5, name: 'Coffee&Code'}
    {day: 18, name: 'Study'}
    {day: 25, name: 'Nachos'}
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

  controller: ($scope, $filter, Events) ->
    console.log Events
    $scope.events = Events

main.filter 'range', ->
  (input, total) ->
    total = parseInt(total)
    i for i in [1..total]

main.filter 'eventsForDay', ->
  (events, day) ->
    event for event in events when event.day == day
