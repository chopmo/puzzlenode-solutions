require 'wires/components'

module Wires
  class ComponentParser
    def self.parse(cell)
      case cell.value
      when /@/
        Lightbulb.new(cell)
      when /1|0/
        Signal.new(cell)
      else
        fail "Unknown component #{cell}"
      end
    end
  end
end

