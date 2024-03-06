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
    event.preventDefault();
    let tabId = event.currentTarget.dataset.id;
    this.tabTargets.forEach(tab => {
      if (tab.dataset.tabsTypeValue === tabId) {
        // Vérifier si l'onglet est déjà ouvert et le fermer si c'est le cas
        if (!tab.classList.contains('hidden')) {
          tab.classList.add('hidden');
        } else {
          // Ouvrir l'onglet cliqué et fermer les autres
          tab.classList.remove('hidden');
        }
      } else {
        tab.classList.add('hidden');
      }
    });
  }
}
