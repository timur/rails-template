import focus from "@alpinejs/focus";
import mask from "@alpinejs/mask";
import ui from "@alpinejs/ui";
import "@hotwired/turbo-rails";
import * as ActiveStorage from "@rails/activestorage";
import "@shopify/draggable";
import Alpine from "alpinejs";
import ApexCharts from "apexcharts";
import "controllers";
import "lazy-load-images";
import "lg-thumbnail";
import "load-images";
import LocalTime from "local-time";
import "preload-images";

Alpine.plugin(ui);
Alpine.plugin(focus);
Alpine.plugin(mask);

ActiveStorage.start();
window.Alpine = Alpine;
window.ApexCharts = ApexCharts;
Alpine.start();

LocalTime.start();

const confirmMethod = (message, element) => {
  const data = JSON.parse(`${message}`);
  Alpine.store("confirmModal").toggle();
  Alpine.store("confirmModal").title = data.title;
  Alpine.store("confirmModal").message = data.message;

  return new Promise((resolve, reject) => {
    window.addEventListener(
      "confirm",
      () => {
        resolve(true);
      },
      { once: true }
    );
  });
};

Turbo.config.forms.confirm = confirmMethod;
