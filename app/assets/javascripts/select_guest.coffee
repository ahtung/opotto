class @SelectGuest
  @options
  constructor: (options = {}) ->

  add_guest: (guest_id) ->
    guest_name = $('<span>', {class: 'guest-name', text: $(".not-invited-list .chip[data-guest='#{guest_id}']").find('.guest-name').text() })
    guest_email = $('<span>', {class: 'guest-email', text: $(".not-invited-list .chip[data-guest='#{guest_id}']").find('.guest-email').text() })

    guest_elem = $('<div>', { class: 'chip' })
    guest_elem.append guest_name
    guest_elem.append guest_email
    guest_elem.append($('<i>', {class: 'material-icons remove-from-guests', text: 'close' }))
    guest_elem.attr('data-guest', guest_id)
    $('.invited-list').append(guest_elem)
    $("#jar_guest_ids option[value='#{guest_id}']").attr('selected', true)

  remove_guest: (guest_id) ->
    guest_name = $('<span>', { class: 'guest-name', text: $(".invited-list .chip[data-guest='#{guest_id}']").find('.guest-name').text() })
    guest_email = $('<span>', { class: 'guest-email', text: $(".invited-list .chip[data-guest='#{guest_id}']").find('.guest-email').text() })

    guest_elem = $('<div>', { class: 'chip' })
    guest_elem.append guest_name
    guest_elem.append guest_email
    guest_elem.append($('<i>', {class: 'material-icons add-to-guests', text: 'add' }))
    guest_elem.attr('data-guest', guest_id)
    $('.not-invited-list').append(guest_elem)
    $("#jar_guest_ids option[value='#{guest_id}']").attr('selected', false)

  set_names = () ->
