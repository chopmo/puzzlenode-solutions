require 'solver'

describe Solver do
  it "solves the sample input" do
    input = open(File.join(File.dirname(__FILE__), "../data/sample_input.txt")).read
    rentals = open(File.join(File.dirname(__FILE__), "../data/sample_vacation_rentals.json")).read
    output = open(File.join(File.dirname(__FILE__), "../data/sample_output.txt")).read

    Solver.solve(input, rentals).should == output
  end
end
