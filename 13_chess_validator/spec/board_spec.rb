require 'parsers/board_parser'
require 'model/movement'

describe Board do
  let(:board) do
    ascii_board = <<END
-- -- -- -- bK -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- bP -- -- -- -- --
-- -- -- -- -- -- -- --
wP -- -- -- -- -- -- --
-- -- -- -- wK -- -- --
END
    BoardParser.new(ascii_board).parse
  end

  it "looks up pieces by position" do
    board.piece_at("a2").identity.should == "wP"
    board.piece_at("b2").should be_nil
  end


  it "can find opponents of a given piece" do
    board.opponents(mock(color: "b")).map(&:piece).map(&:identity).sort.should == ["wK", "wP" ]
    board.opponents(mock(color: "w")).map(&:piece).map(&:identity).sort.should == ["bK", "bP" ]
  end

  it "can apply a movement and return an updated board" do
    new_board = board.apply(Movement.new("a2", "b5"))
    new_board.piece_at("b5").identity.should == "wP"
    new_board.piece_at("e1").identity.should == "wK"
    new_board.piece_at("e8").identity.should == "bK"
  end

  it "can find a piece by identity" do
    board.find_piece_positions("bK").size.should == 1
    board.find_piece_positions("bK").first.should == "e8"
  end

  it "detects if a path between two positions is obstructed" do
    board.unobstructed_path_between?("b1", "b8").should be_true
    board.unobstructed_path_between?("a1", "a8").should be_false
    board.unobstructed_path_between?("a2", "c4").should be_true
    board.unobstructed_path_between?("a2", "d5").should be_false
  end

  it "checks if a position is free" do
    board.free?("a1").should be_true
    board.free?("a2").should be_false
  end

  it "finds the path between two positions" do
    board.path_between("a1", "a2").should == []
    board.path_between("a1", "a3").should == %w{ a2 }
    board.path_between("a1", "a8").should == %w{ a2 a3 a4 a5 a6 a7 }

    board.path_between("a1", "d1").should == %w{ b1 c1 }
    
    board.path_between("a1", "d4").should == %w{ b2 c3 }
  end

  it "can tell if a piece is threatened" do
    ascii_board = <<END
-- -- -- -- -- -- -- --
-- -- bP bP -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- wR -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
END
    board = BoardParser.new(ascii_board).parse
    board.threatened?("c7").should be_true
    board.threatened?("d7").should be_false
  end
end
