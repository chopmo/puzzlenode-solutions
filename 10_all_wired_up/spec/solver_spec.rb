require 'wires/solver'
require 'wires/diagram'

module Wires
  describe Solver do
    it "solves a trivial diagram" do
      diagram = Diagram.new("1---@")
      Solver.new(diagram).solution.should == "on"
    end

    it "solves another trivial diagram" do
      diagram = Diagram.new("0---@")
      Solver.new(diagram).solution.should == "off"
    end
  end
end
