do($ = jQuery) ->
  # Override the default confirm dialog by rails
  $.rails.allowAction = (link) ->
    return true unless link.data('confirm')
    $.rails.showConfirmationDialog(link)
    false

  $.rails.confirmed = (link) ->
    link.removeData('confirm')
    link.trigger('click.rails')

  # Display confirmation dialog
  $.rails.showConfirmationDialog = (link) ->
    message = link.data('confirm')
    $('.ui.modal .content').text(message)
    $('.ui.modal').modal(
      inverted: true,
      onApprove : () ->
        $.rails.confirmed(link)
    ).modal('show')
