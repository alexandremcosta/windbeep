require 'test_helper'
require_relative '../helpers/forecast_test_helper'

class FakeClass
  extend Forecast::Builder
end

class ForecastBuilderTest < ActiveSupport::TestCase
  include ForecastTestHelper

  setup do
    @build = FakeClass.build(raw_forecast_hash)
  end

  test ".build should return a collection of data" do
    refute_empty @build
  end

  test ".build should return data with translated keys" do
    Forecast::Config::ALLKEYS.values.each do |key|
      assert_includes @build.first.keys, key
    end
  end

  test ".build should return an empty collection if data is empty" do
    assert_empty FakeClass.build({})
  end
end

