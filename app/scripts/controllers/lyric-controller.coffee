((app) ->
  "use strict"

  app.controller "LyricController", ->
    ($scope) ->
      $scope.lyricClass = ->
        {visible: $scope.lyric.visible}

) angular.module("true")