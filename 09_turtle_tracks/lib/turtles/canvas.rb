module Turtles
  class Canvas
    def initialize(size)
      @data = []
      @size = size
      @size.times do
        row = []
        size.times do
          row << "."
        end
        @data << row
      end
    end

    def mark(position)
      x, y = translate(position)
      @data[y][x] = "X"
    end

    def translate(position)
      x, y = *position
      [(x + @size/2).floor, (y + @size/2).floor]
    end
    
    def to_s
      res = ""
      @data.each do |line|
        res << line.join(" ") << "\n"
      end
      res
    end
  end
end
