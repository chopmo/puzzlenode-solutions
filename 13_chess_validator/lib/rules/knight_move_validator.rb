require 'rules/move_validator'

class KnightMoveValidator < MoveValidator
  def valid_movement?
    cols = @move.movement.col_delta.abs
    rows = @move.movement.row_delta.abs

    (cols == 2 && rows == 1) || (cols == 1 && rows == 2)
  end
  
  def valid_path?
    true
  end
end
