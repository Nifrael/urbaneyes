class Ticket < ApplicationRecord
  belongs_to :user
  has_many :votes
  has_many :comments

  enum :status, { pending: 0, ended: 1 }
<<<<<<< HEAD
  enum :type, { upgrade: 0, damage: 1 }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
=======
  enum :category, { upgrade: 0, damage: 1 }
>>>>>>> c1d14cedff9b8275724553643baaf25d36b71e7a
end
