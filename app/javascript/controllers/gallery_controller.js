import { Controller } from "@hotwired/stimulus";
import LazyLoadImages from 'lazy-load-images';

export default class extends Controller {
  connect() {
    LazyLoadImages.init();
  }
}
