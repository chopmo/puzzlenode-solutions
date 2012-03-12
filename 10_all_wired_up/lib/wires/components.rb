require 'wires/wiretrace'

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

    def wiretrace(direction)
      Wiretrace.new(self, direction).target
    end
  end
  
  class Lightbulb < Component
    def value
      left.wiretrace(:left).value
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

  class XorGate < Component
    def value
      wiretrace(:up).value ^ wiretrace(:down).value
    end
  end

  class AndGate < Component
    def value
      wiretrace(:up).value && wiretrace(:down).value
    end
  end

  class NotGate < Component
    def value
      !(up ? wiretrace(:up).value : wiretrace(:down).value)
    end
  end
end
