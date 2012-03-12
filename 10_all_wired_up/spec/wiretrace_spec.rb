require 'wires/wiretrace'
require 'wires/diagram'

module Wires

  describe Wiretrace do

    def do_trace(ascii_diagram, position, direction)
      diagram = Diagram.new(ascii_diagram)
      trace = Wiretrace.new(diagram.at(*position), direction)
      trace.target
    end

    it "follows a straight line" do
      target = do_trace("0-----@", [5, 0], :left)
      target.should be_a Signal
      target.value.should be_false
    end

    it "follows up + a bend" do
      ascii_diagram = <<END
1--|
   |
   @
END
      target = do_trace(ascii_diagram, [3, 1], :up)
      target.should be_a Signal
      target.value.should be_true
    end

    it "follows down + a bend" do
      ascii_diagram = <<END
   @
   |
1--|
END
      target = do_trace(ascii_diagram, [3, 1], :down)
      target.should be_a Signal
      target.value.should be_true
    end


    it "can be initiated from a component" do
      diagram = Diagram.new("0-----@")
      diagram.lightbulb.left.wiretrace(:left).should be_a Signal
    end
  end

end
