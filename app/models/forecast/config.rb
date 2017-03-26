module Forecast::Config
  MODELNAMEREGEX = /(GFS|WRF)\s*(\d+)\s*KM/i
  URLREGEX = /windguru\.cz\/(\d{2,6})/

  DAILYKEYS = {
    "WINDSPD" => :wind_speed,
    "WINDDIR" => :wind_direction,
    "GUST" => :wind_gust,
    "TMP" => :temperature,
    "hr_h" => :hour,
    "hr_d" => :day
  }

  COMMONKEYS = {
    "model_name" => :model,
    "update_last" => :last_update,
    "update_next" => :next_update,
    "init_d" => :initial_date
  }

  ALLKEYS = DAILYKEYS.merge(COMMONKEYS)

  INFOATTRIBUTES = [:wind_speed, :wind_direction, :wind_gust, :temperature, :model]
end
