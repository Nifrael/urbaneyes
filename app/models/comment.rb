class Comment < ApplicationRecord
  belongs_to :ticket
  belongs_to :user
  has_many :notifications, as: :notifiable

  validates :content, length: { minimum: 10, maximum: 250, message: "La longueur du commentaire doit être de 10 caractères minimum et 250 maximum." }
end
