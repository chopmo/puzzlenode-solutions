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

  it "creates a new instance from ascii" do
    b = Board.from_ascii(<<-END)
      1 1 1
      1 2 1
      1 3 1
      END
    b.cell(0, 0).should == 1
    b.cell(1, 1).should == 2
    b.cell(2, 1).should == 3
  end

  it "splits the board into cells" do
    @board.cell(3, 0).should == 2
    @board.cell(2, 1).should == 2
    @board.cell(2, 2).should == 1
  end

  it "finds the possible placements" do
    # XXX I'm unsure if this belongs here. Maybe I don't really understand SRP :/
    b = Board.from_ascii(<<-END)
      1 1 1
      1 1 1
      1 1 1
      END

    tiles = [Tile.new("f1"), Tile.new("o1"), Tile.new("o1")]
    placements = b.possible_placements(tiles)
    placements.size.should == 6

    placements.select { |p| p.orientation == :horizontal }.size.should == 3
    placements.select { |p| p.orientation == :vertical }.size.should == 3

    p = placements[0]
    p.row.should == 0
    p.column.should == 0

    tiles = [Tile.new("f1"), Tile.new("o1")]
    placements = b.possible_placements(tiles)
    placements.size.should == 12
    p = placements[2]
    p.row.should == 0
    p.column.should == 1
    p.orientation.should == :horizontal
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

    specify "for a vertical placement" do
      placement = Placement.new(1, 3, :vertical, @tiles)
      @board.score(placement).should == 19
    end
  end

  it "renders a placement" do
    b = Board.from_ascii(<<-END)
      1 1 1
      1 1 1
      1 1 1
    END

    p = Placement.new(0, 1, :vertical, [Tile.new("x1"), Tile.new("y1")])

    b.render(p).should ==<<-END.gsub(/^\s*/, '').sub(/\n\Z/, '')
      1 x 1
      1 y 1
      1 1 1
    END

  end
end
