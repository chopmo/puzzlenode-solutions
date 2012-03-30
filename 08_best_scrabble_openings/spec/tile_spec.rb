require 'tile'

describe Tile do
  it "can be parsed from a string" do
    t = Tile.new("l3")
    t.letter.should == "l"
    t.value.should == 3
  end
end
