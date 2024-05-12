import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["input", "incrementer", "decrementer"]

  connect() {
    this.incrementerTarget.dataset.action = "click->input-value#increment"
    this.decrementerTarget.dataset.action = "click->input-value#decrement"

    if (this.inputTarget.value == this.inputTarget.min) {
      this.decrementerTarget.disabled = true;
    }
  }

  increment() {
    this.inputTarget.value++;
    this.dispatchEvent();

    this.decrementerTarget.disabled = false;
  }

  decrement() {
    if ((this.inputTarget.value - 1) >= this.inputTarget.min) {
      this.inputTarget.value--;
      this.dispatchEvent();
      if (this.inputTarget.value == this.inputTarget.min) {
        this.decrementerTarget.disabled = true;
      }
    }
  }

  dispatchEvent() {
    const event = new CustomEvent("value-changed")
    window.dispatchEvent(event)
  }

}
