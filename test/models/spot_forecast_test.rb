require 'test_helper'
require_relative '../helpers/forecast_test_helper'

class SpotForecastTest < ActiveSupport::TestCase
  include ForecastTestHelper

  setup do
    @spot = spots(:valid)
    @entry = Forecast::Entry.new(entry_attributes)
  end

  test ".synchronize creates valid entries" do
    spot_forecasts = SpotForecast.synchronize(@spot.code, @entry)
    refute_empty spot_forecasts
  end

  test ".synchronize updates valid entries" do
    spot_forecast = SpotForecast.new(start_at: @entry.time, spot: @spot)
    spot_forecast.assign_attributes(@entry.attributes)
    spot_forecast.save

    low_wind = Forecast::Entry.new(low_wind_attributes)

    old_speed = spot_forecast.wind_speed
    SpotForecast.synchronize(@spot.code, low_wind)
    assert_not_equal old_speed, spot_forecast.reload.wind_speed
  end

  test ".synchronize doest not create invalid entries" do
    invalid_entry = Forecast::Entry.new(low_wind_attributes)
    spot_forecasts = SpotForecast.synchronize(@spot.code, invalid_entry)
    assert_empty spot_forecasts
  end

  def low_wind_attributes
    entry_attributes.tap do |attrs|
      attrs[:wind_speed] = 1
    end
  end
end
