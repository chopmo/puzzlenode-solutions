require 'model/piece'
require 'model/move'
require 'model/game_piece'
require 'rules/rulebook'

class Board
  def initialize
    @pieces = {}
  end

  def add_piece(identity, position)
    @pieces[position] = Piece.new(identity)
  end
  
  def piece_at(position)
    @pieces[position]
  end

  def find_piece_positions(identity)
    @pieces.map do |pos, piece|
      pos if piece.identity == identity
    end.compact
  end
  
  def opponents(piece)
    @pieces.select { |pos, p| p.color != piece.color }.map do |pos, p|
      GamePiece.new(p, pos)
    end
  end

  def apply(movement)
    out = self.clone
    out.move_piece!(movement)
    out
  end
  
  def move_piece!(movement)
    @pieces[movement.to] = @pieces.delete(movement.from)
  end

  def unobstructed_path_between?(from, to)
    path_between(from, to).all? { |p| free?(p) }
  end

  def free?(pos)
    piece_at(pos).nil?
  end

  def path_between(from, to)
    out = []
    dest_col = to[0].ord
    dest_row = to[1].ord
    p = from
    while p != to
      col = p[0].ord
      row = p[1].ord

      col += 1 if col < dest_col
      col -= 1 if col > dest_col

      row += 1 if row < dest_row
      row -= 1 if row > dest_row

      p = col.chr + row.chr
      out << p unless p == to
    end
    out
  end

  def threatened?(position)
    piece = piece_at(position)
    opponents(piece).any? do |o|
      move = Move.new(Movement.new(o.position, position), o.piece, self)
      v = Rulebook.move_validator_for(move)
      v.valid_movement? && v.valid_path?
    end
  end

  def to_s
    (1..8).to_a.reverse.map do |row|
      row.to_s + "  " + 
        ("a".."h").map do |col|
        p = piece_at("#{col}#{row}")
        p ? p.identity : "--"        
      end.join(" ")
    end.join("\n") + "\n   a  b  c  d  e  f  g  h"
  end

  def clone
    super.tap do
      @pieces = @pieces.clone
    end
  end
end
