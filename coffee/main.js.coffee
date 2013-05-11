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

  $scope.addNewEvent = (month, year)->
    alert('Adding for ' + month + ' ' + year)


main.directive 'calendar', ->

  restrict: 'E'

  transclude: true

  scope:
    month: '@'
    year: '@'
    onClick: '&'

  templateUrl: 'calendar.html'

  controller: ($scope, $filter, Events) ->
    $scope.events = Events
    $scope.addEvent = (day) ->
      eventName = window.prompt('Event name', 'New event')
      $scope.events.push({day: day, name: eventName}) if !!eventName

    $scope.removeEvent = (event) ->
      $scope.events.splice($scope.events.indexOf(event), 1)

  link: (scope, element, attrs)->
    console.log element
    #draggable = DragDrop.bind(element)

main.filter 'range', ->
  (input, total) ->
    total = parseInt(total)
    i for i in [1..total]

main.filter 'eventsForDay', ->
  (events, day) ->
    event for event in events when event.day == day

main.filter 'truncate', ->
  (string, length) ->
    string.substring(0, length)