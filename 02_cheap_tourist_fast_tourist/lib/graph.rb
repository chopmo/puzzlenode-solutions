require 'city'
require 'formatter'

class Graph
  include Formatter

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
      (previous ? previous.route : []) + [self]
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
