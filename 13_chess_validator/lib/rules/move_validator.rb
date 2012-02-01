require 'rules/rulebook'

class MoveValidator
  def initialize(move)
    @move = move
  end

  def valid?
    valid_movement? && valid_path? && destination_ok? && !check?
  end

  def valid_movement?
    raise "#valid_movement? must be defined by subclasses"
  end

  def valid_path?
    @move.board.unobstructed_path_between?(@move.movement.from, @move.movement.to)
  end

  def destination_ok?
    target_piece = @move.board.piece_at(@move.movement.to)
    target_piece.nil? || @move.board.piece_at(@move.movement.from).can_capture?(target_piece)
  end

  def check?
    Rulebook.new(@move.board.apply(@move.movement)).check?(@move.piece.color)
  end

  def board
    @move.board
  end

  def movement
    @move.movement
  end

  def piece
    @move.piece
  end
end

