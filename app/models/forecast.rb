module Forecast
  extend Forecast::Filter
  extend Forecast::Builder

  def self.find(spot_id)
    html   = open("https://www.windguru.cz/" + spot_id).read
    models = filter(html)
    models = build(models)

    models.map do |attributes|
      attributes.map { |attrs| Forecast::Entry.new(attrs) }
    end
  end
end
