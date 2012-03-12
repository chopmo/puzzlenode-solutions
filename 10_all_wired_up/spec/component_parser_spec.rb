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
  end
end
