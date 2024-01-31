// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import * as ActiveStorage from "@rails/activestorage";
import "alpine-turbo-drive-adapter";
import Alpine from "alpinejs";
import ui from "@alpinejs/ui";
import focus from "@alpinejs/focus";
import mask from "@alpinejs/mask";
import LocalTime from "local-time";
import "components";
import "controllers";

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
