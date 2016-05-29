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
#= require jquery.transit.min
#= require jquery.cookie
#= require jstz
#= require confirm
#= require browser_timezone_rails/set_time_zone
#= require semantic-ui

window.BrowserTZone ||= {}
BrowserTZone.setCookie = ->
  $.cookie "browser.timezone", jstz.determine().name(), { expires: 365, path: '/' }

$ ->
  BrowserTZone.setCookie()
  $('#show-menu').on 'click', (event) ->
    event.preventDefault();
    $('.ui.sidebar')
      .sidebar('toggle')

  $('.clickable').on 'click', () ->
    window.location = $(@).data('link')

$('.message .close').on 'click', () ->
  $(@).closest('.message').transition('fade')
