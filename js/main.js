(function() {
  var main;

  main = angular.module('Main', []);

  main.factory('Events', function() {
    return [
      {
        id: 1,
        day: 5,
        name: 'Coffee&Code'
      }, {
        id: 2,
        day: 18,
        name: 'Study'
      }, {
        id: 3,
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
    return $scope.events = Events;
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
        var day, _i;

        $scope.events = Events;
        $scope.days = [];
        for (day = _i = 1; _i <= 31; day = ++_i) {
          $scope.days.push({
            day: day
          });
        }
        $scope.addEvent = function(day) {
          var eventName, newId;

          eventName = window.prompt('Event name', 'New event');
          newId = _.max($scope.events, function(event) {
            return event.id;
          }) + 1;
          if (!!eventName) {
            return $scope.events.push({
              id: newId,
              day: day,
              name: eventName
            });
          }
        };
        $scope.removeEvent = function(event) {
          return $scope.events.splice($scope.events.indexOf(event), 1);
        };
        return $scope.moveEvent = function(draggedEvent, toDay) {
          return angular.forEach($scope.events, function(event) {
            if (event.id === draggedEvent.id) {
              return $scope.$apply(function() {
                return event.day = toDay;
              });
            }
          });
        };
      }
    };
  });

  main.directive('drag', function() {
    return {
      scope: {
        event: '=drag'
      },
      link: function(scope, element, attrs) {
        attrs.$set('draggable', true);
        return element.bind('dragstart', function(ev) {
          ev.event = scope.event;
          return ev.dataTransfer.setData("Event", JSON.stringify(scope.event));
        });
      }
    };
  });

  main.directive('droppable', function() {
    return {
      controller: function($scope, $element, $attrs) {
        $element.bind('drop', function(ev) {
          var draggedEvent;

          draggedEvent = JSON.parse(ev.dataTransfer.getData('Event'));
          return $scope.$parent.moveEvent(draggedEvent, $scope.day.day);
        });
        return $element.bind('dragover', function(ev) {
          return ev.preventDefault();
        });
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
