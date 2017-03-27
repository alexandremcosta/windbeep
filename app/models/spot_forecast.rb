class SpotForecast < ApplicationRecord
  extend SpotForecast::Sync
  include SpotForecast::Direction

  belongs_to :spot
  validates_uniqueness_of :start_at, scope: :spot_id

  scope :in_future, -> { where('spot_forecasts.start_at > ?', Time.now) }
  scope :strong_wind, -> { where('spot_forecasts.wind_speed > 12') }
  scope :notificable, ->{ in_future.where(notified: false).strong_wind }
  scope :sorted, -> { order(:start_at) }


  def self.notify!
    update_all(notified: true)
  end

  def wind_direction_word
    direction_word
  end

  def should_update?
    if persisted?
      attribute_changed?(:wind_speed)
    else
      wind_speed > 10
    end
  end
end
