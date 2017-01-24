module Forecast::Config
  URLREGEX = /windguru\.cz\/(\d{6})/

  DAILYKEYS = {
    "WINDSPD" => :wind_speed,
    "WINDDIR" => :wind_direction,
    "GUST" => :wind_gust,
    "TMP" => :temperature,
    "hr_h" => :hour,
    "hr_d" => :day
  }

  COMMONKEYS = {
    "model_name" => :model_name,
    "update_last" => :last_update,
    "update_next" => :next_update,
    "init_d" => :initial_date
  }

  ALLKEYS = DAILYKEYS.merge(COMMONKEYS)
end
