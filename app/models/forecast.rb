module Forecast
  extend Forecast::Filter
  extend Forecast::Builder

  def self.find(spot_code)
    html     = open("https://www.windguru.cz/" + spot_code).read
    raw_data = filter(html)
    entries  = build(raw_data)

    entries.map do |attrs|
      Forecast::Entry.new(attrs)
    end
  end
end
