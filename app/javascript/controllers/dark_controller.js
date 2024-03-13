import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["themeToggle"];

  connect() {
    this.loadTheme();
    this.updateSwitchPosition();
  }

  toggleTheme() {
    const theme = document.body.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
    document.body.setAttribute('data-theme', theme);
    localStorage.setItem('theme', theme);

    const event = new CustomEvent('themeChanged', { detail: { theme } });
    window.dispatchEvent(event);

    this.updateSwitchPosition();
  }

  loadTheme() {
    const savedTheme = localStorage.getItem('theme') || 'light';
    document.body.setAttribute('data-theme', savedTheme);

    const event = new CustomEvent('themeChanged', { detail: { theme: savedTheme } });
    window.dispatchEvent(event);

    this.updateSwitchPosition();
  }

  updateSwitchPosition() {
    const currentTheme = document.body.getAttribute('data-theme');
    const isChecked = currentTheme === 'dark';
    this.themeToggleTarget.checked = isChecked;

    const closeButtons = document.querySelectorAll('.btn-close');

    closeButtons.forEach(button => {
      if (isChecked) {
        button.classList.add('btn-close-white');
      } else {
        button.classList.remove('btn-close-white');
      }
    });
  }

}
