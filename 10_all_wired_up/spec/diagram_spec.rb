require 'wires/diagram'

module Wires

  describe Diagram do
    before do
      @diagram = Diagram.new(<<-END.gsub(/^ {8}/, ''))
        0---|
            |
            O-----------@
        1---|
      END
    end

    describe "#at" do
      it "returns a Cell object" do
        @diagram.at(0, 0).should be_a Diagram::Cell
      end

      describe "a cell" do
        it "supports moving up/down/left/right" do
          @diagram.at(4, 3).up.value.should == "O"
          @diagram.at(4, 1).down.value.should == "O"
          @diagram.at(0, 0).left.should be_nil
          @diagram.at(0, 0).right.value.should == "-"
        end
      end

      it "sets the value of the cell" do
        @diagram.at(0, 0).value.should == "0"
        @diagram.at(0, 3).value.should == "1"
      end

      it "returns nil for empty cells" do
        @diagram.at(1, 1).should be_nil
      end

      it "returns nil if x or y is out of bounds" do
        @diagram.at(-1, 1).should be_nil
        @diagram.at(0, 4).should be_nil
      end
    end

    # it "can find the lightbulb" do
    #   Diagram.new("1--@").lightbulb.should be_a Lightbulb
    # end
  end
end
