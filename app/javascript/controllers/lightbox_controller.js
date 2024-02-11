import Lightbox from 'stimulus-lightbox'
//import lgThumbnail from 'lg-thumbnail'

export default class extends Lightbox {
  connect() {
    super.connect()

    // Get the lightgallery instance
    this.lightGallery

    // Default options for every lightboxes.
    this.defaultOptions
    debugger;
  }

  // You can set default options in this getter.
  get defaultOptions() {
    return {
      //plugins: [lgThumbnail],
    }
  }
}