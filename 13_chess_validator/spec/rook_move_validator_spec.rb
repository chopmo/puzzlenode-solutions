# Design notes:
#
# This is the first complete rule set, which is why it also checks for
# obstruction and check cases. 

require 'model/move'
require 'model/movement'
require 'parsers/board_parser'
require 'rules/rook_move_validator'

require_relative 'move_validator_spec_utils'

describe RookMoveValidator do
  let (:subject_class) { RookMoveValidator }
  let (:board) do
    board_text = <<END
-- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- 
wP -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- 
wR -- -- -- -- -- -- bR
END
    BoardParser.new(board_text).parse
  end

  let (:piece) { Piece.new("bR") }

  include MoveValidatorSpecUtils

  it "allows horizontal moves" do
    valid_move?("a1", "e1").should be_true
  end

  it "allows vertical moves" do
    valid_move?("a1", "a3").should be_true
  end

  it "disallows diagonal moves" do
    valid_move?("a1", "b2").should be_false
  end

  it "disallows other moves" do
    valid_move?("a1", "b3").should be_false
  end

  it "checks if someone is in the way" do
    valid_move?("a1", "a8").should be_false
  end

  it "checks if destination is free" do
    valid_move?("a1", "a4").should be_false
  end

  it "checks if destination can be captured" do
    valid_move?("a1", "h1").should be_true
  end
end
