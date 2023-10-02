import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["content"];
  connect() {
    this.close();
  }

  closeWithKeyboard(event) {
    if (event.key === "Escape") {
      this.close();
    }
  }

  closeOnBigScreen(event) {
    if (window.innerWidth > 768) {
      this.close();
    }
  }

  toggle() {
    if (this.contentTarget.classList.contains("hidden")) {
      this.open();
    } else {
      this.close();
    }
  }

  open() {
    this.contentTarget.classList.remove("hidden");
    let main = document.querySelector("main");
    let mainNav = document.getElementById("main-nav");
    mainNav.classList.add("hidden");
    main.classList.add("blur");
    document.body.classList.add("overflow-hidden");
    // main.classList.add('hidden')
  }

  close() {
    this.contentTarget.classList.add("hidden");
    let main = document.querySelector("main");
    let mainNav = document.getElementById("main-nav");
    mainNav.classList.remove("hidden");
    main.classList.remove("blur");
    document.body.classList.remove("overflow-hidden");
    // main.classList.remove('hidden')
  }
}
