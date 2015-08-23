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
#= require select2
#= require d3
#= require materialize-sprockets
#= require jquery.transit.min
#= require jar
#= require jquery.cookie
#= require jstz
#= require browser_timezone_rails/set_time_zone
#= require mapbox

window.BrowserTZone ||= {}
BrowserTZone.setCookie = ->
  $.cookie "browser.timezone", jstz.determine().name(), { expires: 365, path: '/' }

$ ->
  if $('#map').length > 0
    map = L.mapbox.map('map', 'examples.map-y7l23tes').setView([41.046952, 28.973507], 12)
  $(document).foundation()
  $(".jar-guests").select2()
  BrowserTZone.setCookie()
