import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="hub-subscription"
export default class extends Controller {

  static values = {
    hubId: Number,
    userId: Number
  }
  static targets = ['notification']

  connect() {
    const userId = this.userIdValue;
    const consumer=createConsumer()

    consumer.subscriptions.create({ channel: "HubChannel", id: this.hubIdValue }, {
      received: (data) => this.receiveData(data)
    })

    this.realtimeNotificationsElement = this.element;
  }

  receiveData(data) {
    const firstName = data.user_first_name;
    const lastName = data.user_last_name;
    const ticketTitle = data.ticket_title;

    const notificationsElement = document.createElement('div');
    notificationsElement.innerHTML = `<strong>${firstName} ${lastName}</strong> a commenté votre ticket <strong>"${ticketTitle}"</strong>.`;

    this.realtimeNotificationsElement.appendChild(notificationsElement);
  }


}
