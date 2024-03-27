import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading-screen"
export default class extends Controller {

static targets = ['screen']

  connect() {
    console.log('lumière')
    console.log(this.screenTarget)
    const loadingScreen = this.screenTarget;
    setTimeout(() => {
      loadingScreen.style.display = 'none';
    }, 2000);
  }
}
