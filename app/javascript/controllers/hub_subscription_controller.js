import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="hub-subscription"
export default class extends Controller {

  static values = {
    hubId: Number,
    userId: Number,
    count: Number,
    isHubPage: Boolean
  }
  static targets = ['notification', 'count', 'indicator']

  connect() {
    const userId = this.userIdValue;
    const consumer = createConsumer()
    console.log(this.isHubPageValue)
    console.log("connecté")

    consumer.subscriptions.create({ channel: "HubChannel", id: this.hubIdValue }, {
      received: (data) => {
        if (this.isHubPageValue) {
          this.addDataToCard(data);
        } else {
          this.updateCountUnreadNotifications(data);
        }
      }
    })
  }

  addDataToCard(data) {
    const firstName = data.user_first_name;
    const lastName = data.user_last_name;
    const ticketTitle = data.ticket_title;
    const ticketId = data.ticket_id;
    const creationDate = data.created_at;

    const card = `<div class="link-notification-card">
                    <a href="/tickets/${ticketId}">
                      <div class="notification-card">
                        <div class="notification-time">
                          <i><i class="fa-regular fa-comment"></i>${creationDate}</i>
                        </div>
                        <div class="text-notification">
                          <strong>${firstName} ${lastName} a commenté votre ticket :</strong>
                        </div>
                        <div class="text-notification">
                          <p>${ticketTitle}</p>
                        </div>
                      </div>
                    </a>
                  </div>`

    this.notificationTarget.insertAdjacentHTML("afterbegin", card);
  }

  updateCountUnreadNotifications(data) {
    const unread = data.unread_notification;
    console.log(unread)
    console.log('je suis dans la méthode')
    const newCount = this.countValue + unread;
    this.countTarget.innerHTML = newCount
    this.indicatorTarget.classList.remove('d-none')
  }
}
