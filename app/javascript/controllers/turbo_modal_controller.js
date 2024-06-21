import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect(){
    this.element.parentElement.classList.remove("hidden")
  }

  justHideModal() {
    this.element.parentElement.removeAttribute("src") // it might be nice to also remove the modal SRC
    this.element.parentElement.classList.add("hidden")
    this.element.remove()
  }

  hideModal() {
    this.element.parentElement.removeAttribute("src") // it might be nice to also remove the modal SRC
    this.element.parentElement.classList.add("hidden")
    this.element.remove()

    Turbo.visit(window.location, { action: "replace" } )
  }

  // hide modal when clicking ESC
  // action: "keyup@window->turbo-modal#closeWithKeyboard"
  closeWithKeyboard(e) {
    if (e.code == "Escape") {
      this.hideModal()
    }
  }

  // hide modal when clicking outside of modal
  // action: "click@window->turbo-modal#closeBackground"
  closeBackground(e) {
    if (e && this.element.contains(e.target)) {
      return
    }
    this.hideModal()
  }
}
