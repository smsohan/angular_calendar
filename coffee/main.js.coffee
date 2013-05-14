main = angular.module('App', [])

main.factory 'Events', ->

  _allEvents =  [
    {id: 1, day: 5, name: 'Coffee&Code'}
    {id: 2, day: 18, name: 'Study'}
    {id: 3, day: 25, name: 'Nachos'}
  ]

  allEvents: _allEvents

  addEvent: (day, eventName) ->
    newId = _.max(_allEvents, (event)-> event.id).id + 1
    _allEvents.push({id: newId, day: day, name: eventName}) if !!eventName

  removeEvent: (event) ->
    _allEvents.splice(_allEvents.indexOf(event), 1)

  moveEvent: (eventToMove, toDay)->
    angular.forEach _allEvents, (event)->
      if event.id == eventToMove.id
        event.day = toDay

main.controller 'CalendarController', ($scope, Events) ->

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
      $scope.events.addEvent(day, eventName)

    $scope.removeEvent = $scope.events.removeEvent
    $scope.moveEvent = (eventToMove, toDay)->
      $scope.$apply -> $scope.events.moveEvent(eventToMove, toDay)


main.directive 'drag', ->

  link: (scope, element, attrs)->
    attrs.$set('draggable', true)

    element.bind 'dragstart', (ev)->
      ev.event = scope.event
      ev.dataTransfer.setData("Event", JSON.stringify(scope.event))


main.directive 'droppable', ->

  controller: ($scope, $element, $attrs)->
    $element.bind 'drop', (ev)->
      eventToMove = JSON.parse(ev.dataTransfer.getData('Event'))
      $scope.$parent.moveEvent eventToMove, $scope.day.day

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
