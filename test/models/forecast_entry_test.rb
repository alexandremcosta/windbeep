require 'test_helper'
require_relative '../helpers/forecast_test_helper'

class ForecastEntryTest < ActiveSupport::TestCase
  include ForecastTestHelper

  setup do
    @attrs = { :wind_speed=>6.2, :wind_direction=>131, :wind_gust=>6.3, :temperature=>31.6,
               :hour=>"15", :day=>"10", :model=>"WRF 12 km", :last_update=>"2017-03-11 15:00:02",
               :next_update=>"2017-03-11 20:30:00", :initial_date=>"10.03.2017"}
    @entry = Forecast::Entry.new(@attrs)
  end

  test "define instance methods from attributes" do
    assert_equal @attrs[:wind_speed], @entry.wind_speed
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

