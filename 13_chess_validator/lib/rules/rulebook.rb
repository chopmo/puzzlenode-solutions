require 'rules/pawn_move_validator'
require 'rules/rook_move_validator'
require 'rules/knight_move_validator'
require 'rules/bishop_move_validator'
require 'rules/queen_move_validator'
require 'rules/king_move_validator'

class Rulebook
  class FalseMoveValidator < MoveValidator
    def valid_movement?; false; end
  end

  def initialize(board)
    @board = board
  end

  def check?(color)
    king_pos = @board.find_piece_positions("#{color}K").first
    return false unless king_pos # Only happens in test cases obviously
    @board.threatened?(king_pos)
  end

  def self.move_validator_for(move)
    return FalseMoveValidator.new(move) unless move.piece
    klass = case move.rank
            when "R" then RookMoveValidator
            when "P" then PawnMoveValidator
            when "N" then KnightMoveValidator
            when "B" then BishopMoveValidator
            when "Q" then QueenMoveValidator
            when "K" then KingMoveValidator
            else raise "No validator for rank #{move.rank}"
            end

    klass.new(move)
  end
end
