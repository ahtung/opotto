class @SelectGuest
  @options
  constructor: (options = {}) ->

  add_guest: (guest_id) ->
    guest_elem = create_elem(guest_id, 'not-invited-list')
    guest_elem.append($('<i>', {class: 'material-icons remove-from-guests', text: 'close' }))
    $('.invited-list').append(guest_elem)
    $("#jar_guest_ids option[value='#{guest_id}']").attr('selected', true)

  remove_guest: (guest_id) ->
    guest_elem = create_elem(guest_id, 'invited-list')
    guest_elem.append($('<i>', {class: 'material-icons add-to-guests', text: 'add' }))
    $('.not-invited-list').append(guest_elem)
    $("#jar_guest_ids option[value='#{guest_id}']").attr('selected', false)

  create_elem = (guest_id, list) ->
    guest_elem = $('<div>', { class: 'chip' })
    guest_name = $('<span>', { class: 'guest-name', text: $(".#{list} .chip[data-guest='#{guest_id}']").find('.guest-name').text() })
    guest_email = $('<span>', { class: 'guest-email', text: $(".#{list} .chip[data-guest='#{guest_id}']").find('.guest-email').text() })
    guest_elem.append guest_name
    guest_elem.append guest_email
    guest_elem.attr('data-guest', guest_id)