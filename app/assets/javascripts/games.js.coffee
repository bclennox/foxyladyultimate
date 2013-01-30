initializePage '.games.show', ->
  $('#send-reminder-link, #cancel-game-link, #reschedule-game-link').click (e) ->
    e.preventDefault()
    modal_id = $(this).attr('id').replace(/link$/, 'modal')
    $("##{modal_id}").modal('show')
