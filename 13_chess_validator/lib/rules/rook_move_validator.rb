require 'rules/move_validator'

class RookMoveValidator < MoveValidator
  def valid_movement?
    @move.movement.vertical? || @move.movement.horizontal?
  end
end


