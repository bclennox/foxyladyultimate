import { Modal } from 'bootstrap'

$(document).on('turbolinks:load', () => {
  $(document).on('click', '.action-link', (e) => {
    e.preventDefault()
    const modalId = $(e.target).attr('id').replace(/link$/, 'modal')
    const modalElement = document.getElementById(modalId)

    new Modal(modalElement).show()
  })
})
