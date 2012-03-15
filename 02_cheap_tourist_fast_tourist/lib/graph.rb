require 'time'
require 'bigdecimal'

require 'city'
require 'formatter'

class Graph
  include Formatter

  class Route < Struct.new(:flights)
    def from_city; flights.first.from_city; end
    def to_city; flights.last.to_city; end
    def departs; flights.first.departs; end
    def arrives; flights.last.arrives; end

    def duration
      Time.parse(arrives) - Time.parse(departs)
    end

    def formatted_duration
      minutes = duration / 60
      hours = minutes / 60
      minutes = minutes % 60
      
      format("%02d:%02d", hours, minutes)
    end

    def price
      flights.inject(BigDecimal.new("0.0")) { |s, f| s + BigDecimal.new(f.price) }
    end

    def formatted_price
      price.to_f.to_s
    end

    def to_s
      flights.map(&:to_s).join("\n ->") + "\nPRICE: #{formatted_price}\nDURATION: #{formatted_duration}"
    end
  end

  class Node < Struct.new(:flight)
    include Formatter
    attr_accessor :connections
    attr_accessor :previous

    def initialize(*args)
      super
      @connections = []
    end

    def has_visited?(city)
      [flight.from_city, flight.to_city].include?(city) || (previous && previous.has_visited?(city))
    end
    
    def to_s; format_node(self); end

    def route
      n = self
      nodes = []
      while n && n.flight.from_city != "-"
        nodes.unshift(n)
        n = n.previous
      end
      Route.new(nodes.map(&:flight))
    end
  end
  
  def self.build(flights)
    new(flights)
  end

  def initialize(flights)
    @root = Node.new(Flight.new("-", "A", nil, "00:00", nil))
    connect_flights(flights)
  end

  attr_reader :root, :nodes

  def to_s; format_graph(self); end

  def routes_to(city)
    @nodes.select { |n| n.flight.to_city == city }.map(&:route)
  end

  def cheapest_route
    routes_to("Z").sort_by(&:price).first
  end


  private
  def connect_flights(flights)
    queue = [@root]
    # @nodes = flights.map { |f| Node.new(f) }
    @nodes = []
    
    while !queue.empty? do
      node = queue.shift
      @nodes << node
      flights.select { |f| node.flight.to_city == f.from_city && node.flight.arrives <= f.departs && !node.has_visited?(f.to_city) }.each do |flight|
        next_node = Node.new(flight)
        next_node.previous = node
        node.connections << next_node
        queue << next_node
      end
    end
    
    # @nodes.each do |n|
    #   n.connections = @nodes.select { |k| n.flight.to_city == k.flight.from_city && n.flight.arrives <= k.flight.departs }
    # end
  end
end
