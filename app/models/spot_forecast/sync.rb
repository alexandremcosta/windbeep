module SpotForecast::Sync
  def synchronize(spot_code, entries)
    entries = Array(entries)
    spot = Spot.includes(:spot_forecasts).find_by_code(spot_code)
    spot_forecasts = build_forecasts(spot, entries)
    spot_forecasts = eligible_to_store(spot_forecasts)
    spot_forecasts.map(&:save)
  end

  private
  def build_forecasts(spot, entries)
    entries.map do |entry|
      spot_forecast = spot.spot_forecasts.find_or_initialize_by(start_at: entry.time)
      spot_forecast.assign_attributes(entry.attributes)
      spot_forecast
    end
  end

  def eligible_to_store(spot_forecasts)
    spot_forecasts.select do |sf|
      sf.persisted? || sf.wind_speed > 10
    end
  end
end

