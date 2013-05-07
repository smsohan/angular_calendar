(function() {
  var db, main;

  main = angular.module('Main', []);

  db = main.factory('DB', function() {
    return window.localStorage;
  });

  main.factory('Events', function(DB) {
    var allEvents;

    allEvents = [
      {
        date: new Date(2013, 1, 1),
        start: '10:00 AM',
        end: '11:00 AM',
        name: 'Coffee & Code'
      }
    ];
    DB.setItem('Events', JSON.stringify(allEvents));
    return JSON.parse(DB.getItem('Events'));
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
      templateUrl: 'calendar.html'
    };
  });

}).call(this);
