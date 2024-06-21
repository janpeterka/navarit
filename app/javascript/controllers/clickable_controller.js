import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.element.classList.add("cursor-pointer")
    this.element.dataset.action = "click->clickable#visitURL"
  }

  visitURL(event) {
    if (event.target.dataset.bsToggle == "modal") { return; } // prevent this when clicking modal button
    if (event.target.tagName == "A") { return; } // prevent this when clicking a link
    if (event.target.closest('form')) { return; } // prevent this when submiting a form

    Turbo.visit(this.urlValue, { action: "replace" })
  }
}
