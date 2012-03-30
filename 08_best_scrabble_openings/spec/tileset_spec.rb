require 'tile_set'

describe TileSet do
  before do
    json =<<END
[
    "i4",
    "w5",
    "g6",
    "f7",
    "s2",
    "e1",
    "l3",
    "h8",
    "n1",
    "f7",
    "b8",
    "r12",
    "u3",
    "g6",
    "i4",
    "q9",
    "o3",
    "d2",
    "s2",
    "f7"
  ]
END
    @tileset = TileSet.from_json(json)
  end
  
  it "can parse itself from JSON" do
    @tileset.should_not be_nil
  end
  
  it "returns the occurence count for a letter" do
    @tileset.count("i").should == 2
  end
end
