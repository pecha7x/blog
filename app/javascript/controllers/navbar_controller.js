// controllers/gallery_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  next(event) {
    var target = event.target;
    if (target.closest("a")) {
      return;
    }

    event.preventDefault();

    var currentTarget = event.currentTarget;
    var items = this.element.getElementsByTagName("details");

    for (var i = 0; i < items.length; i++) {
      if (currentTarget != items[i] && items[i].hasAttribute("open")) {
        items[i].removeAttribute("open");
      }
    }

    if (currentTarget.hasAttribute("open")) {
      currentTarget.removeAttribute("open");
    } else {
      currentTarget.setAttribute("open", '1');
    }
  }
}
