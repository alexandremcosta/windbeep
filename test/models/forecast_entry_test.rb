require 'test_helper'
require_relative '../helpers/forecast_test_helper'

class ForecastEntryTest < ActiveSupport::TestCase
  include ForecastTestHelper

  setup do
    @entry = Forecast::Entry.new(entry_attributes)
  end

  test "define instance methods from attributes" do
    assert_equal entry_attributes[:wind_speed], @entry.wind_speed
  end

  test "#attributes should return its attributes" do
    assert_includes @entry.attributes, :wind_speed
    assert_includes @entry.attributes, :wind_direction
    assert_includes @entry.attributes, :wind_gust
    assert_includes @entry.attributes, :temperature
  end

  test "#time return parsed time" do
    assert_equal DateTime.new(2017, 3, 10, 15), @entry.time
  end
end

