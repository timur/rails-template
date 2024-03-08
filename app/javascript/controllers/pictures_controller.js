// app/javascript/controllers/scroll_to_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    item: String,
  };

  connect() {
    this.targetElement.classList.toggle("border-2");
    this.targetElement.classList.toggle("border-indigo-600");
    this.element.remove();
  }

  get targetElement() {
    return document.getElementById(this.itemValue);
  }

}