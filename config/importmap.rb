# Pin npm packages by running ./bin/importmap
pin "application", preload: false
pin "landing", preload: false
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: false
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js", preload: false # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: false
pin "alpinejs" # @3.13.7
pin "stimulus-use", preload: false # @0.52.2
pin "@alpinejs/ui", to: "@alpinejs--ui.js", preload: false # @3.13.7
pin "@alpinejs/focus", to: "@alpinejs--focus.js", preload: false # @3.13.7
pin "@alpinejs/mask", to: "@alpinejs--mask.js", preload: false # @3.13.7
pin "@rails/activestorage", to: "@rails--activestorage.js", preload: false # @7.1.3
pin "local-time" # @3.0.2
pin "@rails/request.js", to: "@rails--request.js", preload: false # @0.0.9
pin "lightgallery", preload: false # @2.7.2
pin "stimulus-lightbox", preload: false # @3.2.0
pin "lazy-load-images", preload: false
pin "load-images", preload: false
pin "preload-images", preload: false
pin "ahoy", preload: false # @1.0.1
pin "os", preload: false # @2.0.1
pin "apexcharts", preload: false # @3.48.0
pin "lg-thumbnail", preload: false
pin "@shopify/draggable", to: "@shopify--draggable.js", preload: false # @1.1.3
pin_all_from "app/javascript/controllers", under: "controllers", preload: false