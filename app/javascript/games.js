$(document).on('turbolinks:load', () => {
  $(document).on('click', '.action-link', (e) => {
    e.preventDefault()
    const modal_id = $(e.target).attr('id').replace(/link$/, 'modal')
    $(`#${modal_id}`).modal('show')
  })
})
