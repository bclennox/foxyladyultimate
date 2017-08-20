$(document).on 'turbolinks:load', ->
  $(document).on 'click', '.action-link', (e) ->
    e.preventDefault()
    modal_id = $(this).attr('id').replace(/link$/, 'modal')
    $("##{modal_id}").modal('show')
