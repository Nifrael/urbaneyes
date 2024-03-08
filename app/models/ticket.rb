class Ticket < ApplicationRecord
  belongs_to :user
  has_many :votes
  has_many :comments

  enum status: { pending: 0, ended: 1 }, _prefix: :status
  enum category: { upgrade: 0, damage: 1 }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def total_up_votes
    votes.where(up_vote: true).count
  end

  def total_down_votes
    votes.where(up_vote: false).count
  end
end
