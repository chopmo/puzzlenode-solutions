require 'wires/lightbulb'

module Wires
  class ComponentParser
    def self.parse(cell)
      case cell.value
      when /@/
        Lightbulb.new(cell)
      else
        fail "Unknown component #{cell}"
      end
    end
  end
end

