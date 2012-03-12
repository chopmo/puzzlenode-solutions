module Wires
  class Parser

    attr_reader :diagram

    class Cell < Struct.new(:x, :y, :value)
      def foo
        diagram
      end
    end

    def initialize(diagram)
      @diagram = 42
    end

    def root_nodes
    end

    def indent_size
      # Assume first node is in the first row
      @diagram.lines.first.index(/\S/)
    end
  end
end
