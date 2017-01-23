class Forecast::Entry
  def initialize(attrs)
    build(attrs)
  end

  private
  def build(attrs)
    time_keys = [:day, :hour, :initial_date]
    attrs.except(*time_keys).each { |k,v| create_method(k) { v } }
    create_method(:time) { parse_time(attrs.slice(*time_keys)) }
  end

  def create_method(name, &block)
    send(:define_singleton_method, name, &block)
  end

  def parse_time(attrs)
    date = initial_date(attrs)
    date = date + 1.month if current_day(attrs) < date.day
    DateTime.new(date.year, date.month, current_day(attrs), current_hour(attrs))
  end

  def initial_date(date_string)
    attrs = date_string[:initial_date].split('.').map(&:to_i)
    Date.new(*attrs.reverse)
  end

  def current_day(attrs); attrs[:day].to_i end
  def current_hour(attrs); attrs[:hour].to_i end

  def keys; Forecast::Config::ALLKEYS.invert end
end
