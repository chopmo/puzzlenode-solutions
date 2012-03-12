require 'wires/component_parser'
require 'wires/cell'

module Wires
  class Diagram
    def initialize(ascii_diagram)
      @data = ascii_diagram.lines.map { |l| l.split(//) }
    end

    def at(x, y)
      return nil unless (0...@data.size).include?(y) and (0...@data[0].size).include?(x)
      char = @data[y][x]
      return nil if char == ' '
      ComponentParser.parse(Cell.new(self, x, y, char))
    end

    def lightbulb
      at(*lightbulb_position)
    end

    private
    def lightbulb_position
      @data.each_with_index do |line, line_idx|
        line.each_with_index do |col, col_idx|
          return [col_idx, line_idx] if col == "@"
        end
      end
      nil
    end
    
  end
end
