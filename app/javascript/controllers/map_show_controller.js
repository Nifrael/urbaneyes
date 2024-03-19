import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="map-show"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    const lngMarker = this.markersValue[0].lng
    const latMarker = this.markersValue[0].lat

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/albertnikolli/cltkg94oo01gp01pj4f04dyvk",
      center: [lngMarker, latMarker],
      zoom: 15,
      duration: 0
    })

    this.#addMarkersToMap()
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(customMarker)
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(this.map)

    });

    window.addEventListener('themeChanged', e => this.#updateMapStyle(e.detail.theme));
  }

  #updateMapStyle(theme) {
    const styleUrl = theme === 'dark' ? 'mapbox://styles/albertnikolli/cltpnabmu008t01qw8p5qeot2' : 'mapbox://styles/albertnikolli/cltkg94oo01gp01pj4f04dyvk';
    this.map.setStyle(styleUrl);
  }

  getCurrentMapStyle() {
    const theme = localStorage.getItem('theme') || 'light';
    return theme === 'dark' ? 'mapbox://styles/albertnikolli/cltpnabmu008t01qw8p5qeot2' : 'mapbox://styles/albertnikolli/cltkg94oo01gp01pj4f04dyvk';
  }
}
