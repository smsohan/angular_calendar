main = angular.module('Main', [])

main.factory 'Events', ->
  [
    {id: 1, day: 5, name: 'Coffee&Code'}
    {id: 2, day: 18, name: 'Study'}
    {id: 3, day: 25, name: 'Nachos'}
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
    onClick: '&'

  templateUrl: 'calendar.html'

  controller: ($scope, $filter, Events) ->
    $scope.events = Events

    $scope.days = []
    for day in [1..31]
      $scope.days.push
        day: day

    $scope.addEvent = (day) ->
      eventName = window.prompt('Event name', 'New event')
      newId = _.max($scope.events, (event)-> event.id) + 1
      $scope.events.push({id: newId, day: day, name: eventName}) if !!eventName

    $scope.removeEvent = (event) ->
      $scope.events.splice($scope.events.indexOf(event), 1)

    $scope.moveEvent = (draggedEvent, toDay)->
      angular.forEach $scope.events, (event)->
        if event.id == draggedEvent.id
          $scope.$apply -> event.day = toDay


main.directive 'drag', ->
  scope:
    event: '=drag'

  link: (scope, element, attrs)->
    attrs.$set('draggable', true)

    element.bind 'dragstart', (ev)->
      ev.event = scope.event
      ev.dataTransfer.setData("Event", JSON.stringify(scope.event))


main.directive 'droppable', ->

  controller: ($scope, $element, $attrs)->
    $element.bind 'drop', (ev)->
      draggedEvent = JSON.parse(ev.dataTransfer.getData('Event'))
      $scope.$parent.moveEvent draggedEvent, $scope.day.day

    $element.bind 'dragover', (ev)->
      ev.preventDefault()


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