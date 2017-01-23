class Forecast::Builder
  DAILYKEYS = {
    "WINDSPD" => :wind_speed,
    "WINDDIR" => :wind_direction,
    "GUST" => :gust,
    "TMP" => :temperature,
    "APCP" => :rain,
    "hr_weekday" => :weekday,
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

  def initialize(info)
    @data = info
  end

  def build
    days = @data[DAILYKEYS.first.first].size

    (0...days).map do |day|
      daily_info(day).merge(common_info)
    end
  end

  private
  def daily_info(day)
    DAILYKEYS.map { |old_key, new_key| [new_key, @data[old_key][day]] }.to_h
  end

  def common_info
    COMMONKEYS.map { |old_key, new_key| [new_key, @data[old_key]]}.to_h
  end
end
