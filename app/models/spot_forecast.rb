class SpotForecast < ApplicationRecord
  extend SpotForecast::Sync

  belongs_to :spot

  scope :in_future, -> { where('spot_forecasts.start_at > ?', Time.now) }
  scope :strong_wind, -> { where('spot_forecasts.wind_speed > 12') }
  scope :notificable, ->{ in_future.where(notified: false).strong_wind }
  scope :sorted, -> { order(:start_at) }

  def self.notify!
    update_all(notified: true)
  end

  def wind_direction_word
    if wind_direction < 22.5
      'N'
    elsif wind_direction < 67.5
      'NE'
    elsif wind_direction < 112.5
      'E'
    elsif wind_direction < 157.5
      'SE'
    elsif wind_direction < 202.5
      'S'
    elsif wind_direction < 247.5
      'SW'
    elsif wind_direction < 292.5
      'W'
    elsif wind_direction < 337.7
      'NW'
    else
      'N'
    end
  end
end
