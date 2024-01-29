import { Controller } from "@hotwired/stimulus";
import { useClickOutside } from "stimulus-use";

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = ["viewInput", "viewValue", "datepicker"];

  connect() {
    useClickOutside(this);
  }

  click(event) {
    let time = null;
    let formattedTime = null;
    if (event.target) {
      let tagName = event.target.tagName.toLowerCase();
      if (tagName === "time") {
        time = event.target.dateTime;
        formattedTime = event.target.attributes.dateformatted.nodeValue;
      }
      if (tagName === "button") {
        let timeElement = event.target.querySelector("time");
        if (timeElement) {
          time = timeElement.dateTime;
          formattedTime = timeElement.attributes.dateformatted.nodeValue;
        }
      }
    }
    this.viewInputTarget.value = formattedTime;
    this.viewValueTarget.value = time;
    this.close();
    event.preventDefault();
    event.stopPropagation();
  }

  change(event) {
    let value = event.target.value;
    if (value === "") {
      this.viewValueTarget.value = "";
      return;
    }
  }

  clickOutside(event) {
    if (event.target.type === "submit") return;
    this.close();
  }

  close() {
    this.datepickerTarget.classList.add("hidden");
    this.viewInputTarget.blur();
  }
}
