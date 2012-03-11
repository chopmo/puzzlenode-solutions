module Wires
  class Diagram

    class Cell < Struct.new(:diagram, :x, :y, :value)
      def up; diagram.at(x, y-1) end
      def down; diagram.at(x, y+1) end
      def left; diagram.at(x-1, y) end
      def right; diagram.at(x+1, y) end
    end

    def initialize(ascii_diagram)
      @data = ascii_diagram.lines.map { |l| l.split(//) }
    end

    def at(x, y)
      return nil unless (0...@data.size).include?(y) and (0...@data[0].size).include?(x)
      char = @data[y][x]
      return nil if char == ' '
      Cell.new(self, x, y, char)
    end

  end

end
