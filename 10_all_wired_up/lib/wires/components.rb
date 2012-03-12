module Wires
  class Component
    def initialize(cell)
      @cell = cell
    end

    def method_missing(name, *args)
      if [:up, :down, :left, :right].include?(name)
        @cell.send(name, *args)
      else
        super(name, *args)
      end
    end

    # def wiretrace(direction)
    #   Wiretrace.new(self, direction).target
    # end
  end
  
  class Lightbulb < Component
    def value
    end
  end

  class Signal < Component
    def value
      @cell.value == "1"
    end
  end

  class Wire < Component
    def value
      fail "Wires do not have a value. Use a Wiretrace"
    end
  end
end
