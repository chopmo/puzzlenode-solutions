module Wires
  class Component
    def initialize(cell)
      @cell = cell
    end
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
end
