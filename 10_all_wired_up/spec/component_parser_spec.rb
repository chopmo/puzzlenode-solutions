require 'wires/component_parser' 
require 'wires/cell' 

module Wires
  describe ComponentParser do

    def parse(char) 
      ComponentParser.parse(Cell.new(nil, 0, 0, char))
    end
    
    it "creates a lightbulb from a @ cell" do
      parse("@").should be_a Lightbulb
    end

    it "creates a signal from 1" do
      c = parse("1")
      c.should be_a Signal
      c.value.should be_true
    end

    it "creates a signal from 0" do
      c = parse("0")
      c.should be_a Signal
      c.value.should be_false
    end

    it "creates a wire from | or -" do
      parse("-").should be_a Wire
      parse("|").should be_a Wire
    end

    it "creates an XOR gate from X" do
      parse("X").should be_a XorGate
    end

    it "creates an AND gate from A" do
      parse("A").should be_a AndGate
    end
  end
end
