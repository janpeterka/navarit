import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
  }

  hide() {
    this.element.remove()
  }
}
