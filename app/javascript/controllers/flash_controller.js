import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  destroy() {
    this.element.remove()
  }
}
