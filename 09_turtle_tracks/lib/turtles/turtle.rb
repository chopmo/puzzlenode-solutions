module Turtles
  class Turtle
    def initialize(position, orientation)
      @position = position
      @orientation = orientation
      @direction = 1
      @steps_remaining = 0
    end

    def position
      @position
    end

    def execute(cmd)
      method_name = cmd.split.first.downcase
      arg = cmd.split.last.to_i
      send(method_name, arg)
    end

    def rt(degrees)
      rotate(degrees)
    end

    def lt(degrees)
      rotate(-degrees)
    end

    def fd(steps)
      @steps_remaining = steps
    end

    def rotate(degrees)
      @orientation = (@orientation + degrees) % 360
    end

    def move
      if @steps_remaining > 0
        update_position
        @steps_remaining -= 1
        true
      else
        return false
      end
    end

    def update_position
      @position[0] += (x_delta * @direction)
      @position[1] += (y_delta * @direction)
    end

    def x_delta
      Math.sin(deg_to_rad(@orientation)).round
    end

    def y_delta
      Math.cos(deg_to_rad(@orientation)).round * -1
    end

    def deg_to_rad(degrees)
      degrees * Math::PI / 180 
    end

    def to_s
      "Turtle @[#{@position.first} #{@position.last}], orientation #{@orientation}, direction #{@direction}, steps remaining #{@steps_remaining}"
    end
  end
end
