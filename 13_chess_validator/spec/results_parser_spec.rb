require 'parsers/results_parser'

describe ResultsParser do
  def parse(s)
    ResultsParser.new(s).parse
  end
  
  it "reads a result per line of input" do
    parse("LEGAL").size.should == 1
    parse("LEGAL\nILLEGAL").size.should == 2
  end

  it "parses LEGAL as true" do
    parse("LEGAL").first.should be_true
  end

  it "parses ILLEGAL as false" do
    parse("ILLEGAL").first.should be_false
  end
end
