require 'model/piece'

describe Piece do
  it "knows if it is a king" do
    Piece.new("bK").king?.should be_true
    Piece.new("bQ").king?.should be_false
  end
  
  it "knows if it is capturable" do
    Piece.new("bK").capturable?.should be_false
  end

  it "knows if it can capture another piece" do
    Piece.new("bP").can_capture?(Piece.new("wP")).should be_true
  end
end
