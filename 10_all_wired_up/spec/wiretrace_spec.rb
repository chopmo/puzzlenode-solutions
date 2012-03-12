require 'wires/wiretrace'
require 'wires/diagram'

module Wires

  describe WireTrace do
    it "follows a straight line" do
      diagram = Diagram.new("0-----@")
      trace = WireTrace.new(diagram.at(5, 0), :left)
      trace.target.should be_a Signal
      trace.target.value.should be_false
    end
  end

end
