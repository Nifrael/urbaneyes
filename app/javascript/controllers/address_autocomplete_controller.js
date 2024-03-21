import { Controller } from "@hotwired/stimulus"
// import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["address"]

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address",
      countries: 'FR' // take out this line if you want to search worldwide

    })
    this.geocoder.addTo(this.element)

    console.log(this.geocoder._inputEl)
    this.geocoder._inputEl.setAttribute('data-geolocation-target', 'input');
    this.geocoder._inputEl.setAttribute('data-address-autocomplete-target', 'address');
    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"]
  }

  #clearInputValue() {
    this.addressTarget.value = ""
  }

}
