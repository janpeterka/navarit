import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  submit(e) {
    e.preventDefault();
    this.element.requestSubmit();
  }
}
