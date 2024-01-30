import { Controller } from "@hotwired/stimulus";
import { useClickOutside } from "stimulus-use";

// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = ["viewInput", "viewValue", "datepicker"];
  static values = {
    url: String
  };

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

  focus(event) {
    this.datepickerTarget.classList.remove("hidden");
    const turboFrame = this.datepickerTarget.querySelector('turbo-frame');
    const turboFrameId = turboFrame ? turboFrame.id : '';
    if (turboFrameId !== '' && this.viewValueTarget.value !== '') {
      const newUrl = `${this.urlValue}?id=${turboFrameId}&month_date=${this.viewValueTarget.value}&current_date=${this.viewValueTarget.value}&route=calendar_datepicker_path`;
      Turbo.visit(newUrl, { turbo: true, acceptsStreamResponse: true });      
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
