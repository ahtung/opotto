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
#= require materialize
#= require jquery.transit.min
#= require jquery.cookie
#= require jstz
#= require browser_timezone_rails/set_time_zone
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

  $('.add-to-guests').click ->
    guest_id = $(this).parent().data('guest')
    guest_name = $('<span>', {class: 'guest_name', text: $(this).parent().find('.guest-name').text() })
    guest_email = $('<span>', {class: 'guest_email', text: $(this).parent().find('.guest-email').text() })

    guest_elem = $('<div>', { class: 'chip' })
    guest_elem.append guest_name
    guest_elem.append guest_email
    guest_elem.append($('<i>', {class: 'material-icons remove-from-guests', text: 'close' }))
    guest_elem.attr('data-guest', guest_id)
    $('.invited-list').append(guest_elem)
    $("#jar_guest_ids option[value='#{guest_id}']").attr('selected', true)
