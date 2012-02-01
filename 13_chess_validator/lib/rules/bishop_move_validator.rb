require 'rules/move_validator'

class BishopMoveValidator < MoveValidator
  def valid_movement?
    movement.diagonal?
  end
end
