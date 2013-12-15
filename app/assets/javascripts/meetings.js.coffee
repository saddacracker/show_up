# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  # delete the meeting w/out refresh
  ($ '.meeting-list-delete').bind 'ajax:success', ->
    ($ this).closest('.meetings-listing').fadeOut()
  
  # tooltip
  ($ '[data-toggle="tooltip"]').tooltip()
  
  # affix map
  ($ '.meetings-map-container').affix
    offset:
      top: ($ '.meetings-search-container').height() + ($ '#meetingsMainNavBar').height()

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

  
  ($ "[data-meeting]" ).click (e) ->
    e.preventDefault()   
    openInfoWindow($(this).attr("data-meeting"))  