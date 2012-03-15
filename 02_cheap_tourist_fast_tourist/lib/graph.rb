require 'city'

class Graph
  def self.build(flights)
    new(flights)
  end

  def initialize(flights)
    flights.each do |f|
      from = city(f.from_city)
      to = city(f.to_city)
      from.outgoing << f
    end
  end

  def to_s
    s = ""
    cities.each do |city|
      s += city.to_s + "\n"
      city.outgoing.each do |f|
        s += "- " + f.to_s + "\n"
      end
      s += "\n"
    end
    s
  end


  private
  def city(name)
    result = cities.find { |c| c.name == name }
    if !result
      result = City.new(name)
      cities << result
    end
    result
  end

  def cities
    @cities ||= []
  end


end
