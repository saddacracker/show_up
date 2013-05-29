# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  ($ '.meeting-list-delete').bind 'ajax:success', ->
    ($ this).closest('tr').fadeOut()

  ($ '.meeting-list-show').bind 'ajax:beforeSend', ->
    ($ '#mySpinner').show();
    
  ($ '.link-delete').bind 'ajax:success', ->
    ($ '#mySpinner').hide();
