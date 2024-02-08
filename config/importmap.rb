# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "alpinejs" # @3.13.5
pin "stimulus-use" # @0.52.2
pin "@alpinejs/ui", to: "@alpinejs--ui.js" # @3.13.5
pin "@alpinejs/focus", to: "@alpinejs--focus.js" # @3.13.5
pin "@alpinejs/mask", to: "@alpinejs--mask.js" # @3.13.5
pin "@rails/activestorage", to: "@rails--activestorage.js" # @7.1.3
pin "local-time" # @3.0.2
