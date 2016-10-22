#= require jquery
#= require jquery_ujs
#= require jquery.transit.min
#= require js.cookie
#= require jstz
#= require confirm
#= require browser_timezone_rails/set_time_zone
#= require semantic-ui

$ ->
  $('#show-menu').on 'click', (event) ->
    event.preventDefault()
    $('.ui.sidebar')
      .sidebar('toggle')

  $('.clickable').on 'click', () ->
    window.location = $(@).data('link')

  $('.ui.calendar').calendar()
  $('.ui.dropdown').dropdown()

$('.message .close').on 'click', () ->
  $(@).closest('.message').transition('fade')
