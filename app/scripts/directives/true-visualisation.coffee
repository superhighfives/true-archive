((app) ->
  "use strict"

  javascriptNode = undefined

  app.directive "trueVisualisation", ->
    (scope, element, attrs) ->

      if Modernizr.webaudio
        scope.supported = true

        window.AudioContext = window.AudioContext || window.webkitAudioContext

        video = scope.$parent.videoReference

        context = new AudioContext()
        audioBuffer = sourceNode = analyser = javascriptNode = average = contentWidth = contentHeight = undefined

        ctx = element[0].getContext("2d")
        
        scope.$on 'play', ->
          context.resume()

        onResize = ->
          contentWidth = window.innerWidth
          contentHeight = window.innerHeight
          ctx.canvas.width = contentWidth
          ctx.canvas.height = contentHeight
        onResize()
        angular.element(window).bind('resize', onResize)

        setupAudioNodes = ->
          # setup a javascript node
          javascriptNode = context.createScriptProcessor(2048, 1, 1)
          
          # connect to destination, else it isn't called
          javascriptNode.connect context.destination
          
          # setup a analyzer
          analyser = context.createAnalyser()
          analyser.smoothingTimeConstant = 0.5
          analyser.fftSize = 512
          
          # create a buffer source node
          sourceNode = context.createMediaElementSource(video[0])
          sourceNode.connect analyser
          analyser.connect javascriptNode
          sourceNode.connect context.destination
          return
        setupAudioNodes()

        javascriptNode.onaudioprocess = ->
          array = new Uint8Array(analyser.frequencyBinCount)
          analyser.getByteFrequencyData array
          ctx.clearRect 0, 0, contentWidth, contentHeight
          average = getAverageVolume(array)          
          drawSpectrum array
          return

        getAverageVolume = (array) ->
          values = 0
          average = undefined
          length = array.length
          
          # get all the frequency amplitudes
          i = 0

          while i < length
            values += array[i]
            i++
          average = values / length
          average
        drawSpectrum = (array) ->
          i = 0

          ctx.stroke()
          ctx.beginPath()          

          vYCenter = (contentHeight / 5) * 1.725

          while i < (array.length)
            value = array[i] * (contentHeight / 500)

            vX = i * Math.round(contentWidth / 160)
            vY = vYCenter + (value / 2)
            vWidth = (Math.round(contentWidth / 1024) + (average / 48))
            vHeight = -value

            ctx.fillStyle = "rgba(255, 255, 255, " + average / 250 + ")"
            ctx.fillRect vX, vY, vWidth * (average / 75), vHeight

            ctx.lineWidth = 1
            ctx.strokeStyle = "rgba(255, 255, 255, 0.5)"
            ctx.lineTo vX, vYCenter + (value / 2)
            ctx.moveTo vX + 1, vYCenter - (value / 2)
            
            i++
          return

) angular.module("true")
