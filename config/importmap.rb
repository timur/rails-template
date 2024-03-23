# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "alpinejs" # @3.13.5
pin "stimulus-use" # @0.52.2
pin "@alpinejs/ui", to: "@alpinejs--ui.js" # @3.13.5
pin "@alpinejs/focus", to: "@alpinejs--focus.js" # @3.13.5
pin "@alpinejs/mask", to: "@alpinejs--mask.js" # @3.13.5
pin "@rails/activestorage", to: "@rails--activestorage.js" # @7.1.3
pin "local-time" # @3.0.2
pin "@rails/request.js", to: "@rails--request.js" # @0.0.9
pin "lightgallery" # @2.7.2
pin "stimulus-lightbox" # @3.2.0
pin "lazy-load-images"
pin "load-images"
pin "preload-images"
pin "ahoy" # @1.0.1
pin "os" # @2.0.1
pin "apexcharts" # @3.48.0
pin "lg-thumbnail"
pin_all_from "app/javascript/controllers", under: "controllers"
