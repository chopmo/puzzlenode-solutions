require 'wires/diagram'

module Wires

  describe Diagram do
    it "returns a component in a position" do
      Diagram.new("1--@").at(0, 0).should be_a Signal
    end

    it "returns nil if position vacant" do
      Diagram.new("1--@").at(10, 10).should be_nil
    end
    
    it "can find the lightbulb" do
      Diagram.new("1--@").lightbulb.should be_a Lightbulb
    end
  end
end
