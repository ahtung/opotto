# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require materialize-sprockets
#= require jquery.transit.min
#= require jquery.cookie
#= require jstz
#= require browser_timezone_rails/set_time_zone
#= require select_guest
#= require mapbox

window.BrowserTZone ||= {}
BrowserTZone.setCookie = ->
  $.cookie "browser.timezone", jstz.determine().name(), { expires: 365, path: '/' }

$ ->
  # Map
  if $('#map').length > 0
    map = L.mapbox.map('map', 'examples.map-y7l23tes', zoomControl: false).setView([41.046952, 28.973507], 12)
    map.dragging.disable()
    map.touchZoom.disable()
    map.doubleClickZoom.disable()
    map.scrollWheelZoom.disable()
    # Disable tap handler, if present.
    if map.tap
      map.tap.disable()

  BrowserTZone.setCookie()
  $('select').material_select()
  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 15
  })

  # Initialize Select Guest Class
  guests = new SelectGuest

  # Add guest to invited list
  $('.guest-select').on 'click', '.add-to-guests', ->
    guest_id = $(this).parent().data('guest')
    guests.add_guest(guest_id)

  # Remove Guest from invited list
  $('.guest-select').on 'click', '.remove-from-guests', ->
    guest_id = $(this).parent().data('guest')
    guests.remove_guest(guest_id)

  # Show errors in toast
  if $('.alert-box').length > 0
    $toastContent = $('<span>', html: $('.alert-box').html())
    $toastContent.append($('<i>', {class: 'material-icons close-alert', text: 'close' }))
    Materialize.toast $toastContent, 5000
    $('.alert-box').remove()
    $('#toast-container').on 'click', '.close-alert', ->
      $('#toast-container').fadeOut 'slow', ->
        $(this).remove()
