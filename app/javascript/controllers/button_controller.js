import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="button"
export default class extends Controller {
  static targets = ["button"];

  static values = {
    url: String
  }

  call() {
    if (this.urlValue) {
      window.location.href = this.urlValue;
    }
  }
}
