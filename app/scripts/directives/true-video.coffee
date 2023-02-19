((app) ->
  "use strict"

  app.directive "trueVideo", ->
    (scope, element, attrs) ->
      video = element[0]
      width = 720
      height = 404

      scope.$parent.videoReference = element

      element.css('margin-top', "-#{height / 2}px")
      element.css('margin-left', "-#{width / 2}px")

      makeVideoFill = ->
        ratio = width / height
        windowRatio = window.innerWidth / window.innerHeight
        if (windowRatio > ratio)
          element.css('width', "#{window.innerWidth}px")
          element.css('margin-left', "-#{window.innerWidth / 2}px")
          newHeight = (window.innerWidth / ratio)
          element.css('height', "#{newHeight}px")
          element.css('margin-top', "-#{newHeight / 2}px")
        else
          newWidth = (window.innerHeight * ratio)
          element.css('width', "#{newWidth}px")
          element.css('margin-left', "-#{newWidth / 2}px")
          element.css('height', "#{window.innerHeight}px")
          element.css('margin-top', "-#{window.innerHeight / 2}px")
      makeVideoFill()
      angular.element(window).bind('resize', makeVideoFill)
      angular.element(window).bind('orientationchange', makeVideoFill)      

      element.bind 'loadedmetadata', ->
        video.currentTime = 0
        scope.duration = Math.round video.duration

      element.bind 'timeupdate', ->
        if scope.playing
          scope.currentTime = Math.round video.currentTime
          updatedProgress = Math.round (scope.currentTime / scope.duration) * 100
          unless updatedProgress is scope.progress
            scope.progress = updatedProgress
            scope.$apply()

      video.load()

      scope.$on 'play', ->
        scope.playing = true

        video.play()
        nextLyricId = 0

        watchForChanges = ->
          currentTime = video.currentTime
          
          if scope.data?
            currentTime = video.currentTime
            nextLyric = scope.data[nextLyricId]
            if(currentTime > nextLyric.time)
              scope.currentLyric = nextLyric
              scope.currentLyric.visible = true
              scope.$apply()
              nextLyricId++
            if scope.data.length > nextLyricId
              window.requestAnimationFrame(watchForChanges)
            else
              setTimeout ->
                scope.ended = true
                scope.$apply()
              , 30000

        window.requestAnimationFrame(watchForChanges)

) angular.module("true")