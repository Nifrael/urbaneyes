import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    latitude: Number,
    longitude: Number
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    let userLatitude = this.latitudeValue;
    let userLongitude = this.longitudeValue;

    this.map = new mapboxgl.Map({
      container: this.element,
      style: this.getCurrentMapStyle(),
      center: [userLongitude, userLatitude],
      zoom: 12.5
    })

    new mapboxgl.Marker({ color: 'brown' })
    .setLngLat([userLongitude, userLatitude])
    .addTo(this.map)

    this.#addMarkersToMap()
    // this.#fitMapToMarkers()

  //   this.map.addControl(
  //     new mapboxgl.GeolocateControl({
  //         positionOptions: {
  //             enableHighAccuracy: true
  //         },
  //         // When active the map will receive updates to the device's location as it changes.
  //         trackUserLocation: true,
  //         // Draw an arrow next to the location dot to indicate which direction the device is heading.
  //         showUserHeading: true
  //     })
  // );


    window.addEventListener('themeChanged', e => this.#updateMapStyle(e.detail.theme));
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html
      const userMarker = document.createElement("div")
      userMarker.innerHTML = marker.marker_html

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(customMarker)
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(this.map)

    });
  }

  // #fitMapToMarkers() {
  //   const bounds = new mapboxgl.LngLatBounds()
  //   this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
  //   this.map.fitBounds(bounds, { padding: 40, maxZoom: 14, duration: 0 })
  // }

  #updateMapStyle(theme) {
    const styleUrl = theme === 'dark' ? 'mapbox://styles/albertnikolli/cltpnabmu008t01qw8p5qeot2' : 'mapbox://styles/albertnikolli/cltkg94oo01gp01pj4f04dyvk';
    this.map.setStyle(styleUrl);
  }

  getCurrentMapStyle() {
    const theme = localStorage.getItem('theme') || 'light';
    return theme === 'dark' ? 'mapbox://styles/albertnikolli/cltpnabmu008t01qw8p5qeot2' : 'mapbox://styles/albertnikolli/cltkg94oo01gp01pj4f04dyvk';
  }
}
