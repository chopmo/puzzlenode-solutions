require 'wires/diagram'

module Wires

  describe Diagram do
    # before do
    #   @diagram = Diagram.new(<<-END.gsub(/^ {8}/, ''))
    #     0---|
    #         |
    #         O-----------@
    #     1---|
    #   END
    # end

    it "can find the lightbulb" do
      Diagram.new("1--@").lightbulb.should be_a Lightbulb
    end
  end
end
