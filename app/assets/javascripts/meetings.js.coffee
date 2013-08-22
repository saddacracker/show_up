# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  ($ '.meeting-list-delete').bind 'ajax:success', ->
    ($ this).closest('.meetings-listing').fadeOut()
    
  ($ '[data-toggle="tooltip"]').tooltip()
  
  # Provide a better start address for directions if the user has geolocation
  if ($ '.meetings-detail-directions-btn').length > 0
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition (position) ->
        # var geolocate = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        daddr = ($ '.meetings-detail-directions-btn').data "daddr" 
        saddr = position.coords.latitude + ',' + position.coords.longitude
        new_href = "http://maps.google.com?saddr="+saddr+"&daddr="+daddr
        ($ '.meetings-detail-directions-btn').attr('href', new_href);
        
        # if err.code == 0 
        #   # no error?
        # if err.code == 1
        #   # Access denied by user
        # if err.code == 2
        #   # Position unavailable
        # if err.code == 3
        #   # Timed out





  
