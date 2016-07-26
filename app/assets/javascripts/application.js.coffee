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

  $( "#pot_receiver_id" ).select2({
    placeholder: 'Email address of the receiver'
  })

  $('#pot_guest_ids').select2({
    placeholder: 'Email addresses of the guests'
  })

  $('.ui.calendar').calendar()
  $('.ui.dropdown').dropdown()

$('.message .close').on 'click', () ->
  $(@).closest('.message').transition('fade')
