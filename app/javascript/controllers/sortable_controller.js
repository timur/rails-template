import { Controller } from "@hotwired/stimulus"
import { Sortable, Plugins } from '@shopify/draggable';

export default class extends Controller {
  connect() {
    this.sortable = new Sortable(this.element, {
      draggable: '.item',
      sortAnimation: {
        duration: 200,
        easingFunction: 'ease-in-out',
      },
      swapAnimation: {
        duration: 200,
        easingFunction: 'ease-in-out',
        horizontal: true,
      },      
      plugins: [Plugins.SortAnimation, Plugins.SwapAnimation],
    })

    this.sortable.on('sortable:start', (e) => console.log('sortable:start', e));
    this.sortable.on('sortable:sort', (e) => console.log('sortable:sort', e));
    this.sortable.on('sortable:sorted', (e) => console.log('sortable:sorted', e));
    this.sortable.on('sortable:stop', (e) => console.log('sortable:stop', e));
  }

}