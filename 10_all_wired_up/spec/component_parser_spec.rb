require 'wires/component_parser' 

module Wires
  describe ComponentParser do
    describe ComponentBuilder do
      let (:diagram) { Diagram.new("@01-|AOXN")
        it "creates a lightbulb from a @ cell" do
          
          b = ComponentBuilder.new()
          b.at([0,0]).should be_a Lightbulb
        end
      end

    end
  end
end
