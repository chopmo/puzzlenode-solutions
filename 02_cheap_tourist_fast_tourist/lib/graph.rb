require 'city'
require 'formatter'

class Graph
  include Formatter

  class Node < Struct.new(:flight)
    include Formatter
    attr_accessor :connections

    def initialize(*args)
      super
      @connections = []
    end

    def to_s; format_node(self); end
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

  private
  def connect_flights(flights)
    queue = [@root]
    @nodes = flights.map { |f| Node.new(f) }
    while !queue.empty? do
      node = queue.shift
      @nodes.select { |k| node.flight.to_city == k.flight.from_city && node.flight.arrives <= k.flight.departs }.each do |connection|
        node.connections << connection
        queue << connection
      end
    end
    
    # @nodes.each do |n|
    #   n.connections = @nodes.select { |k| n.flight.to_city == k.flight.from_city && n.flight.arrives <= k.flight.departs }
    # end
  end
end
