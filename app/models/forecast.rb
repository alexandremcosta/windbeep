class Forecast
  attr_reader :entries

  def initialize(spot_id)
    html = open("https://www.windguru.cz/" + spot_id).read
    hash = Forecast::Parser.new(html).parse
    @entries = Forecast::Builder.new(hash).build
  end
end
