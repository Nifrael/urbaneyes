import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

let unread = 0;

// Connects to data-controller="hub-subscription"
export default class extends Controller {

  static values = {
    hubId: Number,
    userId: Number,
    count: Number,
    isHubPage: Boolean
  }
  static targets = ['notification', 'count', 'indicator', 'bell']

  connect() {
    const userId = this.userIdValue;
    const consumer = createConsumer()

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

    const commentCard = `<div class="link-notification-card">
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

    const ticketCard = `<div class="link-notification-card">
                          <a href="/tickets/${ticketId}">
                            <div class="notification-card">
                              <div class="notification-time">
                                <i><i class="fa-regular fa-comment"></i>${creationDate}</i>
                              </div>
                              <div class="text-notification">
                                <strong>${firstName} ${lastName} a créé un ticket près de vous : ${ticketTitle}</strong>
                              </div>
                            </div>
                          </a>
                         </div>`

    if (data.notifiable_type === 'Comment') {
      this.notificationTarget.insertAdjacentHTML("afterbegin", commentCard);
    } else {
      this.notificationTarget.insertAdjacentHTML("afterbegin", ticketCard);
    }
  }

  updateCountUnreadNotifications(data) {
    unread += data.unread_notification;
    const newCount = this.countValue + unread;
    this.countTarget.innerHTML = newCount
    this.indicatorTarget.classList.remove('d-none')
    this.bellTarget.classList.add('layer-active')
    setTimeout(() => {
      this.bellTarget.classList.remove('layer-active');
    }, 11000);
  }
}
