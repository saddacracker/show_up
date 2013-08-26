# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  # delete the meeting w/out refresh
  ($ '.meeting-list-delete').bind 'ajax:success', ->
    ($ this).closest('.meetings-listing').fadeOut()
  
  #  explicitely add tooltip
  ($ '[data-toggle="tooltip"]').tooltip()



# http://stackoverflow.com/questions/4664156/running-a-coffeescript-class-on-document-ready
class @ShowUp
  constructor: () -> 
    # return x * x # constructors require an explicit return

  getGeoLocation: () ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition(@setGeoCookie, @handleErrors);

  setGeoCookie: (position) ->
    cookie_val = position.coords.latitude + "|" + position.coords.longitude
    document.cookie = "lat_lng=" + escape(cookie_val)
  
  handleErrors: (error) ->
    switch(error.code)  
      when error.PERMISSION_DENIED then alert("user did not share geolocation data");  
      when error.POSITION_UNAVAILABLE then alert("could not detect current position");  
      when error.TIMEOUT then alert("retrieving position timed out");  
      else alert("unknown error");  
