require 'parsers/movement_parser'

describe MovementParser do
  def parse(s)
    MovementParser.new(s).parse
  end
  
  it "loads one movement per line of input" do
    parse("a1 b2\na2 b3\na3 b4").size.should == 3
  end

  it "returns movement objects" do
    m = parse("a1 b2").first
    m.from.should == "a1"
    m.to.should == "b2"
  end
end
