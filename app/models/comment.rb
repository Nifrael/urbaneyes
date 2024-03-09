class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :user

  validates :content, length: { maximum: 250, message: "Le commentaire ne doit pas dépasser 250 caractères." }
end
