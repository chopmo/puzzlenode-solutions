require 'parsers/action_parser'

describe ActionParser do
  def parse(s)
    ActionParser.new(s).parse
  end

  it "creates an action object from a valid string" do
    parse("+QH").should_not be_nil
  end

  it "fills data into the action object" do
    a = parse("+QH")
    a.player.should be_nil
    a.card.should == "QH"
    a.action_type.should == "+"
  end

  it "parses card values with 3 chars" do
    a = parse("+10H")
    a.card.should == "10H"
  end

  it "parses 2-char values with a trailing player name" do
    parse("-7C:Shady").card.should == "7C"
  end
end
