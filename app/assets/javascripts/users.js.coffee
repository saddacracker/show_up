# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ($) ->
  # http://stackoverflow.com/questions/6060968/rails-global-storage-for-js-variable
  # somewhere in controllers ...cookie[:latitude]...
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition (position) ->
      document.cookie = document.cookie + '; latitude=pos.coords.latitude; longitude=pos.coords.longitude'

