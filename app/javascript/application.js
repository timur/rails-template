// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import * as ActiveStorage from "@rails/activestorage";
import "alpine-turbo-drive-adapter";
import Alpine from "alpinejs";
import ui from "@alpinejs/ui";
import focus from "@alpinejs/focus";
import mask from "@alpinejs/mask";
import "components";

Alpine.plugin(ui);
Alpine.plugin(focus);
Alpine.plugin(mask);

ActiveStorage.start();
window.Alpine = Alpine;
Alpine.start();
