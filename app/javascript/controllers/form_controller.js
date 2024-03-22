import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  submit(event) {
    this.element.requestSubmit();
  }

  checkbox(event) {
    event.stopPropagation();
    this.element.requestSubmit();
  }
}