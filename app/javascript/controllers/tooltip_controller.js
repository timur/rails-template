import { Controller } from "@hotwired/stimulus";
import tippy from "tippy.js";

// Connects to data-controller="tooltip"
export default class extends Controller {
  static targets = ["content"];

  static values = {
    data: String
  }

  initialize() {
    if (this.dataValue) {
      tippy(this.contentTarget, { content: this.dataValue })
    }
  }
}
