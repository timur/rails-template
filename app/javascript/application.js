import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage";
import Alpine from "alpinejs";
import ui from "@alpinejs/ui";
import focus from "@alpinejs/focus";
import mask from "@alpinejs/mask";
import LocalTime from "local-time";
import "./controllers"

Alpine.plugin(ui);
Alpine.plugin(focus);
Alpine.plugin(mask);

ActiveStorage.start();
window.Alpine = Alpine;
Alpine.start();

LocalTime.start();

Turbo.setConfirmMethod((message, element) => {
  const data = JSON.parse(`${message}`);
  Alpine.store('confirmModal').toggle();
  Alpine.store('confirmModal').title = data.title;
  Alpine.store('confirmModal').message = data.message;

  return new Promise((resolve, reject) => {
    window.addEventListener("confirm", () => {
      resolve(true);
    }, { once: true })
  })
})