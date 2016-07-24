#= require jquery
#= require jquery_ujs
#= require materialize-sprockets
#= require jquery.transit.min
#= require js.cookie
#= require jstz
#= require browser_timezone_rails/set_time_zone
#= require select_guest

$ ->
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
