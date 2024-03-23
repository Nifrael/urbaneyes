import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: true,
  maximumAge: 0
};

// Connects to data-controller="geolocation"
export default class extends Controller {

  static values = {
    userId: Number,
    userIdForTicket: Number,
    address: String
  }

  static targets = ["address"];

  connect() {
  }

  // Méthodes pour obtenir la position actuelle de l'utilisateur

  updateUserLocation() {
    navigator.geolocation.getCurrentPosition(this._success.bind(this), this._error, options);
  }

  updateUserLocationForNewTicket() {
    navigator.geolocation.getCurrentPosition(this._successForTicket.bind(this), this._error, options);
    console.log("coucou toi")
  }

  _success(pos) {
    const coordinates = pos.coords;
    let longitude = coordinates.longitude
    let latitude = coordinates.latitude

    this._updateUser(longitude, latitude);

    this._refreshPage()
  }

  _successForTicket(pos) {
    const coordinates = pos.coords;
    let longitude = coordinates.longitude
    let latitude = coordinates.latitude

    this._updateUserForTicket(longitude, latitude);
  }

  _error() {
    console.warn(`Position non obtenue.`);
  }

  // Fetch pour envoyer au serveur les modifications de l'utilisateur (latitude et longitude), méthode privée rappelée par UpdateUserLocation

  _updateUser(longitude, latitude) {
    const currentUserId = this.userIdValue

    fetch (`geolocation/update`, {
      method: "PATCH",
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ user_id: currentUserId, latitude: latitude, longitude: longitude })
    })
      .then(response => response.json())
      .then(data => {
      })
  }

  _updateUserForTicket(longitude, latitude) {
    const currentUserId = this.userIdForTicketValue
    console.log("this is the current user id: " + currentUserId)
    // The input to fill is the input with the class mapboxgl-ctrl-geocoder--input
    // since we had to hide the input of the simple_form.
                // -------- //
    const inputToFill = document.querySelector('#ticket_address');
    console.log(inputToFill)

    fetch (`/geolocation/update`, {
      method: "PATCH",
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ user_id: currentUserId, latitude: latitude, longitude: longitude })
    })
      .then(response => response.json())
      .then(data => {
        console.dir(data)
        const inputWrapper = document.querySelector('.mapboxgl-ctrl-geocoder--input');
        inputWrapper.value = data.current_position_address
        inputToFill.value = data.current_position_address
      })
  }

  // Méthode pour récupérer l'adresse de la colonne adresse de l'utilisateur

  backToUserAddress() {
    const address = this.addressValue
    this._initialLocation(address)

    this._refreshPage()
  }

  // Fetch pour envoyer au serveur les modifications de la current_position_address qui reprend la valeur de base de l'adresse

  _initialLocation(address) {
    const currentUserId = this.userIdValue

    fetch (`address_geolocation/update`, {
      method: "PATCH",
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ user_id: currentUserId, address: address })
    })
      .then(response => response.json())
      .then(data => {
      })
  }

  // Petite méthode de rafraichissement avec un temps d'attente pour laisser le temps au serveur d'envoyer et recevoir les requêtes
  // Augmenter le temps si lors de l'appui d'un bouton, la position ne s'actualise pas

  _refreshPage() {
    setTimeout(() => {
      window.location.reload();
    }, 2000);
  }
}
