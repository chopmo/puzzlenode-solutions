require 'wires/components'

module Wires
  class ComponentParser
    def self.parse(cell)
      case cell.value
      when /@/
        Lightbulb.new(cell)
      when /1|0/
        Signal.new(cell)
      when /-|\|/
        Wire.new(cell)
      when /X/
        XorGate.new(cell)
      when /A/
        AndGate.new(cell)
      when /N/
        NotGate.new(cell)
      when /O/
        OrGate.new(cell)
      else
        fail "Unknown component #{cell.value} at #{cell.x},#{cell.y}"
      end
    end
  end
end

