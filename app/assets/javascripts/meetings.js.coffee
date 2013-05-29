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
  
  # load first listing


  # $.ajax '/meetings/12',
  #     type: 'GET'
  #     dataType: 'html'
  #     error: (jqXHR, textStatus, errorThrown) ->
  #         ($ '#meeting-preview').append "AJAX Error: #{textStatus}"
  #     success: (data, textStatus, jqXHR) ->
  #         ($ '#meeting-preview').html "Successful AJAX call: #{data}"
  
