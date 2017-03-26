require 'test_helper'
require_relative '../helpers/forecast_test_helper'

class FakeClass
  extend Forecast::Filter
end

class ForecastFilterTest < ActiveSupport::TestCase
  include ForecastTestHelper

  setup do
    @filter = FakeClass.filter(forecast_html)
  end

  test ".filter should return a hash" do
    assert_instance_of Hash, @filter
  end

  test ".filter should include forecast keys" do
    Forecast::Config::ALLKEYS.keys.each do |key|
      assert_includes @filter, key
    end
  end

  test ".filter should be empty if html is invalid" do
    invalid_filter = FakeClass.filter(invalid_forecast_html)
    assert_empty invalid_filter
  end

  test ".filter should return the most accurate model" do
    assert_match /wrf/i, @filter['model_name']
  end
end

class ForecastFilterNameTest < ActiveSupport::TestCase
  include ForecastTestHelper


  test ".filter_name should return spot name" do
    name = FakeClass.filter_name(forecast_html)
    assert name
  end

  test ".filter_name should return nil if not found" do
    name = FakeClass.filter_name("")
    refute name
  end
end

