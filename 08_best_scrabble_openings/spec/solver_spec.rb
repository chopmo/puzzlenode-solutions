require 'solver'

describe Solver do
  it "solves the simple case" do
    sample_input = open(File.join(File.dirname(__FILE__), "../data/EXAMPLE_INPUT.json")).read
    sample_output = open(File.join(File.dirname(__FILE__), "../data/EXAMPLE_OUTPUT.txt")).read

    Solver.solve(sample_input).should == sample_output
  end
end
