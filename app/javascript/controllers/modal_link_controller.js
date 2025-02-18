import { Controller } from '@hotwired/stimulus'
import { Modal } from 'bootstrap'

export default class extends Controller {
  static targets = ['modal']

  showModal() {
    new Modal(this.modalTarget).show()
  }
}
