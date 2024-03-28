class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :user
  has_many :notifications, as: :notifiable
  # after_destroy :send_notification

  validates :content, length: { minimum: 10, maximum: 250, message: "La longueur du commentaire doit être de 10 caractères minimum et 250 maximum." }

  # def send_notification
  #   notification = self.notifications.create(
  #     hub_id: user.hub.id,
  #     notifiable_content: "Un administrateur a effacé un de vos commentaires."
  #   )
  #   HubChannel.broadcast_to(
  #     notification.hub,
  #     # user_first_name: @ticket.user.first_name,
  #     # user_last_name: @ticket.user.last_name,
  #     # ticket_title: @ticket.title,
  #     # ticket_id: @ticket.id,
  #     # created_at: @notification.created_at,
  #     unread_notification: 1
  #     # notifiable_type: @notification.notifiable_type
  #   )
  # end
end
