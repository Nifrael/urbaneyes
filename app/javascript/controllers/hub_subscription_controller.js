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
  static targets = ['notification', 'count', 'indicator', 'bell']

  connect() {

    // if (!this.connected) {
    //   console.log('connecté')
    //   unread = 0;
    //   const consumer = createConsumer()

    //   consumer.subscriptions.create({ channel: "HubChannel", id: this.hubIdValue }, {
    //     received: (data) => {
    //       // if (!this.isHubPageValue) {
    //         this.updateCountUnreadNotifications(data);
    //       // }
    //         // this.addDataToCard(data);
    //       // } else {
    //     }
    //   })
    //   this.connected = true
    //   console.log(this.connected)
    // }


    if (!this.element.dataset.notification) {
      this.element.dataset.notification = true
      console.log('je suis connecté')
      this.unread = 0
      const consumer = createConsumer();
      this.subscription = consumer.subscriptions.create({ channel: "HubChannel", id: this.hubIdValue }, {
        received: (data) => {
          this.updateCountUnreadNotifications(data);
        }
      });
    }
    // if (!this.connected) {
    //   this.connectController();
    //   this.connected = true;
    // }
    // document.addEventListener('turbolinks:before-cache', this.disconnectController.bind(this));
  }

  updateCountUnreadNotifications(data) {
    const count = this.countTarget
    this.unread += data.unread_notification;
    console.log(this.unread)
    const newCount = this.countValue + this.unread;
    console.log(newCount)
    count.innerHTML = newCount
    this.indicatorTarget.classList.remove('d-none')
    this.bellTarget.classList.add('layer-active')
    setTimeout(() => {
      this.bellTarget.classList.remove('layer-active');
    }, 11000);
  }

  // addDataToCard(data) {
  //   const firstName = data.user_first_name;
  //   const lastName = data.user_last_name;
  //   const ticketTitle = data.ticket_title;
  //   const ticketId = data.ticket_id;
  //   const creationDate = data.created_at;

  //   const commentCard = `<div class="link-notification-card">
  //                           <a href="/tickets/${ticketId}">
  //                             <div class="notification-card">
  //                               <div class="notification-time">
  //                                 <i><i class="fa-regular fa-comment"></i>${creationDate}</i>
  //                               </div>
  //                               <div class="text-notification">
  //                                 <strong>${firstName} ${lastName} a commenté votre ticket :</strong>
  //                               </div>
  //                               <div class="text-notification">
  //                                 <p>${ticketTitle}</p>
  //                               </div>
  //                             </div>
  //                           </a>
  //                         </div>`

  //   const ticketCard = `<div class="link-notification-card">
  //                         <a href="/tickets/${ticketId}">
  //                           <div class="notification-card">
  //                             <div class="notification-time">
  //                               <i><i class="fa-regular fa-comment"></i>${creationDate}</i>
  //                             </div>
  //                             <div class="text-notification">
  //                               <strong>${firstName} ${lastName} a créé un ticket près de vous : ${ticketTitle}</strong>
  //                             </div>
  //                           </div>
  //                         </a>
  //                        </div>`

  //   if (data.notifiable_type === 'Comment') {
  //     this.notificationTarget.insertAdjacentHTML("afterbegin", commentCard);
  //   } else {
  //     this.notificationTarget.insertAdjacentHTML("afterbegin", ticketCard);
  //   }
  // }



  disconnect() {
      if (this.subscription) {
      this.element.dataset.notification = false
      this.subscription.unsubscribe();
      console.log('je me deconnecte')
      // this.disconnectController();
      // this.connected = false;
      // document.removeEventListener('turbolinks:before-cache', this.disconnectController.bind(this));
    }
  }

  connectController() {
    // console.log('je suis connecté')
    // unread = 0
    // const consumer = createConsumer();
    // this.subscription = consumer.subscriptions.create({ channel: "HubChannel", id: this.hubIdValue }, {
    //   received: (data) => {
    //     this.updateCountUnreadNotifications(data);
    //   }
    // });
  }

  // disconnectController() {
  //   if (this.subscription) {
  //     this.subscription.unsubscribe();
  //     console.log('je me déconnecte')
  //   }
  // }
}
