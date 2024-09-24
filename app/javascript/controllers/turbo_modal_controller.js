import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect(){
    this.modalElement = this.element.parentElement
    this.modalElement.showModal()
  }

  disconnect(){
    this.modalElement.close()
    this.element.remove() // it needs to be "emptied", as it's kept between requests by data-turbo-permanent
  }

  close(e){
    this.modalElement.close()
    this.element.remove()
  }

  // hide modal when clicking ESC
  // action: "keyup@window->turbo-modal#closeWithKeyboard"
  closeWithKeyboard(e) {
    if (e.code == "Escape") {
      this.modalElement.close()
      this.element.remove()
    }
  }

  // hide modal when clicking outside of modal
  // action: "click@window->turbo-modal#closeBackground"
  closeBackground(e) {
    if (e && this.element.contains(e.target)) {
      return
    }

    // this.modalElement.close()
    this.element.remove()
  }
}
