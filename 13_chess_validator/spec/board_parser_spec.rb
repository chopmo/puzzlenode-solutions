require 'parsers/board_parser'

describe BoardParser do
  it "parses a board file" do
    text = open(File.join(File.dirname(__FILE__), "data", "simple_board.txt")).read
    board = BoardParser.new(text).parse
    board.piece_at("a1").identity.should == "wR"
    board.piece_at("b1").identity.should == "wN"
    board.piece_at("a2").identity.should == "wP"
    board.piece_at("h8").identity.should == "bR"
  end
end
