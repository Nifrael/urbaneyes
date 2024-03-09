class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tickets
  has_many :votes
  has_many :comments

  enum role: { user: 0, admin: 1 }

  validates :first_name, :last_name, :address, presence: true
end
