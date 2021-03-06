require 'test_helper'
require_relative '../helpers/forecast_test_helper'

class ForecastTest < ActiveSupport::TestCase
  include ForecastTestHelper

  setup do
    @spot = spots(:valid)
  end

  test ".find returns a collection of entries" do
    stub_forecast_for(forecast_html)
    entries = Forecast.find(@spot.code)

    refute_empty entries
    assert_instance_of Forecast::Entry, entries.first
  end

  test ".find returns an empty collection if spot if code is invalid" do
    stub_forecast_for(invalid_forecast_html)
    entries = Forecast.find(@spot.code)

    assert_empty entries
  end

  def stub_forecast_for(html)
    html = stub(read: html)
    Forecast.stubs(:open).returns(html)
  end
end

