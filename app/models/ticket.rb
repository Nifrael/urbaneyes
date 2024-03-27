class Ticket < ApplicationRecord
  belongs_to :user
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :notifiable

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
end
