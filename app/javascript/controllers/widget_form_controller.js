import { post } from "@rails/request.js";
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];

  async submitForm() {
    const data = new FormData(this.formTarget);
    const response = await post("http://localhost:3000/api/widget_form/", {
      responseKind: "turbo_stream",
      body: data,
    });

    if (response.ok) {
      console.log("OK");
    } else {
      console.log("ERROR");
    }
  }
}
