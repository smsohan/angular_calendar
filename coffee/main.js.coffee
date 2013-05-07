main = angular.module('Main', [])

db = main.factory 'DB', ->
  window.localStorage

main.factory 'Events', (DB)->
  allEvents = [
    {date: new Date(2013, 1, 1), start: '10:00 AM', end: '11:00 AM', name: 'Coffee & Code'}
  ]

  DB.setItem 'Events', JSON.stringify(allEvents)

  JSON.parse DB.getItem('Events')

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