require 'nokogiri'
require 'json'

module Forecast::Filter
  include Forecast::Config

  def filter(html)
    forecasts = find_js_data(html)
    forecasts.map do |tab|
      filter_data(parse(tab))
    end.select do |forecast|
      forecast["model_name"] =~ /(GFS|WRF)/i
    end
  end

  private
  def find_js_data(html)
    str  = String(html)
    data = Nokogiri::HTML(str).search("script").map(&:text).join
    data = data.scan(/var wg_fcst_tab_data_\d = (\{.*\})/).map(&:first)
  end

  def parse(string)
    JSON.parse(string)
  end

  def filter_data(data)
    data['fcst'].values.first.slice(*relevant_keys)
  end

  def relevant_keys
    ALLKEYS.keys
  end
end
