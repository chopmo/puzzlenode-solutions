module Turtles
  class Canvas
    def initialize(size)
      @data = []
      size.times do
        row = []
        size.times do
          row << "."
        end
        @data << row
      end
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
