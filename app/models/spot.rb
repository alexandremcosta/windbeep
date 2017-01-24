class Spot < ApplicationRecord
  has_many :user_spots
  has_many :users, through: :user_spots
end
