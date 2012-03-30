require 'board'
require 'tile'
require 'placement'

describe Board do
  before do
    json =<<END
[
      "1 1 1 1 1 1 1 1 1 1 1 1",
      "1 1 1 2 1 2 1 1 1 1 1 1",
      "1 2 1 1 1 3 1 1 1 1 2 1",
      "2 1 1 1 1 1 1 1 1 2 2 1",
      "1 1 1 2 1 1 1 1 1 1 1 1",
      "1 1 1 1 1 1 2 1 1 1 2 1",
      "1 1 1 1 1 1 1 1 2 1 1 1",
      "1 1 1 1 1 1 1 1 1 1 1 2",
      "1 1 1 1 1 1 1 1 1 1 1 1"
  ]
END
    @board = Board.from_json(json)
  end
  
  it "creates a new instance from json" do
    @board.should_not be_nil
  end

  it "splits the board into cells" do
    @board.cell(3, 0).should == 2
    @board.cell(2, 1).should == 2
    @board.cell(2, 2).should == 1
  end


  context "it returns the score" do
    before do
      @tiles = [Tile.new("l3"),
                Tile.new("i4"),
                Tile.new("f7"),
                Tile.new("e1")]

    end

    specify "for a horizontal placement" do
      placement = Placement.new(1, 3, :horizontal, @tiles)
      @board.score(placement).should == 25
    end
  end
end
