(function() {
  var main;

  main = angular.module('App', ['btford.dragon-drop']);

  main.factory('Events', function() {
    return [
      {
        day: 5,
        name: 'Coffee&Code'
      }, {
        day: 18,
        name: 'Study'
      }, {
        day: 25,
        name: 'Nachos'
      }
    ];
  });

  main.controller('CalendarController', function($scope, Events) {
    $scope.calendar = {
      month: 'January',
      year: 2013
    };
    $scope.events = Events;
    return $scope.addNewEvent = function(month, year) {
      return alert('Adding for ' + month + ' ' + year);
    };
  });

  main.directive('calendar', function() {
    return {
      restrict: 'E',
      transclude: true,
      scope: {
        month: '@',
        year: '@',
        onClick: '&'
      },
      templateUrl: 'calendar.html',
      controller: function($scope, $filter, Events) {
        $scope.events = Events;
        $scope.addEvent = function(day) {
          var eventName;

          eventName = window.prompt('Event name', 'New event');
          if (!!eventName) {
            return $scope.events.push({
              day: day,
              name: eventName
            });
          }
        };
        return $scope.removeEvent = function(event) {
          return $scope.events.splice($scope.events.indexOf(event), 1);
        };
      }
    };
  });

  main.filter('range', function() {
    return function(input, total) {
      var i, _i, _results;

      total = parseInt(total);
      _results = [];
      for (i = _i = 1; 1 <= total ? _i <= total : _i >= total; i = 1 <= total ? ++_i : --_i) {
        _results.push(i);
      }
      return _results;
    };
  });

  main.filter('eventsForDay', function() {
    return function(events, day) {
      var event, _i, _len, _results;

      _results = [];
      for (_i = 0, _len = events.length; _i < _len; _i++) {
        event = events[_i];
        if (event.day === day) {
          _results.push(event);
        }
      }
      return _results;
    };
  });

  main.filter('truncate', function() {
    return function(string, length) {
      return string.substring(0, length);
    };
  });

}).call(this);
