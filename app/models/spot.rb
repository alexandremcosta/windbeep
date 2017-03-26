class Spot < ApplicationRecord
  has_many :user_spots
  has_many :users, through: :user_spots

  has_many :spot_forecasts

  validates_length_of :code, in: 2..6
  validates_presence_of :name

  def url
    "http://windguru.cz/#{code}"
  end
end
