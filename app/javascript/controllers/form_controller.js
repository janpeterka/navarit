import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { autoSubmit: { type: Boolean, default: false } }

  connect() {
    console.log("form controller connected");
    this.debounceTimeout = false;

    if (this.autoSubmitValue) {
      this.element.dataset.action = this.element.getAttribute("data-action") || "" + " change->form#submit keydown.enter->form#submit"
    }
  }

  reset() {
    this.element.reset()
    this.debounceTimeout = false
  }

  submit(e) {
    console.log("submitting form");
    e.preventDefault();
    if (!this.debounceTimeout === true) {
      console.log("submitting form");
      this.element.requestSubmit();
      console.log("submited form");
      this.debounceTimeout = true;
      setTimeout(() => {
        this.debounceTimeout = false;
        console.log("debounce timeout reset")
      }, 200)
    }
  }

}
