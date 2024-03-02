class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  validates :user_id, uniqueness: { scope: :ticket_id, message: "Vous ne pouvez voter qu'une seule fois par ticket." }
end
