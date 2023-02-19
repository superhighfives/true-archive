((app) ->
  "use strict"

  app.directive "lyric", ->
    (scope, element, attrs) ->
      scope.$watch 'lyric.id', (id) ->
        scope.id = id
      scope.$watch 'lyric.visible', (isVisible) ->
        if isVisible && scope.id == 0
          setTimeout ->
            element.hide()
          , 2000

) angular.module("true")