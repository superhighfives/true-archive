(->
  app = angular.module('true', [])

  app.controller 'MainCtrl', [
    '$scope', '$http'
    ($scope, $http) ->

      requestAnimationFrame = window.requestAnimationFrame or window.mozRequestAnimationFrame or window.webkitRequestAnimationFrame or window.msRequestAnimationFrame
      window.requestAnimationFrame = requestAnimationFrame

      document.ontouchmove = (e) ->
        if !$scope.unsupported()
          e.preventDefault()

      $scope.replay = ->
        location.reload()

      $scope.isiPhone = ->
        navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPod/i)

      $scope.unsupported = ->
        !Modernizr.cssanimations || !Modernizr.csstransitions || !Modernizr.video || !Modernizr.opacity || !window.requestAnimationFrame || $scope.isiPhone()

      $scope.webaudio = ->
        Modernizr.webaudio

      $scope.data = []
      $scope.data_endpoint = "data/data.json"

      $scope.dataLoading = true
      $http.get($scope.data_endpoint).success (response) ->
        $scope.data = response.data

      $scope.$watch 'data', ->
        if $scope.data.length
          $scope.dataLoaded = true

      $scope.$on 'animationComplete', (event, data) ->
        if data
          $scope.animationComplete = true
          $scope.$apply()

      $scope.$watch 'dataLoaded', ->
        if $scope.dataLoaded
          $scope.ready = true
          $scope.status = "Play"

      $scope.start = ->
        $scope.playing = true
        $scope.$broadcast 'play'
  ]

)()