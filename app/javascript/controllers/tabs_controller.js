import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
export default class extends Controller {

  static targets= ["tab", "btn"];
  static values= {
    default: String,
    type: String
  };

  connect() {
    this.tabTargets.forEach(tab => {
      if (tab.dataset.tabsTypeValue !== this.defaultValue) {
        tab.classList.add('hidden');
      }
    });
  }

  open(event) {
    event.preventDefault
    let tabId= event.currentTarget.dataset.id
    this.tabTargets.forEach(tab => {
      if (tab.dataset.tabsTypeValue !== tabId)
        tab.classList.add('hidden')
      else
        tab.classList.remove('hidden')
    });
  }

  close(event) {
    event.preventDefault();
    let tab = event.currentTarget.closest("[data-tabs-target='tab']");
    tab.classList.add('hidden');
  }
}
