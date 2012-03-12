module Wires
  class Cell < Struct.new(:diagram, :x, :y, :value)
    def up; diagram.at(x, y-1) end
    def down; diagram.at(x, y+1) end
    def left; diagram.at(x-1, y) end
    def right; diagram.at(x+1, y) end
  end
end
