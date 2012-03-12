require 'wires/diagram_splitter'
require 'wires/diagram'

module Wires
  class Solver
    def initialize(diagram)
      @diagram = diagram
      solve
    end

    attr_reader :solution

    def self.solve_file(filename)
      DiagramSplitter.split(open(filename).read).map { |ascii_diagram|
        new(Diagram.new(ascii_diagram)).solve
      }.join("\n")
    end

    def solve
      @solution = @diagram.lightbulb.value ? "on" : "off"
    end
  end
end
