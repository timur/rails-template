import "@hotwired/turbo-rails";
import * as ActiveStorage from "@rails/activestorage";
import Alpine from "alpinejs";
import ui from "@alpinejs/ui";
import focus from "@alpinejs/focus";
import mask from "@alpinejs/mask";
import LocalTime from "local-time";
import LazyLoadImages from 'lazy-load-images';
import preloadImage from 'preload-images';
import ApexCharts from 'apexcharts';
import "controllers"

Alpine.plugin(ui);
Alpine.plugin(focus);
Alpine.plugin(mask);

ActiveStorage.start();
window.Alpine = Alpine;
window.ApexCharts = ApexCharts;
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