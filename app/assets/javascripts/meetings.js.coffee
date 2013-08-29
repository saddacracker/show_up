# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  # delete the meeting w/out refresh
  ($ '.meeting-list-delete').bind 'ajax:success', ->
    ($ this).closest('.meetings-listing').fadeOut()
  
  # tooltip
  ($ '[data-toggle="tooltip"]').tooltip()


  # set directions link to use accurate locaton for start address
  if ($ '.meetings-detail-directions-btn').length > 0
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) ->
        # var geolocate = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        daddr = ($ '.meetings-detail-directions-btn').data "daddr" 
        saddr = position.coords.latitude + ',' + position.coords.longitude
        new_href = "http://maps.google.com?saddr="+saddr+"&daddr="+daddr
        ($ '.meetings-detail-directions-btn').attr('href', new_href);
      
        # switch(error.code)  
        #   when error.PERMISSION_DENIED then alert("user did not share geolocation data");  
        #   when error.POSITION_UNAVAILABLE then alert("could not detect current position");  
        #   when error.TIMEOUT then alert("retrieving position timed out");  
        #   else alert("unknown error");
  



# http://stackoverflow.com/questions/4664156/running-a-coffeescript-class-on-document-ready
# class ShowUp
#   _latitude = -> 0
#   _longitude = -> 0
#   
#   constructor: () -> 
#     # return x * x # constructors require an explicit return
# 
#   geoLocate: () ->
#     if navigator.geolocation
#       navigator.geolocation.getCurrentPosition(@setPosition, @handleErrors);
# 
#   setPosition: (position) ->
#     @_latitude   = -> position.coords.latitude
#     @_longitude  = -> position.coords.longitude
#     # @setCookie(position)
#    
#   getLatitude:  -> @_latitude() 
#   getLongitude: -> @_longitude() 
#     
#   setCookie: (position) ->
#     cookie_val = position.coords.latitude + "|" + position.coords.longitude
#     document.cookie = "lat_lng=" + escape(cookie_val)
#   
#   handleErrors: (error) ->
#     switch(error.code)  
#       when error.PERMISSION_DENIED then alert("user did not share geolocation data");  
#       when error.POSITION_UNAVAILABLE then alert("could not detect current position");  
#       when error.TIMEOUT then alert("retrieving position timed out");  
#       else alert("unknown error");  
