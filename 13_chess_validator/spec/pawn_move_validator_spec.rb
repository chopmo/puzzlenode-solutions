require 'parsers/board_parser'
require 'rules/pawn_move_validator'
require 'model/movement'
require 'model/move'

require_relative 'move_validator_spec_utils'

describe PawnMoveValidator do
  let (:subject_class) { PawnMoveValidator }
  let (:board) do
    text = <<END
bR bN bB bQ bK bB bN bR
-- bP -- bP bP bP bP bP
bP -- -- -- -- wP -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
wP -- bP -- -- -- -- --
-- wP wP wP wP -- wP wP
wR wN wB wQ wK wB wN wR
END
    BoardParser.new(text).parse
  end

  include MoveValidatorSpecUtils

  it "allows one or two steps forward from initial row" do
    valid_move?("b7", "b6").should be_true
    valid_move?("b2", "b3").should be_true
    valid_move?("b7", "b5").should be_true
    valid_move?("b2", "b4").should be_true
  end

  it "allows only one step forward from other row" do
    valid_move?("a6", "a5").should be_true
    valid_move?("a6", "a4").should be_false
    valid_move?("a3", "a4").should be_true
    valid_move?("a3", "a5").should be_false
  end

  it "disallows a backwards step" do
    valid_move?("a3", "a2").should be_false
  end

  it "disallows a diagonal step" do
    valid_move?("a3", "b4").should be_false
  end

  it "allows a diagonal step when capturing an opponent" do
    valid_move?("b2", "c3").should be_true
  end

  it "disallows capturing a piece by stepping forward" do
    valid_move?("c2", "c3").should be_false
  end
end
