// app/javascript/controllers/visibility_controller.js

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["hideable"];

  showTargets() {
    this.hideableTargets.forEach((el) => {
      el.hidden = false;
    });
  }

  hideTargets() {
    this.hideableTargets.forEach((el) => {
      el.hidden = true;
    });
  }

  toggleTargets() {
    this.hideableTargets.forEach((el) => {
      if (el.classList.contains("hidden")) {
        el.classList.remove("hidden");
      } else {
        el.classList.add("hidden");
      }
    });
  }
}
