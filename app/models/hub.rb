class Hub < ApplicationRecord
  belongs_to :user
  has_many :notifications
end
