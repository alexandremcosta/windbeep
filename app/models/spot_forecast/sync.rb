module SpotForecast::Sync
  def synchronize(spot_code, entries)
    entries = Array(entries)
    spot = Spot.includes(:spot_forecasts).find_by_code(spot_code)

    build_forecasts(spot, entries)
      .select(&:should_update?)
      .map(&:save)
  end

  private
  def build_forecasts(spot, entries)
    entries.map do |entry|
      spot_forecast = spot.spot_forecasts.find_or_initialize_by(start_at: entry.time)
      spot_forecast.assign_attributes(entry.attributes)
      spot_forecast.notified = false
      spot_forecast
    end
  end
end

