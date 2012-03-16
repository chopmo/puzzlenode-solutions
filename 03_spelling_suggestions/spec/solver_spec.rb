require 'solver'

describe Solver do
  it "solves the sample case" do
    input = open(File.join(File.dirname(__FILE__), "../data/SAMPLE_INPUT.txt")).read
    output = open(File.join(File.dirname(__FILE__), "../data/SAMPLE_OUTPUT.txt")).read
    Solver.solve(input).should == output
  end
end
