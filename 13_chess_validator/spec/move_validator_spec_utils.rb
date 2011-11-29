require 'model/movement'
require 'model/move'

module MoveValidatorSpecUtils
  def valid_move?(from, to, board = board)
    piece = board.piece_at(from)
    movement = Movement.new(from, to)
    move = Move.new(movement, piece, board)
    subject_class.new(move).valid?
  end
end
