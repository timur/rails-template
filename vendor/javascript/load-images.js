import preloadImage from 'preload-images';

class LoadImages {
  static init () {
    this._instance = new LoadImages();
  }

  constructor () {
    const images = document.querySelectorAll('.img-gallery');

    images.forEach(image => {
      const src = image.src;
      if (!src) {
        return;
      }      
      return preloadImage(src).then(_ => this._applyImage(image));
    });
  }

  _applyImage (img) {
    img.classList.remove('hidden');
  }
}

export default LoadImages;