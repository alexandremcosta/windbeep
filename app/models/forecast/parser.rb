require 'nokogiri'
require 'json'

class Forecast::Parser
  def initialize(string)
    @doc = Nokogiri::HTML(string)
  end

  def parse
    scripts = @doc.search("script").map(&:text).join
    info = scripts.match(/var wg_fcst_tab_data_1 = (\{.*\})/)[1]
    info = JSON.parse(info)
    info['fcst'].values.first
  end
end
