module Forecast::Builder
  include Forecast::Config

  def build(models)
    models.map do |data|
      days = data[DAILYKEYS.first.first].size
      common = common_info(data)

      (0...days).map do |day|
        daily = daily_info(data, day)
        daily.merge(common)
      end
    end
  end

  private
  def daily_info(data, day)
    DAILYKEYS.map { |old_key, new_key| [new_key, data[old_key][day]] }.to_h
  end

  def common_info(data)
    COMMONKEYS.map { |old_key, new_key| [new_key, data[old_key]]}.to_h
  end
end
