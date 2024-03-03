import Lightbox from 'stimulus-lightbox'
import lgThumbnail from "https://cdnjs.cloudflare.com/ajax/libs/lightgallery/2.8.0-beta.1/plugins/thumbnail/lg-thumbnail.es5.min.js";

export default class extends Lightbox {
  connect() {
    super.connect()

    // Get the lightgallery instance
    this.lightGallery

    // Default options for every lightboxes.
    this.defaultOptions
  }

  disconnect() {
    super.disconnect()
  }

  refresh() {
    this.lightGallery.refresh()
  }

  // You can set default options in this getter.
  get defaultOptions() {
    return {
      plugins: [lgThumbnail]
    }
  }
}