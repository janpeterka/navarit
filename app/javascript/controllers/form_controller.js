import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  submitIfValue(e) {
    e.preventDefault();
    // this uses hw-combobox:selection event
    if (e.detail.value.length > 0) {
      this.submit(e);
    }
  }

  submit(e) {
    e.preventDefault();
    this.element.requestSubmit();
  }
}
