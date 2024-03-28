class Ticket < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :notifiable
  after_update :send_notification

  enum status: { pending: 0, ended: 1 }, _prefix: :status
  enum category: { upgrade: 0, damage: 1 }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_one_attached :photo

  validates :title, :category, :address, :description, :status, :user_id, presence: true

  def total_up_votes
    votes.where(up_vote: true).count
  end

  def total_down_votes
    votes.where(up_vote: false).count
  end

  def within_area_of_user?(user)
    results = Geocoder.search(user.address)
    distance_to(results.first.coordinates).round(2) <= 2
  end

  def send_notification
    if status == "ended"
      User.all.each do |user|
        if within_area_of_user?(user)
          notification = self.notifications.create(
            hub_id: user.hub.id,
            notifiable_id: self.id
          )
          HubChannel.broadcast_to(
            notification.hub,
            # user_first_name: @ticket.user.first_name,
            # user_last_name: @ticket.user.last_name,
            # ticket_title: @ticket.title,
            # ticket_id: @ticket.id,
            # created_at: @notification.created_at,
            unread_notification: 1
            # notifiable_type: @notification.notifiable_type
          )
        end
      end
    end
  end
end
