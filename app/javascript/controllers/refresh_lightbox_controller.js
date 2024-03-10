// app/javascript/controllers/scroll_to_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  connect() {
    const trigger = new CustomEvent("refresh-lightbox");
    window.dispatchEvent(trigger);
    this.element.remove();
  }
}