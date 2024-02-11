import { Application } from "@hotwired/stimulus"
import Lightbox from 'stimulus-lightbox'

const application = Application.start()
application.register('lightbox', Lightbox)

// Configure Stimulus development experience
application.warnings = true
application.debug    = false
window.Stimulus      = application

export { application }