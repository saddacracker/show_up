# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  ($ '.meeting-list-delete').bind 'ajax:success', ->
    ($ this).closest('.meetings-listing').fadeOut()

  # ($ '.meeting-list-show').bind 'ajax:beforeSend', ->
  #   ($ '#mySpinner').show();
  #   
  # ($ '.link-delete').bind 'ajax:success', ->
  #   ($ '#mySpinner').hide();
  
  # check for a value in teh search field
  unless $("#search").val() != ""
    alert("Looks like you forgot to put in a location. Try something like, Seattle, WA")


  
