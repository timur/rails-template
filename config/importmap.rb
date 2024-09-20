# Pin npm packages by running ./bin/importmap
pin "application", preload: false
pin "landing", preload: false
pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @8.0.9
pin "@hotwired/turbo", to: "@hotwired--turbo.js" # @8.0.6
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @7.2.100
pin "alpinejs" # @3.14.1
pin "@alpinejs/ui", to: "@alpinejs--ui.js" # @3.14.1
pin "@alpinejs/focus", to: "@alpinejs--focus.js" # @3.14.1
pin "@alpinejs/mask", to: "@alpinejs--mask.js" # @3.14.1
pin "@rails/activestorage", to: "@rails--activestorage.js" # @7.2.100
pin "local-time" # @3.0.2
pin "@rails/request.js", to: "@rails--request.js.js" # @0.0.11
pin "stimulus-use" # @0.52.2
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "lightgallery" # @2.7.2
pin "stimulus-lightbox" # @3.2.0
pin "ahoy" # @1.0.1
pin "os" # @2.0.1
pin "@shopify/draggable", to: "@shopify--draggable.js" # @1.1.3

# custom
pin "lazy-load-images", preload: false
pin "load-images", preload: false
pin "preload-images", preload: false
pin "lg-thumbnail", preload: false

pin_all_from "app/javascript/controllers", under: "controllers", preload: false
pin "apexcharts" # @3.53.0
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
