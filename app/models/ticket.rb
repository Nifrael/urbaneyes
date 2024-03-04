class Ticket < ApplicationRecord
  belongs_to :user
  has_many :votes
  has_many :comments

  enum :status, { pending: 0, ended: 1 }
  enum :category, { upgrade: 0, damage: 1 }
end
