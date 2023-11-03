import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["content", "svg"];
  static classes = ["rotate"]

  static values = {
    // setup values that we reference in our controller, passed in from our HTML
    class: String,
    initialActive: { type: Boolean, default: false },
    active: { type: Boolean, default: false },
  }

  connect() {
    console.log("Connect", this.initialActiveValue)
    if (this.initialActiveValue === true) {
      // use the initialActiveValue passed from data-toggle-initial-active-value to optionally toggle our class
      this.toggle()
    }
    this.activeValue = this.initialActiveValue
    console.log("Connect active", this.activeValue)
  }
  toggle() {
    let classToToggle = this.classValue // use the classValue passed from data-toggle-class-value in our HTML
    this.contentTarget.classList.toggle(classToToggle) // toggle():  https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/toggle
    this.activeValue = !this.activeValue

    if (this.activeValue === true) {
      this.svgTarget.classList.add(this.rotateClass)
    } else {
      this.svgTarget.classList.remove(this.rotateClass)
    }
  }
}
