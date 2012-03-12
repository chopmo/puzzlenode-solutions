require 'wires/solver'
require 'wires/diagram'

module Wires
  describe Solver do
    def solve(ascii_diagram)
      diagram = Diagram.new(ascii_diagram)
      Solver.new(diagram).solution
    end

    it "solves a trivial diagram" do
      solve("1---@").should == "on"
    end

    it "solves another trivial diagram" do
      solve("0---@").should == "off"
    end

    it "solves a more complex diagram" do
      ascii_diagram =<<-END
        0-------------|
                      A------------|
        1-------------|            |
                                   X------------@
        1-------------|            |
                      N------------|
      END

      solve(ascii_diagram).should == "off"
    end
  end
end
