require 'rules/move_validator'

class PawnMoveValidator < MoveValidator
  def valid_movement?
    movement = @move.movement
    rows_forward = movement.row_delta

    if @move.piece.color == "b"
      rows_forward *= -1
      initial_move = movement.from_row == 7
    else
      initial_move = movement.from_row == 2
    end

    if capturing_opponent
      (rows_forward == 1) && (movement.col_delta.abs == 1)
    else
      (movement.col_delta == 0) && ((rows_forward == 1) || (initial_move && rows_forward == 2))
    end
  end

  private
  def capturing_opponent
    opponent = board.piece_at(movement.to)
    return false unless opponent
    piece.can_capture?(opponent)
  end
end
