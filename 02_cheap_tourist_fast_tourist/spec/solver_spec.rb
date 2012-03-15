require 'solver'
require 'input_parser'

describe Solver do
  it "solves the sample case" do
    test_cases = InputParser.parse(open(File.join(File.dirname(__FILE__), "../data/sample-input.txt")).read)
    Solver.solve(test_cases).should == open(File.join(File.dirname(__FILE__), "../data/sample-output.txt")).read
  end
end
