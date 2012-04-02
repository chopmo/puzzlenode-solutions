require 'dictionary'
require 'tile_set'

describe Dictionary do
  before do
    json =<<END
[
    "gyre",
    "gimble",
    "wabe",
    "mimsy",
    "borogoves",
    "raths",
    "outgrabe",
    "jabberwock",
    "jubjub",
    "shun",
    "frumious",
    "bandersnatch",
    "vorpal",
    "manxome",
    "foe",
    "tumtum",
    "uffish",
    "whiffling",
    "tulgey",
    "burbled",
    "galumphing",
    "frabjous",
    "callooh",
    "callay",
    "chortled",
    "brillig",
    "slithy",
    "toves",
    "gyre",
    "gimble",
    "mome"
  ]
END
    @dictionary = Dictionary.from_json(json)
  end
  
  
  it "can parse itself from JSON" do
    @dictionary.should_not be_nil
    @dictionary.words[0].should == "gyre"
    @dictionary.words[1].should == "gimble"
  end

  it "can reduce itself given a tileset" do
    tileset = TileSet.from_json('["m1", "o1", "m1", "e2"]')
    @dictionary.reject_unplacable(tileset)
    @dictionary.words.should == ["mome"]
  end
end
