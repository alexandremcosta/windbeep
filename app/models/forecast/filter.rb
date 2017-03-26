require 'nokogiri'
require 'json'

module Forecast::Filter
  include Forecast::Config

  def filter(html)
    tabs = find_js_data(html)
    tabs = tabs.map { |tab| filter_data(parse(tab)) }

    most_accurate(tabs) || Hash.new
  end

  def filter_name(html)
    sample_tab = find_js_data(html).first || "{}"
    parse(sample_tab)['spot']
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

  def most_accurate(tabs)
    tabs
      .select { |tab| String(tab["model_name"]) =~ MODELNAMEREGEX }
      .sort { |one, other| compare_accuracy(one, other) }
      .first
  end

  def compare_accuracy(one, other)
    return 0 unless other

    one["model_name"] =~ MODELNAMEREGEX
    one_model = $1
    one_distance = $2.to_i

    other["model_name"] =~ MODELNAMEREGEX
    other_model = $1
    other_distance = $2.to_i

    return one_distance <=> other_distance if one_model == other_model
    one_model == 'WRF' ? -1 : 1
  end
end
