# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  ($ '.meeting-list-delete').bind 'ajax:success', ->
    ($ this).closest('.meetings-listing').fadeOut()
    
  ($ '[data-toggle="tooltip"]').tooltip()



  
