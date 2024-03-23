import { Controller } from "@hotwired/stimulus";
import LazyLoadImages from 'lazy-load-images';
import LoadImages from "load-images";

export default class extends Controller {
  connect() {
    LazyLoadImages.init();
    LoadImages.init();
  }
}
