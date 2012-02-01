# Design notes:
#
# A "move" in chess is the movement of a piece on a board. That is
# exactly what this class represents. It does not concern itself with
# the validity of the move.

class Move
  attr_reader :board
  attr_reader :movement
  attr_reader :piece

  def initialize(movement, piece, board)
    @movement = movement
    @piece = piece
    @board = board
  end

  def rank
    piece.rank
  end

  def to_s
    "#{piece ? piece.identity : '-'} from #{movement ? movement.from : '-'} to #{movement ? movement.to : '-'}"
  end
end
