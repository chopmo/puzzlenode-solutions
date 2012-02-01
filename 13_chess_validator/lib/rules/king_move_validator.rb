require 'rules/move_validator'

class KingMoveValidator < MoveValidator
  def valid_movement?
    movement.col_delta.abs < 2 && movement.row_delta.abs < 2
  end
end
