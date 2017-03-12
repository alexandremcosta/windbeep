class Spot::Creator
  include ActiveModel::Model

  attr_accessor :url, :user

  validates :user, presence: true
  validates :url, presence: true
  validates_format_of :url, with: Forecast::Config::URLREGEX

  def save
    if valid?
      user_spot = UserSpot.find_or_initialize_by(user: user, spot: spot)
      user_spot.save
    end
  end

  private
  def spot
    Spot.find_or_initialize_by(code: code)
  end

  def code
    url.match(Forecast::Config::URLREGEX)
    $1
  end
end
