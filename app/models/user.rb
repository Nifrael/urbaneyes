class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tickets
  has_many :votes
  has_many :comments

  geocoded_by :current_position_address
  reverse_geocoded_by :latitude, :longitude, address: :current_position_address
  before_validation :set_default_current_position_address, on: :create
  after_validation :geocode

  enum role: { user: 0, admin: 1 }

  validates :first_name, :last_name, :address, :current_position_address, presence: true

  def set_default_current_position_address
    self.current_position_address = address if current_position_address.blank?
  end
end
