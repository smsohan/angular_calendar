(function() {
  var main;

  main = angular.module('Main', []);

  main.factory('Events', function() {
    return [
      {
        date: new Date(2013, 1, 1),
        start: '10:00 AM',
        end: '11:00 AM',
        name: 'Coffee&Code'
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
        year: '@'
      },
      templateUrl: 'calendar.html'
    };
  });

}).call(this);
