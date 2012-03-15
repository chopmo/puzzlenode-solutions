require 'input_parser'

describe InputParser do
  it "splits the input into test cases" do
    text = open(File.join(File.dirname(__FILE__), "../data/sample-input.txt")).read
    test_cases = InputParser.parse(text)
    test_cases.size.should == 2
  end
end
