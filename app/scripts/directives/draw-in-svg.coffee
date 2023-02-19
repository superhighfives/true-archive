((app) ->
  "use strict"

  animation = false

  timeout = 0
  letters = []

  app.directive "svgDrawIn", ->
    (scope, element, attrs) ->
      svgElem = element.find("svg")
      svg = Snap(svgElem[0])

      svg.selectAll("g").forEach (group) ->
        group.selectAll("path").forEach (elem) ->
          elemLength = elem.getTotalLength()

          elem.data =
            length: elemLength
            current_frame: 0
            total_frames: 60

          elem.attr
            opacity: 0
            strokeDasharray: elemLength + " " + elemLength
            strokeDashoffset: elemLength  

        setTimeout ->
          letters.push group
        , timeout * 1000
        timeout++

      draw = ->
        letters.forEach (group) ->
          group.selectAll("path").forEach (elem) ->
            elem.data.group = group
            progress = elem.data.current_frame / elem.data.total_frames
            if progress >= 5
              elem.data.complete = true
              letters = letters.filter (letter) -> letter isnt elem.data.group
            if !elem.data.complete
              elem.data.current_frame++
              elem.attr
                strokeDashoffset: Math.floor(elem.data.length * (1 - progress))
                opacity: progress
        if !letters.length
          scope.animating = false
          scope.$emit 'animationComplete', true
        if scope.animating
          animation = window.requestAnimationFrame(draw)
      
      startAnimation = ->
        setTimeout ->
          scope.animating = true
          draw()
        , 0

      startAnimation()

) angular.module("true")