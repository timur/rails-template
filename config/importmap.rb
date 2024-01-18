# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@rails/activestorage", to: "@rails--activestorage.js" # @7.1.3
pin "alpine-turbo-drive-adapter", to: "https://ga.jspm.io/npm:alpine-turbo-drive-adapter@2.1.0/dist/alpine-turbo-drive-adapter.esm.js"
pin "alpinejs" # @3.13.3
pin "@alpinejs/ui", to: "@alpinejs--ui.js" # @3.13.3
pin "@alpinejs/focus", to: "@alpinejs--focus.js" # @3.13.3
pin "@alpinejs/mask", to: "@alpinejs--mask.js" # @3.13.3

pin "htm", to: "https://ga.jspm.io/npm:htm@3.1.1/dist/htm.module.js"
pin "react" # @18.2.0
pin "react-dom" # @18.2.0
pin "scheduler" # @0.23.0
pin "react-photo-album", to: "https://ga.jspm.io/npm:react-photo-album@2.3.0/dist/index.mjs"

pin "yet-another-react-lightbox", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/index.js"
pin "yet-another-react-lightbox/plugins/fullscreen", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/plugins/fullscreen/index.js"
pin "yet-another-react-lightbox/plugins/slideshow", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/plugins/slideshow/index.js"
pin "yet-another-react-lightbox/plugins/thumbnails", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/plugins/thumbnails/index.js"
pin "yet-another-react-lightbox/plugins/zoom", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/plugins/zoom/index.js"
pin_all_from "app/javascript/components", under: "components"
pin "stimulus-use" # @0.52.2
pin "@rails/request.js", to: "https://ga.jspm.io/npm:@rails/request.js@0.0.9/src/index.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js", preload: true # @2.11.8
pin "tippy.js", to: "https://ga.jspm.io/npm:tippy.js@6.3.7/dist/tippy.esm.js", preload: true # @6.3.7

pin "local-time-cdn" # @3.0.2
