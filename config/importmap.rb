# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@rails/activestorage", to: "https://ga.jspm.io/npm:@rails/activestorage@7.0.8/app/assets/javascripts/activestorage.esm.js", preload: true
pin "alpine-turbo-drive-adapter", to: "https://ga.jspm.io/npm:alpine-turbo-drive-adapter@2.1.0/dist/alpine-turbo-drive-adapter.esm.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "alpinejs", to: "https://ga.jspm.io/npm:alpinejs@3.13.1/dist/module.esm.js", preload: true
pin "@alpinejs/ui", to: "https://ga.jspm.io/npm:@alpinejs/ui@3.13.1-beta.0/dist/module.esm.js"
pin "@alpinejs/focus", to: "https://ga.jspm.io/npm:@alpinejs/focus@3.13.1/dist/module.esm.js"

pin "htm", to: "https://ga.jspm.io/npm:htm@3.1.1/dist/htm.module.js"
pin "react", to: "https://ga.jspm.io/npm:react@18.2.0/index.js"
pin "react-dom", to: "https://ga.jspm.io/npm:react-dom@18.2.0/index.js"
pin "scheduler", to: "https://ga.jspm.io/npm:scheduler@0.23.0/index.js"
pin "react-photo-album", to: "https://ga.jspm.io/npm:react-photo-album@2.3.0/dist/index.mjs"

pin "yet-another-react-lightbox", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/index.js"
pin "yet-another-react-lightbox/plugins/fullscreen", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/plugins/fullscreen/index.js"
pin "yet-another-react-lightbox/plugins/slideshow", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/plugins/slideshow/index.js"
pin "yet-another-react-lightbox/plugins/thumbnails", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/plugins/thumbnails/index.js"
pin "yet-another-react-lightbox/plugins/zoom", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/plugins/zoom/index.js"
pin_all_from "app/javascript/components", under: "components"
pin "stimulus-use", to: "https://ga.jspm.io/npm:stimulus-use@0.52.0/dist/index.js"
