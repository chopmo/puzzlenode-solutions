require 'rules/move_validator'

class QueenMoveValidator < MoveValidator
  def valid_movement?
    movement.diagonal? || movement.vertical? || movement.horizontal?
  end
end
