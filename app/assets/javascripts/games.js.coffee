initializePage '.games.show', ->
  $('#send-reminder-link').click (e) ->
    e.preventDefault()
    $('#reminder-modal').modal('show')
