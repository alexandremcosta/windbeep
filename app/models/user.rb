class User < ApplicationRecord
  has_many :user_spots
  has_many :spots, through: :user_spots

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
