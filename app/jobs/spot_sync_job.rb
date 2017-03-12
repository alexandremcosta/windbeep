class SpotSyncJob < ApplicationJob
  def perform(code)
    forecasts = Forecast.find(code)
    SpotForecast.synchronize(code, forecasts)
  end
end
