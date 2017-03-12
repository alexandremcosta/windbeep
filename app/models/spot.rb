class Spot < ApplicationRecord
  has_many :user_spots
  has_many :users, through: :user_spots

  has_many :spot_forecasts

  validates_size_of :code, is: 6

  def url
    "http://windguru.cz/#{code}"
  end
end
