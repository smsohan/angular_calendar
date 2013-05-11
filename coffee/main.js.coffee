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
    $scope.addEvent = (day) ->
      eventName = window.prompt('Event name', 'New event')
      $scope.events.push({day: day, name: eventName})

    $scope.removeEvent = (event) ->
      $scope.events.splice($scope.events.indexOf(event), 1)

main.filter 'range', ->
  (input, total) ->
    total = parseInt(total)
    i for i in [1..total]

main.filter 'eventsForDay', ->
  (events, day) ->
    event for event in events when event.day == day

