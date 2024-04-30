# Pin npm packages by running ./bin/importmap
pin "application", preload: false
pin "landing", preload: false
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: false
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js", preload: false # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: false
pin "alpinejs" # @3.13.10
pin "stimulus-use", preload: false # @0.52.2
pin "@alpinejs/ui", to: "@alpinejs--ui.js" # @3.13.10
pin "@alpinejs/focus", to: "@alpinejs--focus.js" # @3.13.10
pin "@alpinejs/mask", to: "@alpinejs--mask.js" # @3.13.10
pin "@rails/activestorage", to: "@rails--activestorage.js", preload: false # @7.1.3
pin "local-time", preload: false # @3.0.2
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js", preload: false # @2.11.8
pin "tippy.js", to: "https://ga.jspm.io/npm:tippy.js@6.3.7/dist/tippy.esm.js", preload: false # @6.3.7
pin "@rails/request.js", to: "@rails--request.js", preload: false # @0.0.9
pin "lightgallery", preload: false # @2.7.2
pin "stimulus-lightbox", preload: false # @3.2.0
pin "lazy-load-images", preload: false
pin "load-images", preload: false
pin "preload-images", preload: false
pin "ahoy", preload: false # @1.0.1
pin "os", preload: false # @2.0.1
pin "apexcharts" # @3.49.0
pin "lg-thumbnail", preload: false
pin "@shopify/draggable", to: "@shopify--draggable.js", preload: false # @1.1.3
pin_all_from "app/javascript/controllers", under: "controllers", preload: false