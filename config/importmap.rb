# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

pin "htm", to: "https://ga.jspm.io/npm:htm@3.1.1/dist/htm.module.js"
pin "react", to: "https://ga.jspm.io/npm:react@18.2.0/index.js"
pin "react-dom", to: "https://ga.jspm.io/npm:react-dom@18.2.0/index.js"
pin "scheduler", to: "https://ga.jspm.io/npm:scheduler@0.23.0/index.js"
pin "react-photo-album", to: "https://ga.jspm.io/npm:react-photo-album@2.3.0/dist/index.mjs"
pin_all_from "app/javascript/components", under: "components"
pin "yet-another-react-lightbox", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/index.js"
pin "yet-another-react-lightbox/plugins/fullscreen", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/plugins/fullscreen/index.js"
pin "yet-another-react-lightbox/plugins/slideshow", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/plugins/slideshow/index.js"
pin "yet-another-react-lightbox/plugins/thumbnails", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/plugins/thumbnails/index.js"
pin "yet-another-react-lightbox/plugins/zoom", to: "https://ga.jspm.io/npm:yet-another-react-lightbox@3.12.2/dist/plugins/zoom/index.js"
