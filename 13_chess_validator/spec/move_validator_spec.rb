require 'parsers/board_parser'
require 'rules/move_validator'

require_relative 'move_validator_spec_utils'

# Create a fake move validator to test the common functionality of the
# MoveValidator.
class FakeMoveValidator < MoveValidator

  # This is the part that varies most between validators, so we just
  # stub that out as always true.
  def valid_movement?
    true
  end
end

describe MoveValidator do
  let (:subject_class) { FakeMoveValidator }
  include MoveValidatorSpecUtils
  
  describe "path obstruction" do
    let (:board) do
      text = <<END
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- bP -- -- -- -- -- --
-- -- -- wP -- -- -- --
-- -- -- -- -- -- -- --
-- wR -- -- -- -- wP --
-- -- -- -- -- -- -- --
END
      BoardParser.new(text).parse
    end

    it "checks that the path is not obstructed" do
      valid_move?("b2", "f2").should be_true
      valid_move?("b2", "g2").should be_false
      valid_move?("b2", "h2").should be_false

      valid_move?("b2", "d4").should be_false

      valid_move?("b2", "b5").should be_true # capture
      valid_move?("b2", "b6").should be_false
    end
  end

  describe "check" do

    let (:board) do
      text = <<END
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- bR -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- wR -- -- -- -- -- --
-- wK -- -- -- -- -- --
END
      BoardParser.new(text).parse
    end

    it "prohibits a check condition" do
      valid_move?("b2", "b3").should be_true
      valid_move?("b2", "c2").should be_false
    end
  end

end
