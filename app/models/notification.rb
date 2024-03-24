class Notification < ApplicationRecord
  belongs_to :hub
  belongs_to :notifiable, polymorphic: true

  def comment
    notifiable if notifiable_type == 'Comment'
  end

  def ticket
    notifiable if notifiable_type == 'Ticket'
  end
end
